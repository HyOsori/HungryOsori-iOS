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
    var crawler_id: String?
    var title: String?
    var description: String?
    var thumbnail_url: String?
    var link_url: String?
    
    init(crawler_id: String, title: String, description: String, thumbnail_url: String, link_url: String) {
        self.crawler_id = crawler_id
        self.title = title
        self.description = description
        self.thumbnail_url = thumbnail_url
        self.link_url = link_url
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        crawler_id                  <- map["crawler_id"]
        title                       <- map["title"]
        description                 <- map["description"]
        thumbnail_url               <- map["thumbnail_url"]
        link_url                    <- map["link_url"]
    }
}

class Subscriptions : Mappable {
    var crawler: String?
    var latest_pushtime: String?
    var subscriber: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        crawler                     <- map["crawler"]
        latest_pushtime             <- map["latest_pushtime"]
        subscriber                  <- map["subscriber"]
    }
}


