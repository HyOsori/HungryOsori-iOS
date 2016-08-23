//
//  Crawler.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 8. 23..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import Foundation


class Crawler
{
    let id:String
    let title:String
    let description:String
    let thumbnailURL:String
    
    init(json:[String:AnyObject])
    {
        self.id = json["crawler_id"] as! String
        self.title = json["title"] as! String
        self.description = json["description"] as! String
        self.thumbnailURL = json["thumbnail_url"] as! String
    }
    
}
