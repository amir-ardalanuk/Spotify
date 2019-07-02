//
//  ViewController.swift
//  Spotify-Sample
//
//  Created by Amir Ardalan on 7/1/19.
//  Copyright © 2019 Amir Ardalani. All rights reserved.
//

import UIKit
import SpotifyLogin
class LoginVC: UIViewController {

    @IBOutlet weak var btnLogin : SpotifyLoginButton!{
        didSet{
            btnLogin.addTarget(self, action: #selector(onLoginClicked), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccessful), name: .SpotifyLoginSuccessful, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    @objc func onLoginClicked(){
         SpotifyLoginPresenter.login(from: self, scopes: [])
    }

    
    @objc func loginSuccessful(){
        SpotifyLogin.shared.getAccessToken { (accessToken, error) in
            guard let token = accessToken else{
                //TODO: Show Message To User
                return
            }
            AccessTokenDAL.shared.set(key: token)
            self.routeToSearch()
            
        }
    }
    func routeToSearch(){
        var destinationVC : UIViewController?
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        destinationVC = mainStoryBoard.instantiateViewController(withIdentifier: "SearchVC")
        UIApplication.shared.keyWindow?.rootViewController =  destinationVC
    }
}

