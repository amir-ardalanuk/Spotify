//
//  SearchDataSource.swift
//  Spotify-Sample
//
//  Created by Amir Ardalan on 7/2/19.
//  Copyright © 2019 Amir Ardalani. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class SearchDataSource : NSObject , UITableViewDataSource {
    
    var searchModel = [SearchItemCellModel]()
    
    var clickedCell = PublishSubject<SearchItemCellModel>()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SearchItemCell = tableView.dequeueReusableCell(indexPath: indexPath)
        let searchItem = searchModel[indexPath.row]
        cell.config(model: searchItem)
        cell.vwContainer.tap = {
            self.clickedCell.onNext(searchItem)
        }
        
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

