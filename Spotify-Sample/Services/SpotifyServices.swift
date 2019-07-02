//
//  SpotifyServices.swift
//  Spotify-Sample
//
//  Created by Amir Ardalan on 7/2/19.
//  Copyright © 2019 Amir Ardalani. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class SpotifyServices : NetworkWrapper {
    static let shared = SpotifyServices()
    private init(){}
    
    func search(param : SearchParam) -> Observable<Result<SearchResponse>>{
        print(param.toJSON())
        return request(url: Route.search.url,
                       param: param.toJSON(),
                       method: HTTPMethod.get,
                       encoding: URLEncoding.default,
                       hasToken: true)
    }
    
    func artistAlbum(by id : String) -> Observable<Result<AlbumResponse>>{
        return request(url: Route.artist.url + "/\(id)/albums",
                       param:nil,
                       method: HTTPMethod.get,
                       encoding: URLEncoding.default,
                       hasToken: true)
    }
}
