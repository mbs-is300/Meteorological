//
//  search_TableViewCell.swift
//  NCM
//
//  Created by Meshal Alsallami on 05/12/2022.
//

import UIKit

class search_TableViewCell: UITableViewCell {
    @IBOutlet weak var city: UILabel!
    
    var cityID = 0, regionID = 0, nameAR = "", nameEN = "", latitude = "", longitude = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
