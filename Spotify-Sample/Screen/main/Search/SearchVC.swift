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
           tableview.register(SearchItemCell.self)
            tableview.dataSource = searchDataSource
        }
    }
    
    let searchDataSource = SearchDataSource()
    let vwNotice         = SearchNoticeView()
    
    
    lazy var vwEmpty : EmptyView = {
      return EmptyView()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.tableFooterView = vwEmpty
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
class SearchDataSource : NSObject , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SearchItemCell = tableView.dequeueReusableCell(indexPath: indexPath)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
