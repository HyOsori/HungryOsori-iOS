//
//  FirstViewController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 7. 12..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet
    var tableview1: UITableView!
    
    var subscriptions = []
    let userID = NSUserDefaults.standardUserDefaults().stringForKey("New_user_id")
    let userKey = NSUserDefaults.standardUserDefaults().stringForKey("New_user_key")
    var final_array = [Osori]()
    var unscribe_id:String?

    var subcount : Int?
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
        var osori4 = [Osori]()
        
        init()
        {
            
        }
        
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
                        osori4.append(Osori(id: newCrawler.id, title: newCrawler.title, description: newCrawler.description, image: newCrawler.thumbnailURL))
                        
                    }
                }
            }
            catch
            {
                print("error serializing JSON: \(error)")
            }
        }
    }
    
    var crawlers:Crawlers? = Crawlers()

    override func viewDidLoad() {
        for i in 0...4
        {
            let temp_id = ShareData.sharedInstance.entireList[i].id
            let temp_title = ShareData.sharedInstance.entireList[i].title
            let temp_des = ShareData.sharedInstance.entireList[i].description
            let temp_image = ShareData.sharedInstance.entireList[i].image
            self.crawlers?.osori4.append(Osori(id: temp_id, title: temp_title, description: temp_des, image: temp_image))
            print("idid : \(self.crawlers!.osori4[i].title)")
        }
        super.viewDidLoad()
        subscriptions = []
        
        if((userID != nil) && (userKey != nil))
        {
            makePostRequestSubscribeList()
            
        }
    }
    //전체 리스트를 받는 함수
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
        }
        task.resume()
    }

    func makePostRequestSubscribeList(){
        let request = NSMutableURLRequest(URL: NSURL(string: "http://0.0.0.0:8000/req_subscription_list")!)
        
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
            do {
                let JsonData =  try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                
                if let parseJSON = JsonData {
                    self.subscriptions = (parseJSON["subscriptions"])! as! NSArray
                }
                self.subcount = self.subscriptions.count
                print(self.subscriptions)
                print(self.crawlers?.osori4)
                self.final_array = []
                for i in 0...4
                {
                    print("i value : \(i)")
                    if (self.subcount == 0)
                    {
                        break
                    }
                    else
                    {
                        for j in 0...(self.subcount!-1)
                        {
                            print("j value : \(j)")
                            if ((self.crawlers?.osori4[i].id)! == self.subscriptions[j] as! String)
                            {
                                print("entire i value : \(i) + subscribe j value : \(j)")
                                let iid:String?  = self.crawlers?.osori4[i].id
                                let ttile:String? = self.crawlers?.osori4[i].title
                                let ddes:String? = self.crawlers?.osori4[i].description
                                let iimage:String? = self.crawlers?.osori4[i].image
                                self.final_array.append(Osori(id: iid! , title: ttile!, description: ddes!
                                , image: iimage!))// append가 아니라 insert를해야하는지.
                            }
                        }
                    }
                }
            } catch {
                print(error)
            }
            self.tableview1.reloadData()
        }
        task.resume()
    }
    
    
    func makePostRequestUnsubscrcibe(){
        let request = NSMutableURLRequest(URL: NSURL(string: "http://0.0.0.0:8000/req_unsubscribe_crawler")!)
        let subid = unscribe_id
        
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        
        let postString:String = "user_id=\(userID!)&user_key=\(userKey!)&crawler_id=\(subid!)"
        print("Unnnnnnsubscribe_postString! : \(postString)!")
        
        
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
            print("UnSubscribe_responseString!! \(responseString2)")
        }
        task2.resume()
        self.tableview1.reloadData()
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //테이블 뷰에서 뿌려줄 셀의 갯수를 요청할때 사용되는 콜백
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (subcount == nil)
        {
            return 0
        }
        else
        {
            return self.subcount!
        }
    }

    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let subcell = tableview1.dequeueReusableCellWithIdentifier("subcell", forIndexPath: indexPath) as! SubscribeTableViewCell
        print("indexpath.row \(indexPath.row)")
        let cc = self.final_array[indexPath.row]
        print("self osori value \(cc.id)")
        
        subcell.subtitle.text = cc.title
        subcell.subdes.text = cc.description
        let unwrapped:String = cc.image
        let url = NSURL(string: unwrapped)!
        
        if let data = NSData(contentsOfURL : url)
        {
            if let realimage = UIImage(data: data)
            {
                subcell.subimage.image = realimage
                if(subcell.subimage.image == nil)
                {
                    print("threre is no image!!")
                }
            }
        }
        subcell.unsubscribeButton.tag = indexPath.row
        
        return subcell
    }
    
    @IBAction func unsubscribeButton(sender: AnyObject) {
        unscribe_id = self.final_array[sender.tag].id
        print("remove index : \(unscribe_id)")
        self.final_array.removeAtIndex(sender.tag)
        makePostRequestUnsubscrcibe()
        self.subcount! -= 1
        self.tableview1.reloadData()
        //makePostRequestSubscribeList()
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}
