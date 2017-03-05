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
    let link_url: String
    
    init(json:[String:AnyObject])
    {
        self.id = json["crawler_id"] as! String
        self.title = json["title"] as! String
        self.description = json["description"] as! String
        self.thumbnailURL = json["thumbnail_url"] as! String
        self.link_url = json["link_url"] as! String
    }
    init(jso:[String:AnyObject])
    {
        self.id = jso["crawler_id"] as! String
        self.title = jso["title"] as! String
        self.description = jso["description"] as! String
        self.thumbnailURL = jso["thumbnail_url"] as! String
        self.link_url = jso["link_url"] as! String
    }
    
    init(id:String, title : String, description: String, image : String, link_url : String)
    {
        self.id = id
        self.title = title
        self.description = description
        self.thumbnailURL = image
        self.link_url = link_url
    }
}
