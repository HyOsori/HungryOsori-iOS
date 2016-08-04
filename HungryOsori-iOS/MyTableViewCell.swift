//
//  MyTableViewCell.swift
//  HungryOsori-iOS
//
//  Created by Macbook Pro retina on 2016. 8. 1..
//  Copyright © 2016년 HanyangOsori. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var imageurlresult: UIImageView!
    //@IBOutlet weak var title: UITextField!
    //@IBOutlet weak var des: UITextField!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var subscribeButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
