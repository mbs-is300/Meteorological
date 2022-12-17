//
//  dailyWeather_TableViewCell.swift
//  NCM
//
//  Created by Meshal Alsallami on 02/12/2022.
//

import UIKit

class dailyWeather_TableViewCell: UITableViewCell {
    
    @IBOutlet weak var city_lbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var low_lbl: UILabel!
    @IBOutlet weak var high_lbl: UILabel!
    @IBOutlet weak var desc_lbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
