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
    var subscriptions : NSArray = []
    var final_array = [Crawler]()
    var unscribe_id:String?
    var subcount = 0
    var temp_crawler_list = [Crawler]()
    var crawlers:Crawlers? = Crawlers()
    var responsestring:NSString?

    override func viewDidLoad() {
        for i in 0...2
        {
            let temp_id = ShareData.sharedInstance.entireList[i].id
            let temp_title = ShareData.sharedInstance.entireList[i].title
            let temp_des = ShareData.sharedInstance.entireList[i].description
            let temp_image = ShareData.sharedInstance.entireList[i].thumbnailURL
            
            temp_crawler_list.append(Crawler(id: temp_id, title: temp_title, description: temp_des, image: temp_image))
        }
        subscriptions = []
        if((userID?.isEmpty == false) && (userKey?.isEmpty == false))
        {
            makePostRequestSubscribeList()
            
        }
        self.crawlerTableView.reloadData()
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.subcount = 0
        self.final_array.removeAll()
        
        if((userID?.isEmpty == false) && (userKey?.isEmpty == false))
        {
            makePostRequestSubscribeList()
            
        }
        self.crawlerTableView.reloadData()
    }
    
    func makePostRequestSubscribeList(){
        Alamofire.request(string_url+"/subscription/",method: .post,  parameters: ["user_id" : userID!, "user_key" : userKey!]).responseString { (response) in
            print("subscription result : \(response.result)")
            switch response.result {
            case .success(let data):
                print(data)
                let tempdata : Data? = data.data(using: .utf8)
                let js = try? JSONSerialization.jsonObject(with: tempdata!, options: .allowFragments) as! [String : AnyObject]
                
                if let temp_subscriptions = js?["subscriptions"] as? [AnyObject] {
                    print(temp_subscriptions)
                    for temp_sub in temp_subscriptions {
                        let v = ((temp_sub["crawler_id"])! as? String)
                        
                        
                        for i in 0...(self.temp_crawler_list.count - 1){
                            if ((self.temp_crawler_list[i].id) == v)// as! String)
                            {
                                let id:String?  = self.temp_crawler_list[i].id
                                let title:String? = self.temp_crawler_list[i].title
                                let des:String? = self.temp_crawler_list[i].description
                                let image:String? = self.temp_crawler_list[i].thumbnailURL
                                self.final_array.append(Crawler(id: id! , title: title!, description: des!,image: image!))
                                self.subcount += 1
                                //self.subscriptions.
                            }
                        }
                    }
                    self.crawlerTableView.reloadData()
                }
            case .failure :
                print("fail")
                
            }
        }
    }
    
    
    func makePostRequestUnsubscrcibe(){
        let subid = unscribe_id!
        print("sub id : \(subid)")
        
        Alamofire.request(string_url+"/subscription/", method: .delete, parameters: ["user_id" : userID!, "user_key" : userKey!,"crawler_id" : subid], encoding: URLEncoding.httpBody).responseString { (response) in
            print("unsubscription result : \(response.result)")
            print("response for unsubscribe : \(response)")
            switch response.result {
            case .success(let data):
                print("succcccccccesssss")
            case .failure :
                print("fail")
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (subcount == 0)
        {
            return 0
        }
        else
        {
            return self.subcount
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let subcell = crawlerTableView.dequeueReusableCell(withIdentifier: "subcell", for: indexPath) as! SubscribeTableViewCell
        let cc = self.final_array[(indexPath as NSIndexPath).row]
        
        subcell.subtitle.text = cc.title
        subcell.subdes.text = cc.description
        subcell.unsubscribeButton.tag = (indexPath as NSIndexPath).row
        
        return subcell
    }
    
    @IBAction func unsubscribeButton(_ sender: AnyObject) {
        unscribe_id = self.final_array[sender.tag].id
        let id = self.final_array[sender.tag].id
        let title =  self.final_array[sender.tag].title
        let description = self.final_array[sender.tag].description
        let image =  self.final_array[sender.tag].thumbnailURL
        ShareData.sharedInstance.unsubscriptionList.append(Crawler(id: id, title: title, description: description, image: image))
        
        
        self.final_array.remove(at: sender.tag)
        makePostRequestUnsubscrcibe()
        self.subcount -= 1
        self.crawlerTableView.reloadData()
    }
   
}
