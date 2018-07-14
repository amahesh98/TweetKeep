//
//  FavoriteTweetsViewController.swift
//  TwitKeeps
//
//  Created by El Capitan on 7/13/18.
//  Copyright © 2018 Carlo Del Mundo. All rights reserved.
//

import UIKit
import CoreData
class FavoriteTweetsViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var ListOfTweets: UITableView!
    @IBOutlet weak var FullNameLabel: UILabel!
    @IBOutlet weak var UsernameLabel: UILabel!
    @IBOutlet weak var UserPic_url: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var userHandle: String!
    var created_at: String!
    var fullName: String!
    var imagePath: String!
    var user_id: Int!
    var indexPath: IndexPath!
    var tweets: [Tweet] = []
    var tweetsCurrent: [Tweet] = []
    
    @IBAction func backPushed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        UsernameLabel.text = userHandle
        FullNameLabel.text = fullName
        backButton.layer.cornerRadius = 6
        ListOfTweets.dataSource = self
        ListOfTweets.delegate = self
        ListOfTweets.rowHeight=150
        let imageURL = URL(string: imagePath)
        if let data = try? Data(contentsOf: imageURL!){
            UserPic_url.image = UIImage(data:data)
        }
        dateLabel.text = "07/13/18"
        fetchTweets()
        getSpecificTweets()
        ListOfTweets.reloadData()
    }
    
    @IBAction func BackButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    func fetchTweets() {
        let request:NSFetchRequest<Tweet> = Tweet.fetchRequest()
        do {
            let result = try context.fetch(request)
            tweets =  result
        } catch {
            print("\(error)")
        }
    }
    func getSpecificTweets(){
        for tweet in tweets{
            if tweet.user == userHandle{
                tweetsCurrent.append(tweet)
            }
        }
        print("Specific Tweets")
        print(tweetsCurrent)
    }
}

extension FavoriteTweetsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetsCurrent.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ListOfTweets.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
//        cell.indexPath = indexPath
        cell.tweetLabel.text = tweetsCurrent[indexPath.row].text
        return cell
    }
}
