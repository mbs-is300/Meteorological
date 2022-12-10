//
//  city_TableViewCell.swift
//  NCM
//
//  Created by Meshal Alsallami on 09/12/2022.
//

import UIKit

class city_TableViewCell: UITableViewCell {
    @IBOutlet weak var city_name_en_lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
