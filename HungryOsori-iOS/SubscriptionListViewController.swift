//
//  SubscriptionListViewController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 7. 12..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import UIKit
import Alamofire

class SubscriptionListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet
    var crawlerTableView: UITableView!
    var subscriptions = []
    var final_array = [Crawler]()
    var unscribe_id:String?
    var subcount : Int?
    var temp_crawler_list = [Crawler]()
    var crawlers:Crawlers? = Crawlers()

    override func viewDidLoad() {
        for i in 0...4
        {
            let temp_id = ShareData.sharedInstance.entireList[i].id
            let temp_title = ShareData.sharedInstance.entireList[i].title
            let temp_des = ShareData.sharedInstance.entireList[i].description
            let temp_image = ShareData.sharedInstance.entireList[i].thumbnailURL
            
            temp_crawler_list.append(Crawler(id: temp_id, title: temp_title, description: temp_des, image: temp_image))
        }
        subscriptions = []
        
        if((userID.isEmpty == false) && (userKey.isEmpty == false))
        {
            makePostRequestSubscribeList()
            
        }
        self.crawlerTableView.reloadData()
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        subscriptions = []
        
        if((userID.isEmpty == false) && (userKey.isEmpty == false))
        {
            makePostRequestSubscribeList()
            
        }
        self.crawlerTableView.reloadData()
    }
    func makePostRequestSubscribeList(){
        Alamofire.request(.POST, string_url+"/req_subscription_list", parameters: ["user_id" : userID, "user_key" : userKey]).responseJSON { (response) in
            do {
                let JsonData =  try NSJSONSerialization.JSONObjectWithData(response.data!, options: .MutableContainers) as? NSDictionary
                
                if let parseJSON = JsonData {
                    self.subscriptions = (parseJSON["subscriptions"])! as! NSArray
                }
                self.subcount = self.subscriptions.count
                print(self.subscriptions)
                self.final_array = []
                for i in 0...4
                {
                    if (self.subcount == 0)
                    {
                        break
                    }
                    else
                    {
                        for j in 0...(self.subcount!-1)
                        {
                            if ((self.temp_crawler_list[i].id) == self.subscriptions[j] as! String)
                            {
                                let id:String?  = self.temp_crawler_list[i].id
                                let title:String? = self.temp_crawler_list[i].title
                                let des:String? = self.temp_crawler_list[i].description
                                let image:String? = self.temp_crawler_list[i].thumbnailURL
                                self.final_array.append(Crawler(id: id! , title: title!, description: des!
                                    , image: image!))
                            }
                        }
                    }
                }
            } catch {
                print(error)
            }
            self.crawlerTableView.reloadData()
        }
    }
    func makePostRequestUnsubscrcibe(){
        let subid = unscribe_id!
        Alamofire.request(.POST, string_url+"/req_unsubscribe_crawler", parameters: ["user_id" : userID, "user_key" : userKey,"crawler_id" : subid]).responseString { (response) in
        }
        self.crawlerTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
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
        let subcell = crawlerTableView.dequeueReusableCellWithIdentifier("subcell", forIndexPath: indexPath) as! SubscribeTableViewCell
        let cc = self.final_array[indexPath.row]
        
        subcell.subtitle.text = cc.title
        subcell.subdes.text = cc.description
        let unwrapped:String = cc.thumbnailURL
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
        let id = self.final_array[sender.tag].id
        let title =  self.final_array[sender.tag].title
        let description = self.final_array[sender.tag].description
        let image =  self.final_array[sender.tag].thumbnailURL
        ShareData.sharedInstance.unsubscriptionList.append(Crawler(id: id, title: title, description: description, image: image))
        self.final_array.removeAtIndex(sender.tag)
        makePostRequestUnsubscrcibe()
        self.subcount! -= 1
        self.crawlerTableView.reloadData()
    }
   
}
