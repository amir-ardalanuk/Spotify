//
//  ImageModel.swift
//  Spotify-Sample
//
//  Created by Amir Ardalan on 7/2/19.
//  Copyright © 2019 Amir Ardalani. All rights reserved.
//

import Foundation
import ObjectMapper

class ImageModel : Mappable{
    
    var height : Int?
    var url : String?
    var width : Int?
    
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        height <- map["height"]
        url <- map["url"]
        width <- map["width"]
    }
}
