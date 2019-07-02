//
//  SearchVC.swift
//  Spotify-Sample
//
//  Created by Amir Ardalan on 7/1/19.
//  Copyright © 2019 Amir Ardalani. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchVM : BaseViewModel,ReactiveCompatible {
    enum State {
        case loading(Bool)
        case notFound
        case notConnected
        case itemLoaded([String])
    }
    
    let onChange = PublishSubject<State>()
    let txtSearch = PublishSubject<String?>()
    
    override init() {
        super.init()
//        txtSearch.subscribe(onNext: { (text) in
//            self.searchItem(with)
//        }).disposed(by: bag)
    }
    
    func searchItem(with text : String?){
        
    }
    
}
extension Reactive where Base: SearchVM {
    
    var search: Binder<String?> {
        return Binder(self.base, binding: { (view, data) in
            view.searchItem(with: data)
        })
    }
}
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
