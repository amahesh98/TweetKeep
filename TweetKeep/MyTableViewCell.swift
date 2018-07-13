//
//  MyTableViewCell.swift
//  TweetKeep
//
//  Created by Drew on 7/12/18.
//  Copyright © 2018 Drew. All rights reserved.
//

import UIKit

protocol TweetCellDelegate {
    func favoritePressed(sender: MyTableViewCell)
}

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UIButton!
    @IBOutlet weak var myTextView: UITextView!
    
    var delegate: TweetCellDelegate!
    
    @IBAction func favoritePressed(_ sender: UIButton) {
        delegate.favoritePressed(sender: self)
    }
}

