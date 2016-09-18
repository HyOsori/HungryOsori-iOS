//
//  CrawlerListViewController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 7. 12..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
//import Alamofire_Synchronous

class CrawlerListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet
    var crawlerTableview:UITableView!
    var crawlers:Crawlers? = Crawlers()
    
    var imageURL:UIImageView?
    var realimage:UIImage?
    var count:Int?
    var sub_id_for_reqe:String?
    var temp_unsubscription = [String]()
    var temp_pushToken:String?
    var responsestring:NSString?
    var mgr: Alamofire.Manager!
    
    
    override func viewDidLoad() {
        
        
        let refreshedToken = FIRInstanceID.instanceID().token()!
        temp_pushToken = refreshedToken
        print("InstanceID token: \(refreshedToken)")
        super.viewDidLoad()
        mgr = configureManager()
        if((userID.isEmpty == false) && (userKey
            .isEmpty == false))
        {
            makePostRequest()
        }
 
        makePostRequestPush()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.crawlerTableview.reloadData()
    }
    
    func makePostRequestPush(){
        print("user id ! : \(userID)")
        print("user key ! : \(userKey)")
        mgr.request(.POST, string_url+"/register_push_token", parameters: ["user_id" : userID, "user_key" : userKey, "token" : temp_pushToken!]).responseJSON{(requestPush) in
            let pushResult = requestPush.result.value!["message"]
            print("push result!\(pushResult)")
        }
    }

    func makePostRequest(){
        mgr.request(.POST, string_url+"/req_entire_list", parameters: ["user_id" : userID,"user_key" : userKey]).responseString { (response) in
            //print("responseString for entirelist \(response)")
            self.responsestring = NSString(data: response.data!, encoding: NSUTF8StringEncoding)
            self.crawlers = Crawlers(jsonString: (self.responsestring as! String))
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
    }
    
    func makePostRequestScrcibe(){
        let subid = sub_id_for_reqe
        mgr.request(.POST, string_url+"/req_subscribe_crawler", parameters: ["user_id" : userID,"user_key" : userKey,"crawler_id" : subid!]).responseString { (response) in
        }
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

