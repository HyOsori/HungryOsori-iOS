//
//  SubscribeTableViewCell.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 8. 2..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import UIKit

class SubscribeTableViewCell: UITableViewCell {

    @IBOutlet weak var subimage: UIImageView!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var subdes: UILabel!
    @IBOutlet weak var unsubscribeButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
