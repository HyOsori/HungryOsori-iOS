//
//  SecondViewController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 7. 12..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet
    var tableview2:UITableView!
    
    public struct Crawler
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
    
    public struct Crawlers
    {
        var crawlers = [String:Crawler]()
        var crawler_list = [Osori]()
        
        init(jsonString:String)
        {
            let data: NSData = jsonString.dataUsingEncoding(NSUTF8StringEncoding)!
            
            do
            {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                if json["error"] as! Int == 0
                {
                    for jsonCrawler in (json["crawlers"] as! [AnyObject])
                    {
                        let newCrawler = Crawler(json:(jsonCrawler as! [String : AnyObject]))
                        crawlers[newCrawler.id] = newCrawler
                        
                        crawler_list.append(Osori(id: newCrawler.id, title: newCrawler.title, description: newCrawler.description, image: newCrawler.thumbnailURL))
                        NSUserDefaults.standardUserDefaults().setObject(newCrawler.id, forKey: "Subscribe_id")
                        NSUserDefaults.standardUserDefaults().synchronize()
                    
                    }
                    
                }
               
                for i in 0...4{
                let iid:String?  = self.crawler_list[i].id
                let ttile:String? = self.crawler_list[i].title
                let ddes:String? = self.crawler_list[i].description
                let iimage:String? = self.crawler_list[i].image
                ShareData.sharedInstance.entireList.append(Osori(id: iid!, title: ttile!, description: ddes!, image: iimage!))
                print("second view crawler liest \(self.crawler_list[i].title)")
                }
            }
            catch
            {
                print("error serializing JSON: \(error)")
            }
        }
    }
    
    
    var crawlers:Crawlers?

    let userID = NSUserDefaults.standardUserDefaults().stringForKey("New_user_id")
    let userKey = NSUserDefaults.standardUserDefaults().stringForKey("New_user_key")
    var Crawler:String?
    var imageURL:UIImageView?
    var realimage:UIImage?
    var count:Int?
    var sub_id_for_reqe:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if((userID != nil) && (userKey != nil))
        {
            makePostRequest()
        }
        
    }
    
    func makePostRequest(){
        let request = NSMutableURLRequest(URL: NSURL(string: "http://0.0.0.0:8000/req_entire_list")!)
        
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        
        let postString:String = "user_id=\(userID!)&user_key=\(userKey!)"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            
            self.crawlers = Crawlers(jsonString: responseString as! String)
            self.count = (self.crawlers?.crawler_list.count)!
            self.tableview2.reloadData()
        }
        task.resume()
    }
    func makePostRequestScrcibe(){
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://0.0.0.0:8000/req_subscribe_crawler")!)
        let subid = sub_id_for_reqe
        
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        
        let postString:String = "user_id=\(userID!)&user_key=\(userKey!)&crawler_id=\(subid!)"
        
        
        print("subscribe_postString! : \(postString)!")
        
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        let task2 = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString2 = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("Subscribe_responseString!! \(responseString2)")
        }
        task2.resume()
        
        
    }

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (count == nil)
        {
            return 0
        }
        else{
            return count!
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell2 = tableview2.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath) as! MyTableViewCell
        let cc = self.crawlers!.crawler_list[indexPath.row]
    
        cell2.title.text = cc.title
        cell2.des.text = cc.description
        let unwrapped: String = cc.image
        let url = NSURL(string : unwrapped)!

        if let data = NSData(contentsOfURL: url)
        {
            if let realimage = UIImage(data: data)
                {
                    cell2.imageurlresult.image = realimage
                    if(cell2.imageurlresult == nil)
                    {
                        print("nillllll")
                    }
                }
        }
        cell2.subscribeButton.tag = indexPath.row
            return cell2
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? FirstViewController
        {
            print(self.crawlers?.crawler_list)
            for i in 0...4{
            destination.crawlers?.osori4[i] = (self.crawlers?.crawler_list[i])!
            print("dess\(destination.crawlers!.osori4[i])")
                
    }
        }
    }
 */
    
    @IBAction func subscribebutton(sender: UIButton) {
        sub_id_for_reqe = self.crawlers?.crawler_list[sender.tag].id
        makePostRequestScrcibe()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

