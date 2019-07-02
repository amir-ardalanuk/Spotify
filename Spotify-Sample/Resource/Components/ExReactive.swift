

//
//  File.swift
//  Tarabar
//
//  Created by Amir Ardalan on 4/23/18.
//  Copyright © 2018 Golrang. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit
import Kingfisher
extension Reactive where Base: UIView {
    
    var isExpand: Binder<Bool> {
        return Binder(self.base, binding: { (view, data) in
            
            if data {
                UIView.transition(with: view, duration: 0.5, options: UIView.AnimationOptions.transitionFlipFromBottom, animations: {
                    view.isHidden = data
                    view.alpha = 0
                })
            } else {
                UIView.transition(with: view, duration: 0.5, options: UIView.AnimationOptions.transitionFlipFromTop, animations: {
                    view.isHidden = data
                    view.alpha = 1
                })
            }
        })
    }
    
}




extension Reactive where Base: UIImageView {
   
    var imageStr: Binder<String?> {
        return Binder(self.base, binding: { (view, data) in
            guard let url = URL(string: data ?? "") else {return}
            view.kf.setImage(with: url)
        })
    }
    var image: Binder<UIImage?> {
        return Binder(self.base, binding: { (view, data) in
            view.image = data
        })
    }
}
