//
//  TweetCell.swift
//  TwitKeeps
//
//  Created by El Capitan on 7/13/18.
//  Copyright © 2018 Carlo Del Mundo. All rights reserved.
//

import UIKit
import CoreData

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetLabel: UITextView!
    @IBOutlet weak var LikedImage: UIImageView!
    
    var liked = true
    var indexPath: IndexPath?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func LikedButtonPressed(_ sender: UIButton) {

        
        print("tapped")
    }
    
}
