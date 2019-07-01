//
//  SearchVC.swift
//  Spotify-Sample
//
//  Created by Amir Ardalan on 7/1/19.
//  Copyright © 2019 Amir Ardalani. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var tableview: UITableView!{
        didSet{
            tableview.separatorStyle = .none
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 
}
