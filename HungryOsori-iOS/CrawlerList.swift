//
//  CrawlerList.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 8. 23..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import Foundation

public struct Crawlers
{
    var crawlers = [String:Crawler]()
    var crawler_list = [Crawler]()
    init()
    {
        
    }
    init(jsonString:String)
    {
        let data: Data = jsonString.data(using: String.Encoding.utf8)!
        
        do
        {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            if json?["ErrorCode"] as! Int == 0
            {
                for jsonCrawler in (json?["crawlers"] as! [AnyObject])
                {
                    let newCrawler = Crawler(json:(jsonCrawler as! [String : AnyObject]))
                    crawlers[newCrawler.id] = newCrawler
                    crawler_list.append(Crawler(id: newCrawler.id, title: newCrawler.title, description: newCrawler.description, image: newCrawler.thumbnailURL, link_url: newCrawler.link_url))
                    
                }
            }
        }
        catch
        {
            print("error serializing JSON: \(error)")
        }
    }
    
    init(jsoString:String)
    {
        let data: Data = jsoString.data(using: String.Encoding.utf8)!
        
        do
        {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            if json?["ErrorCode"] as! Int == 0
            {
                for jsonCrawler in (json?["subscriptions"] as! [AnyObject])
                {
                    let newCrawler = Crawler(jso:(jsonCrawler as! [String : AnyObject]))
                    crawlers[newCrawler.id] = newCrawler
                    crawler_list.append(Crawler(id: newCrawler.id, title: newCrawler.title, description: newCrawler.description, image: newCrawler.thumbnailURL, link_url: newCrawler.link_url))
                    
                }
            }
        }
        catch
        {
            print("error serializing JSON: \(error)")
        }
    }
}
