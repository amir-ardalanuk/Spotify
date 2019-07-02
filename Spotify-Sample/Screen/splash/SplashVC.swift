//
//  SplashVC.swift
//  Spotify-Sample
//
//  Created by Amir Ardalan on 7/2/19.
//  Copyright © 2019 Amir Ardalani. All rights reserved.
//

import UIKit
import RxSwift
import SpotifyLogin

class SplashVC: UIViewController {

    @IBOutlet weak var imgSpotify: UIImageView!
    
    let isTimerFinish = PublishSubject<Bool>()
    let hasAccessToken = PublishSubject<Bool>()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        combineTimerAndTokenSubject()
        delayForSplash()
        checkAccessToken()
        
    }
    
    func combineTimerAndTokenSubject(){
        Observable.combineLatest(isTimerFinish.asObservable(), hasAccessToken.asObservable()) { (timer, hasAccess) -> Bool in
            print(timer,hasAccess)
            return hasAccess
            }.single().subscribe(onNext: { (hasAccessToken) in
                self.routing(with: hasAccessToken)
            }).disposed(by: bag)
    }
    
    func delayForSplash(){
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
           self.isTimerFinish.onNext(true)
        timer.invalidate()
        }
    }
    
    func checkAccessToken(){
        SpotifyLogin.shared.getAccessToken { (accessToken, error) in
            guard let token = accessToken else {
                self.hasAccessToken.onNext(false)
                return
            }
            AccessTokenDAL.shared.set(key: token)
            self.hasAccessToken.onNext(true)
        }
    }
    
    func routing(with hasAccessToken : Bool){
        var destinationVC : UIViewController?
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        if hasAccessToken {
            destinationVC = mainStoryBoard.instantiateViewController(withIdentifier: "SearchVC")
        }else{
            destinationVC = mainStoryBoard.instantiateViewController(withIdentifier: "LoginVC")
        }
        UIApplication.shared.keyWindow?.rootViewController =  destinationVC
    }
    
}
