//
//  ViewController.swift
//  TwitKeeps
//
//  Created by El Capitan on 7/12/18.
//  Copyright © 2018 Carlo Del Mundo. All rights reserved.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {
    @IBOutlet weak var ListOfFavorites: UITableView!
    var favorites: [Tweet] = []
    var userSelected = ""
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var twitter:STTwitterAPI!
    var fullNames:[String]!
    var imagePaths:[String]!
    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.layer.cornerRadius = 6
        ListOfFavorites.dataSource = self
        ListOfFavorites.delegate = self
        ListOfFavorites.rowHeight = 120
        
        twitter = STTwitterAPI(oAuthConsumerKey: "RFykEoNMVQhhHa8olba2tUr19", consumerSecret: "dvzlVHmGkaiBmiO2okO1o4Vc4oQKYfuF3Ed1v4bhcz9y2F4ZCU", oauthToken: "833497354116464644-8bYBjlHqFaenWvlYxkhAhcDYNaLUAix", oauthTokenSecret: "Cw4Eg4ShkkrYKD0XGoPLZlbwSJNrNxvnBY55OlKPieoVl")!
        twitter.verifyCredentials(userSuccessBlock: { (username, userID) in
            print(username, userID)
        }, errorBlock: { (error) in
            print(error)
        })
        fetchUsers()
    }
    override func viewDidAppear(_ animated: Bool) {
        ListOfFavorites.reloadData()
    }
    
    @IBAction func backPushed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func fetchUsers() {
        let request:NSFetchRequest<Tweet> = Tweet.fetchRequest()
        favorites.removeAll()
        do {
            let tweets = try context.fetch(request)
            var currentUser = ""
            for tweet in tweets {
                if currentUser != tweet.user{
                    favorites.append(tweet)
                    currentUser = tweet.user!
                }
            }
        } catch {
            print("\(error)")
        }
    }
}
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ListOfFavorites.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        cell.HandleLabel.text = favorites[indexPath.row].user
        cell.NameLabel.text = favorites[indexPath.row].fullName
        let imageURL = URL(string: favorites[indexPath.row].imagePath!)
        if let data = try? Data(contentsOf: imageURL!){
            cell.UserPhoto.image = UIImage(data:data)
        }
        cell.LastUpdateLabel.text = "07/13/18"
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! FavoriteTweetsViewController
        destination.userHandle = userSelected
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        userSelected = favorites[indexPath.row].user!
//        performSegue(withIdentifier: "TweetsSegue", sender: indexPath)
    }
}
