//
//  SubscribedCrawlerController.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2017. 10. 15..
//  Copyright © 2017년 HanyangOsori. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SDWebImage

class SubscribedCrawlerController: UIViewController {
    
    var subscribedCrawlerTableView: UITableView?
    
    var localSubscribeCrawlerList: [CrawlerList]! = []
    
    var localEntireCrawlerList: [CrawlerList]! = []
    var requestToken: String?
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "구독리스트"        
    }
    init(token: String?, entireCrawlerList: [CrawlerList]) {
        super.init(nibName: nil, bundle: nil)
        requestToken = token
        self.title = "구독리스트"
        for crawler in entireCrawlerList {
            localEntireCrawlerList.append(crawler)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(notiSubscribe(_:)), name: .notiSubscribe, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        refreshSubscribe()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SubscribedCrawlerController {
    func notiSubscribe(_ sender: Notification) {
        refreshSubscribe()
    }
    
    func refreshSubscribe() {
        Alamofire.request(serverURL + "/subscription/", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization" : "Token " + requestToken!]).responseJSON { (getSubscribeRes) in
            print("subscription \(getSubscribeRes.result)")
            switch getSubscribeRes.result {
            case.success(let data):
                print("subscription Data \(data)")
                let serverResult = data as! [String: Any]
                let getCrawlerErrorCode = serverResult["ErrorCode"] as! Int
                switch getCrawlerErrorCode {
                case 0:
                    let serverSubscriptionList = Mapper<Subscriptions>().mapArray(JSONArray: serverResult["subscriptions"] as! [[String : Any]])
                    self.localSubscribeCrawlerList.removeAll()
                    for serverSubscription in serverSubscriptionList {
                        for entireCralwer in self.localEntireCrawlerList {
                            if(serverSubscription.crawler == entireCralwer.crawler_id) {
                                self.localSubscribeCrawlerList.append(entireCralwer)
                                break
                            }
                        }
                    }
                    if(self.subscribedCrawlerTableView == nil) {
                        self.subscribedCrawlerTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - (self.tabBarController?.tabBar.frame.height)! - (self.navigationController?.navigationBar.frame.height)! - statusHeight))
                        self.subscribedCrawlerTableView?.delegate = self
                        self.subscribedCrawlerTableView?.dataSource = self
                        self.subscribedCrawlerTableView?.tableFooterView = UIView(frame: .zero)
                        self.subscribedCrawlerTableView?.register(EntireCrawlerCell.self, forCellReuseIdentifier: "EntireCrawlerCell")
                        self.view.addSubview(self.subscribedCrawlerTableView!)
                    } else {
                        self.subscribedCrawlerTableView?.reloadData()
                    }
                case -100:
                    print("크롤러가 한개도 없음...!")
                default:
                    print("서버 에러")
                }
            case.failure(let err):
                print("Err \(err)")
            }
        }
    }
    
    func unsubscribeAction(indexPath: IndexPath) {
        let crawler_id = self.localSubscribeCrawlerList[indexPath.row].crawler_id!
        Alamofire.request(serverURL + "/subscription/", method: .delete, parameters: ["crawler_id": crawler_id], encoding: JSONEncoding.default, headers: ["Authorization" : "Token " + requestToken!]).responseJSON { (unsubscriptionRes) in
            print("unsubscriptionRes result \(unsubscriptionRes.result)")
            switch unsubscriptionRes.result {
            case.success(let data):
                let serverResult = data as! [String: Any]
                print("serverResult \(serverResult)")
                let getCrawlerErrorCode = serverResult["ErrorCode"] as! Int
                switch getCrawlerErrorCode {
                case 0:
                    self.refreshSubscribe()
                case -101:
                    print("request에 크롤러 데이터 없음.")
                case -200:
                    print("유효하지 않은 구독목록")
                default:
                    print("서버 에러")
                }
            case.failure(let err):
                print("err \(err)")
            }
        }
    }
}

extension SubscribedCrawlerController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localSubscribeCrawlerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntireCrawlerCell", for: indexPath) as! EntireCrawlerCell
        cell.crawlerImage.image = UIImage(named: localSubscribeCrawlerList[indexPath.row].thumbnail_url!)
        if(cell.crawlerImage.image == nil) {
            cell.crawlerImage.image = UIImage(named: "juju")
        }
        cell.crawlerTitle.text = localSubscribeCrawlerList[indexPath.row].title
        cell.crawlerDescription.text = localSubscribeCrawlerList[indexPath.row].description
        cell.subscribeButton.setTitle("구독취소", for: .normal)
        cell.subscribeAction = {
            (celll) in
            self.unsubscribeAction(indexPath: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}

extension Notification.Name {
    static let notiSubscribe = Notification.Name("notiSubscribe")
}

