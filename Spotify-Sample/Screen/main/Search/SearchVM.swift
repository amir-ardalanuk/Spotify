//
//  SearchVM.swift
//  Spotify-Sample
//
//  Created by Amir Ardalan on 7/2/19.
//  Copyright © 2019 Amir Ardalani. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchVM : BaseViewModel,ReactiveCompatible {
    
    enum State {
        case loading(Bool)
        case dataNotExist
        case notConnected
        case itemLoaded([SearchItemCellModel])
    }
    
    let onChange = PublishSubject<State>()
    let txtSearch = PublishSubject<String?>()
    var artisList = [ArtistItem]()
    
    override var loading: Bool {
        didSet{
            self.onChange.onNext(SearchVM.State.loading(loading))
        }
    }
    
    override init() {
        super.init()
    }
    
    func searchItem(with text : String?){
        loading = true
        let searchParam = SearchParam(type: .artist, query: text)
        SpotifyServices.shared.search(param: searchParam).subscribe(onNext: { (result) in
            self.loading = false
            switch result {
            case .success(let val):
               self.fetchData(res: val)
            case .failure(let er):
                self.catchError(error: er, tryAgain: {
                    self.searchItem(with: text)
                })
            }
        }).disposed(by: bag)
    }
    
    func fetchData(res : SearchResponse){
        guard let list = isDataExist(for : res) else {
            self.onChange.onNext(SearchVM.State.dataNotExist)
            return
        }
        artisList = list
        let convertToSearchCellModel = list.map{(item) -> SearchItemCellModel in
            
            let popularity = "popularity \(item.popularity ?? 0)"
            return SearchItemCellModel(id : item.id,
                                       img: item.images?.first?.url ?? "",
                                       desc: popularity,
                                       title: item.name)
        }
        self.onChange.onNext(SearchVM.State.itemLoaded(convertToSearchCellModel))
    }
    
    func isDataExist(for res : SearchResponse) -> [ArtistItem]?{
        if let artist = res.artists ,let list = artist.items , list.count > 0 {
            return list
        }else{
            return nil
        }
    }
    
    
    func findArtist(By id:String?) -> ArtistItem? {
        return self.artisList.filter{$0.id == id}.first
    }
    
    
}
extension Reactive where Base: SearchVM {
    
    var search: Binder<String?> {
        return Binder(self.base, binding: { (view, data) in
            view.searchItem(with: data)
        })
    }
}
