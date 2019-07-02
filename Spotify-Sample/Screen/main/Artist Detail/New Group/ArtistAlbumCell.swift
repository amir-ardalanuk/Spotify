//
//  ArtistAlbumCell.swift
//  Spotify-Sample
//
//  Created by Amir Ardalan on 7/2/19.
//  Copyright © 2019 Amir Ardalani. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ArtistAlbumCell: UICollectionViewCell, ReusableView , NibLoadable{
    
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgAlbum: UIImageView!
    
    var bag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.bag = DisposeBag()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(album : Album) {
        Observable.just(album.name).bind(to: self.lblTitle.rx.text).disposed(by: bag)
        Observable.just(album.releaseDate).bind(to: self.lblDesc.rx.text).disposed(by: bag)
        Observable.just(album.images?.first?.url ).bind(to: self.imgAlbum.rx.imageStr).disposed(by: bag)
        
    }

}
