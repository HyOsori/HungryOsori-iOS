//
//  CrawlerListViewController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 7. 12..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import UIKit

class CrawlerListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet
    var crawlerTableview:UITableView!
    
    var crawlers:Crawlers? = Crawlers()

    let userID = NSUserDefaults.standardUserDefaults().stringForKey("New_user_id")
    let userKey = NSUserDefaults.standardUserDefaults().stringForKey("New_user_key")
    var imageURL:UIImageView?
    var realimage:UIImage?
    var count:Int?
    var sub_id_for_reqe:String?
    var temp_unsubscription = [String]()
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        

        if((userID != nil) && (userKey != nil))
        {
            makePostRequest()
        }
        
        
    }
    override func viewWillAppear(animated: Bool) {
        self.crawlerTableview.reloadData()
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
            
            for i in 0...4{
                let id:String?  = self.crawlers!.crawler_list[i].id
                let title:String? = self.crawlers!.crawler_list[i].title
                let des:String? = self.crawlers!.crawler_list[i].description
                let image:String? = self.crawlers!.crawler_list[i].thumbnailURL
                ShareData.sharedInstance.entireList.append(Crawler(id: id!, title: title!, description: des!, image: image!))
            }
            self.count = (self.crawlers!.crawler_list.count)
            self.crawlerTableview.reloadData()
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
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
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
        let cell2 = crawlerTableview.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath) as! MyTableViewCell
        let cc = self.crawlers!.crawler_list[indexPath.row]
    
        cell2.title.text = cc.title
        cell2.des.text = cc.description
        
        //var temp_count = ShareData.sharedInstance.unsubscriptionList.count
        
        if(ShareData.sharedInstance.unsubscriptionList.count != 0)
        {
            for j in 0...(ShareData.sharedInstance.unsubscriptionList.count-1)
            {
                if(cc.id == ShareData.sharedInstance.unsubscriptionList[j].id)
                {
                    cell2.subscribeButton.setTitle("구독", forState: .Normal)

                }
            }
        }
        
        let unwrapped: String = cc.thumbnailURL
        let url = NSURL(string : unwrapped)!

        if let data = NSData(contentsOfURL: url)
        {
            if let realimage = UIImage(data: data)
                {
                    cell2.imageurlresult.image = realimage
                    if(cell2.imageurlresult == nil)
                    {
                        print("nil")
                    }
                }
        }
        cell2.subscribeButton.tag = indexPath.row
            return cell2
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    @IBAction func subscribebutton(sender: UIButton) {
        sender.setTitle("해제", forState: .Normal)
        
        sub_id_for_reqe = self.crawlers?.crawler_list[sender.tag].id
        makePostRequestScrcibe()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

