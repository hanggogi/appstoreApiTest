//
//  HmTableViewCell.swift
//  appstoreApiTest
//
//  Created by samga on 2020/04/16.
//  Copyright © 2020 samga. All rights reserved.
//

import UIKit
import Cosmos

class HmTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var resultTitle: UILabel!
    @IBOutlet weak var resultSubTitle: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var lineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.rateView.settings.fillMode = .half
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
