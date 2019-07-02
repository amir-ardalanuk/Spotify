//
//  SearchVC.swift
//  Spotify-Sample
//
//  Created by Amir Ardalan on 7/1/19.
//  Copyright © 2019 Amir Ardalani. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class SearchVC: UIViewController {

    let vm = SearchVM()
    let bag = DisposeBag()
    
    @IBOutlet weak var tfSearch: UITextField!{
        didSet{
            tfSearch.rx.text
                .filter{($0 ?? "").count > 2}
                .debounce(.seconds(2), scheduler: MainScheduler.instance)
                .bind(to: vm.rx.search)
                .disposed(by: bag)
        }
    }
    @IBOutlet weak var tableview: UITableView!{
        didSet{
            tableview.separatorStyle = .none
           tableview.register(SearchItemCell.self)
            tableview.dataSource = searchDataSource
        }
    }
    
    let searchDataSource = SearchDataSource()
    let vwNotice         = SearchNoticeView()
    let vwLoading       = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
    
    lazy var vwEmpty : EmptyView = {
      return EmptyView()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.tableFooterView = vwNotice
        
        subscribe()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

    func subscribe(){
        self.vm.onChange.subscribe(onNext: { (state) in
            switch state {
                
            case .loading(let loading):
                self.searchDataSource.cleanData()
                self.tableview.reloadData()
                self.tableview.tableFooterView = loading ? self.vwLoading : nil
            case .dataNotExist:
                self.tableview.tableFooterView = self.vwEmpty
            case .notConnected:
                break
            case .itemLoaded(let data):
                self.searchDataSource.insetData(artistList: data)
                self.tableview.reloadData()
            }
        }).disposed(by: bag)
    }
}

class SearchDataSource : NSObject , UITableViewDataSource {
    
    var searchModel = [SearchItemCellModel]()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SearchItemCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.config(model: searchModel[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchModel.count
    }
    
    
    func insetData(artistList : [SearchItemCellModel] ){
        self.searchModel = artistList
    }
    
    func cleanData(){
        self.searchModel = []
    }
    
}
extension Reactive where Base: SearchDataSource {
    
    var setData: Binder<[SearchItemCellModel]?> {
        return Binder(self.base, binding: { (base, list) in
            base.insetData(artistList: list ?? [])
        })
    }
}
