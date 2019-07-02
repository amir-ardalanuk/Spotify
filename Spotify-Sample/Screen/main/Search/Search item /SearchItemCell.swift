//
//  SearchItemCell.swift
//  Spotify-Sample
//
//  Created by Amir Ardalan on 7/1/19.
//  Copyright © 2019 Amir Ardalani. All rights reserved.
//

import UIKit
import RxSwift

struct SearchItemCellModel {
    var img : String?
    var desc : String?
    var title : String?
}
class SearchItemCell: UITableViewCell,ReusableView {

    @IBOutlet weak var imgContent: UIImageView!
    @IBOutlet weak var lblDescribtion: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    var bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    
    func config(model : SearchItemCellModel){
        Observable.just(model.img).bind(to: imgContent.rx.imageStr).disposed(by: bag)
        Observable.just(model.title).bind(to: lblTitle.rx.text).disposed(by: bag)
        Observable.just(model.desc).bind(to: lblDescribtion.rx.text).disposed(by: bag)
        
    }

}
