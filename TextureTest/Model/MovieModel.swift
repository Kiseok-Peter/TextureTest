//
//  MovieModel.swift
//  TextureTest
//
//  Created by 박기석 on 2020/01/02.
//  Copyright © 2020 Peter. All rights reserved.
//

import ObjectMapper

struct MovieModel: Mappable {
    
    var items: [MovieItem]
    
    init?(map: Map) {
        items = []
    }
    
    mutating func mapping(map: Map) {
        items    <- map["items"]
    }
}

struct MovieItem: Mappable {
    
    var title: String
    var image: String
    
    init?(map: Map) {
        title = ""
        image = ""
    }
    
    mutating func mapping(map: Map) {
        title   <- map["title"]
        image   <- map["image"]
    }
}
