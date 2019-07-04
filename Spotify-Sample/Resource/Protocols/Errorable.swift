//
//  Errorable.swift
//  Tarabar
//
//  Created by Amir Ardalan on 7/4/18.
//  Copyright © 2018 Golrang. All rights reserved.
//

import Foundation
import RxSwift

enum Exception {
    case noAuthenticate
    case failure(message: String)
    case logout
    case timeout
}

protocol Errorable {
    var onError: PublishSubject<Exception> {get set}
}

extension Errorable {
    
    func showMessage(title : String = "", message : String? = "" ,completion: (() -> Void)? = nil)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "تلاش مجدد", style: .default, handler: { _ in
            if let _ = completion {
                completion!()
            }
        })
        
        alertController.addAction(action)
        alertController.view.tintColor = UIColor.gray
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func catchError(error: Error , tryAgain :@escaping () -> Void) {
        guard let e = error as? SpotifyError else {
            showMessage(title: error.localizedDescription, message: nil)
            return
        }
        switch e {
        case .failure(let message ) :
            showMessage(title: message, message: nil)
        case .timeout:
            showMessage(title: "we couldn't found any connection", message: nil, completion: tryAgain)
        case .notConnected:
            showMessage(title: "we couldn't found any connection", message: nil, completion: tryAgain)
        default: self.onError.onNext(.failure(message: (error as! SpotifyError).localization))
        }
    }
}
