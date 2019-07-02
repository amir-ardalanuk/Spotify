//
//  ArtistDetailVC.swift
//  Spotify-Sample
//
//  Created by Amir Ardalan on 7/1/19.
//  Copyright © 2019 Amir Ardalani. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ArtistDetailVC: UIViewController {

    let vm = ArtistDetailVM()
    let bag = DisposeBag()
    var albumsList = [Album]()
    
    @IBOutlet weak var vwEmptyAlbums: EmptyView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var vwAlbumsLoading: UIActivityIndicatorView!
    @IBOutlet weak var vwShare: CustomView!{
        didSet{
            vwShare.tap = {
                self.shareLink()
            }
        }
    }
    @IBOutlet weak var vwDismiss: CustomView!{
        didSet{
            vwDismiss.tap = {
                self.dismiss(animated: true)
            }
        }
    }
    
    @IBOutlet weak var albumsCollection: UICollectionView!{
        didSet{
            albumsCollection.delegate = self
            albumsCollection.dataSource = self
            albumsCollection.register(ArtistAlbumCell.self)
        }
    }
    
    @IBOutlet weak var lblGenre: UILabel!{
        didSet{
            self.vm.txtGenre.bind(to: lblGenre.rx.text).disposed(by: bag)
        }
    }
    @IBOutlet weak var lblIntroduce: UILabel!{
        didSet{
             self.vm.txtIntroduce.bind(to: lblIntroduce.rx.text).disposed(by: bag)
        }
    }
    @IBOutlet weak var lblTitle: UILabel!{
        didSet{
             self.vm.txtName.bind(to: lblTitle.rx.text).disposed(by: bag)
        }
    }
    @IBOutlet weak var imgThumb: UIImageView!{
        didSet{
              self.vm.artisThumb.bind(to: imgThumb.rx.imageStr).disposed(by: bag)
        }
    }
    @IBOutlet weak var imgCover: UIImageView!{
        didSet{
               self.vm.artisCover.bind(to: imgCover.rx.imageStr).disposed(by: bag)
        }
    }
    @IBOutlet weak var vwCoverImage: FooterGradientView!{
        didSet{
             vwCoverImage.setCustomGradient(colors: [.clear,.black])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm.getAlbums()
        self.subscribe()
    }
    
    func subscribe() {
        self.vm.onChange.subscribe(onNext: { (state) in
            switch state {
                
            case .loading(let loading):
                self.vwAlbumsLoading.isHidden = !loading
            case .albumNotFound:
                self.vwEmptyAlbums.isHidden = false
                
            case .albumLoading:break
               
            case .albumData(let data):
                self.albumsList = data
                self.albumsCollection.reloadData()
            }
        }).disposed(by: bag)
    }
    func shareLink() {
        do {
            let uri = try! self.vm.artist.value()?.externalUrls?.spotify
            if let url = URL(string: uri ?? ""){
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    

}


extension ArtistDetailVC : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ArtistAlbumCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        let album = self.albumsList[indexPath.row]
        cell.config(album: album)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 160)
    }
}
