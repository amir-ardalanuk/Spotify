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
    
    @IBOutlet weak var vwActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tfSearch: UITextField!{
        didSet{
            tfSearch.rx.text
                .filter{($0 ?? "").count > 2}
                .debounce(.seconds(1), scheduler: MainScheduler.instance)
                .bind(to: vm.rx.search)
                .disposed(by: bag)
        }
    }
    @IBOutlet weak var tableview: UITableView!{
        didSet{
            tableview.separatorStyle = .none
            tableview.register(SearchItemCell.self)
            tableview.dataSource = searchDataSource
            tableview.delegate = self
        }
    }
    
    let searchDataSource    = SearchDataSource()
    let vwNotice            = SearchNoticeView()
    let vwLoading           = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let vc as ArtistDetailVC:
            if let artist = sender as? ArtistItem {
                vc.vm.artist.onNext(artist)
            }
        default:break
        }
    }
    

    func subscribe(){
        self.vm.onChange.subscribe(onNext: { (state) in
            switch state {
                
            case .loading(let loading):
                self.searchDataSource.cleanData()
                self.tableview.reloadData()
                self.vwActivityIndicator.isHidden = !loading
            case .dataNotExist:
                self.tableview.tableFooterView = self.vwEmpty
            case .notConnected:
                break
            case .itemLoaded(let data):
                self.searchDataSource.insetData(artistList: data)
                self.tableview.reloadData()
            }
        }).disposed(by: bag)
        
        self.searchDataSource.clickedCell.subscribe(onNext: { (searchModel) in
            let artist = self.vm.findArtist(By: searchModel.id ?? "")
            self.performSegue(withIdentifier: "ArtistDetail", sender:artist)
        }).disposed(by: bag)
    }
    
  
    
}

extension SearchVC : UITableViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
