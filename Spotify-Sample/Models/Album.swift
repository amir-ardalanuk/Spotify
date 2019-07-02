//
//  Album.swift
//  Spotify-Sample
//
//  Created by Amir Ardalan on 7/2/19.
//  Copyright © 2019 Amir Ardalani. All rights reserved.
//

import Foundation
import ObjectMapper

class Album :  Mappable{
    
    var albumType : String?
    var artists : [ArtistItem]?
    var availableMarkets : [String]?
    var externalUrls : ExternalUrl?
    var href : String?
    var id : String?
    var images : [ImageModel]?
    var name : String?
    var releaseDate : String?
    var releaseDatePrecision : String?
    var totalTracks : Int?
    var type : String?
    var uri : String?
    
    
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        albumType <- map["album_type"]
        artists <- map["artists"]
        availableMarkets <- map["available_markets"]
        externalUrls <- map["external_urls"]
        href <- map["href"]
        id <- map["id"]
        images <- map["images"]
        name <- map["name"]
        releaseDate <- map["release_date"]
        releaseDatePrecision <- map["release_date_precision"]
        totalTracks <- map["total_tracks"]
        type <- map["type"]
        uri <- map["uri"]
    }
}
