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
    @IBOutlet weak var ListOfTweets: UITableView!
    @IBOutlet weak var FullNameLabel: UILabel!
    @IBOutlet weak var UsernameLabel: UILabel!
    @IBOutlet weak var UserPic_url: UIImageView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var created_at: String = "Ann Known"
    var user: String = "unknwon"
    var user_url: String = "Image"
    var user_id: Int = 1
    
    var indexPath: IndexPath?
    
    var tweets: [Tweets] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FullNameLabel.text = user
        
        UserPic_url.image = UIImage(named: user_url)

        ListOfTweets.dataSource = self
        ListOfTweets.delegate = self
        ListOfTweets.rowHeight = 100
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func fetchTweets() {
        let request:NSFetchRequest<Tweets> = Tweets.fetchRequest()
        do {
            let result = try context.fetch(request)
            tweets =  result
        } catch {
            print("\(error)")
        }
    }

}

extension FavoriteTweetsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return favorites.count
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ListOfTweets.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
//        let empty = ""
//        cell.TweetLabel.text = "\(tweets[indexPath.row].text ?? empty)"
        cell.indexPath = indexPath
        cell.TweetLabel.text = "TWEEET"
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    }
    
}
