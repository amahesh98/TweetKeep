//
//  FavoriteTableViewCell.swift
//  TwitKeeps
//
//  Created by El Capitan on 7/12/18.
//  Copyright © 2018 Carlo Del Mundo. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    @IBOutlet weak var UserPhoto: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var HandleLabel: UILabel!
    @IBOutlet weak var LastUpdateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
