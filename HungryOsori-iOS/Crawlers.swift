//
//  Crawlers.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2017. 10. 12..
//  Copyright © 2017년 HanyangOsori. All rights reserved.
//

import Foundation
import ObjectMapper

class CrawlerList : Mappable {
    var id: String?
    var title: String?
    var description: String?
    var thumnailURL: String?
    var link_url: String?
    
    init(id: String, title: String, description: String, thumnailURL: String, link_url: String) {
        self.id = id
        self.title = title
        self.description = description
        self.thumnailURL = thumnailURL
        self.link_url = link_url
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        title           <- map["title"]
        description     <- map["description"]
        thumnailURL     <- map["thumnailURL"]
        link_url        <- map["link_url"]
    }
}

