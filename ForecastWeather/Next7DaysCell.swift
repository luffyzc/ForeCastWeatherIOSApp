//
//  Next7DaysCell.swift
//  ForecastWeather
//
//  Created by ZhangChi on 12/10/15.
//  Copyright © 2015 ZhangChi. All rights reserved.
//

import UIKit

class Next7DaysCell: UITableViewCell {


    @IBOutlet weak var hltemp: UILabel!
    @IBOutlet weak var weatherimg: UIImageView!
    @IBOutlet weak var date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
