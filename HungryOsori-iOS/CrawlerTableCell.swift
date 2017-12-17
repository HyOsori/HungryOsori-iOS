//
//  CrawlerTableCell.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2017. 10. 15..
//  Copyright © 2017년 HanyangOsori. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class EntireCrawlerCell: UITableViewCell {
    var crawlerImage: UIImageView!
    var crawlerTitle: UILabel!
    var crawlerDescription: UILabel!
    var subscribeButton: UIButton!
    var subscribeAction: ((UITableViewCell) -> Void)?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        crawlerImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 88, height: 88))
        
        crawlerTitle = UILabel(frame: CGRect(x: crawlerImage.frame.origin.x + crawlerImage.frame.width + 5, y: 0, width: self.frame.width/2, height: crawlerImage.frame.height/2))
        
        crawlerDescription = UILabel(frame: CGRect(x: crawlerImage.frame.origin.x + crawlerImage.frame.width + 5, y: crawlerImage.frame.height/2, width: self.frame.width/2, height: crawlerImage.frame.height/2))
        
        subscribeButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - UIScreen.main.bounds.width/5, y: 22, width: UIScreen.main.bounds.width/5, height: 44))
        subscribeButton.setTitle("구독", for: .normal)
        subscribeButton.setTitleColor(.black, for: .normal)
        subscribeButton.addTarget(self, action: #selector(onClickSubscribeButton(_:)), for: .touchUpInside)
        
        addSubview(crawlerImage)
        addSubview(crawlerTitle)
        addSubview(crawlerDescription)
        addSubview(subscribeButton)
        
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    @objc func onClickSubscribeButton(_ sender: UIButton) {
        subscribeAction!(self)
    }
    
    override func prepareForReuse() {
        crawlerTitle.text = nil
        crawlerDescription.text = nil
        crawlerImage.sd_cancelCurrentImageLoad()
    }
    
}
