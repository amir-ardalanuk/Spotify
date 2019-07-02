//
//  SearchResponse.swift
//  Spotify-Sample
//
//  Created by Amir Ardalan on 7/2/19.
//  Copyright © 2019 Amir Ardalani. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchResponse : Mappable{
    
    var artists : ArtistResponse?
    var tracks : TrackResponse?

    
    required init?(map: Map){}
    
    
    func mapping(map: Map)
    {
        artists <- map["artists"]
        tracks <- map["tracks"]
    }
    
}
