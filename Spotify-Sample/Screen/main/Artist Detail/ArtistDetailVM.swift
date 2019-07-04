//
//  ArtistDetailVM.swift
//  Spotify-Sample
//
//  Created by Amir Ardalan on 7/2/19.
//  Copyright © 2019 Amir Ardalani. All rights reserved.
//

import Foundation
import RxSwift
class ArtistDetailVM : BaseViewModel {
    
    enum State {
        case loading(Bool)
        case albumNotFound
        case albumLoading
        case albumData([Album])
    }
    
    let onChange = PublishSubject<State>()
    
    let artist = BehaviorSubject<ArtistItem?>(value: nil)
    
    var artisCover : Observable<String?> {
        return artist.asObservable().map{$0?.images?.first?.url}
    }
    
    var artisThumb : Observable<String?> {
        return artist.asObservable().map{$0?.images?.last?.url}
    }
    
    var txtGenre : Observable<String?>{
        return artist.asObservable().map{$0?.genres?.joined(separator: ",") ?? "genres not exist"}
    }
    
    var txtName : Observable<String?>{
        return artist.asObservable().map{$0?.name ?? " - " }
    }
    
    var txtIntroduce : Observable<String?> {
        return artist.asObservable().map{"popularity : \($0?.popularity ?? 0) , followers : \($0?.followers?.total ?? 0)"}
    }
    
    func getAlbums(){
        self.onChange.onNext(ArtistDetailVM.State.loading(true))
        do {
            let id = try! self.artist.value()?.id
            SpotifyServices.shared.artistAlbum(by: id ?? "" ).subscribe(onNext: { (res) in
                self.onChange.onNext(.loading(false))
                switch res {
                    
                case .success(let val):
                    self.fetchData(album: val)
                case .failure(let er):
                    self.catchError(error: er, tryAgain: {
                        self.getAlbums()
                    })
                }
            }).disposed(by: bag)
        } catch (let error){
            self.catchError(error: error, tryAgain: {
                self.getAlbums()
            })
            self.onChange.onNext(.loading(false))
        }
    }
    
    func fetchData(album : AlbumResponse){
        if let list = album.items , list.count > 0  {
            self.onChange.onNext(.albumData(list))
        }else{
            self.onChange.onNext(.albumNotFound)
        }
    }
}
