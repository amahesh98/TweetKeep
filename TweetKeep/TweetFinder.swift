//
//  ViewController.swift
//  TweetKeep
//
//  Created by Drew on 7/12/18.
//  Copyright © 2018 Drew. All rights reserved.
//

import UIKit
import CoreData

class TweetFinder: UIViewController {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    //objects
    var twitterName:String?
    var fullName:String?
    var imagePath:String?
    var allData:[NSDictionary]=[]
    var currentFavorites:[Tweet] = []
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var twitter:STTwitterAPI!
    @IBOutlet weak var myTextField: UITextField!
    @IBAction func searchPressed(_ sender: UIButton) {
        var searchText = myTextField.text!
        if searchText != "" {
            searchText = searchText.lowercased()
            var newTableData:[NSDictionary] = []
            for tweet in allData{
                let tweetText = tweet["text"] as! String
                if tweetText.lowercased().range(of: searchText) != nil{
                    newTableData.append(tweet)
                }
            }
            tableData = newTableData
            tableView.reloadData()
        }
        else {
//            getUserInfo(user: userHandle)
            tableData = allData
            tableView.reloadData()
        }
    }
    
    var tweets:[String] = []
    var tableData:[NSDictionary] = []
    var tweetsUpdated:[String] = []
    var userHandle = "realDonaldTrump"
    
    var userName = ""
    var userPicture = ""
    
    //creating function that gets the info
    func getUserInfo(user: String) {
        twitter.getUserTimeline(withScreenName: user, count: 200, successBlock: { (tweets) in
            let tweetsChanged = tweets as! NSArray
            for tweet in tweets!{
                let tweetChanged = tweet as! NSDictionary
                self.tableData.append(tweetChanged)
            }
            self.tableView.reloadData()
            self.allData = self.tableData
        }) { (error) in
            print(error)
        }
    }
    
    //func that gets profile pic data
    func fetchImageData(url: String) {
        let url = URL(string: url)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            DispatchQueue.main.async {
                self.userImageView.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector("endEditing:")))
        tableView.dataSource = self
        tableView.delegate = self
        handleLabel.text = "@" + twitterName!
        nameLabel.text = fullName!
        
        let imageURL = URL(string: imagePath!)
        if let data = try? Data(contentsOf:imageURL!){
            userImageView.image = UIImage(data:data)
        }
        searchButton.layer.cornerRadius = 6
        backButton.layer.cornerRadius = 6
        twitter = STTwitterAPI(oAuthConsumerKey: "RFykEoNMVQhhHa8olba2tUr19", consumerSecret: "dvzlVHmGkaiBmiO2okO1o4Vc4oQKYfuF3Ed1v4bhcz9y2F4ZCU", oauthToken: "833497354116464644-8bYBjlHqFaenWvlYxkhAhcDYNaLUAix", oauthTokenSecret: "Cw4Eg4ShkkrYKD0XGoPLZlbwSJNrNxvnBY55OlKPieoVl")!
        twitter.verifyCredentials(userSuccessBlock: { (username, userID) in
            print(username, userID)
        }, errorBlock: { (error) in
            print(error)
        })
        getUserInfo(user: userHandle)
        currentFavorites = fetchAll()
//        print(currentFavorites.count)
    }
    
    //ADDING CORE DATA
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchAll()->[Tweet]{
        let request:NSFetchRequest<Tweet> = Tweet.fetchRequest()
        do{
            let tweets = try context.fetch(request)
            return tweets
        }
        catch{
            print(error)
        }
        var emptyList:[Tweet] = []
        return emptyList
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BucketList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func applicationWillTerminate(application: UIApplication) {
        self.saveContext()
    }
}

extension TweetFinder: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tweetsUpdated.count
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("Getting into function")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        let currentTweet = tableData[indexPath.row]
//        print("Current tweet:", currentTweet)
//        if let tweetText = currentTweet.value(forKey: "text") as? String{
        if let tweetText = currentTweet["text"] as? String{
//            print("TweetText")
//            print(tweetText)
            cell.myTextView.text = tweetText
            
            var alreadyFav = false
            for tweet in currentFavorites{
                if tweet.text == tweetText{
                    alreadyFav = true
                    break
                }
            }
            if alreadyFav{
                cell.favoriteLabel.setBackgroundImage(UIImage(named: "heartfilled"), for: .normal)
                cell.favorited = true
            }
            else{
                cell.favoriteLabel.setBackgroundImage(UIImage(named: "heartempty"), for: .normal)
            }
        }
        if let date = currentTweet.value(forKey: "created_at") as? String{
            let dateSplit = date.split(separator: " ")
            let month = dateSplit[1]
            let day = dateSplit[2]
            let year = dateSplit[dateSplit.count-1]
            let concatDate = month + " " + day + ", " + year
            cell.dateLabel.text = concatDate
        }
        
        
        
        
        cell.delegate = self
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = CGFloat()
            if let tweet = tableData[indexPath.row]["text"] as? String{
//                print(tweet.count)
                if tweet.count < 50 {
                    height = 100
                    return height
                } else if tweet.count < 100 {
                    height = 80
                } else if tweet.count < 150 {
                    height = 120
                } else if tweet.count < 200 {
                    height = 160
                } else if tweet.count < 250 {
                    height = 190
                } else if tweet.count < 300 {
                    height = 220
                }
            }
        height+=40
        return height
    }
}

extension TweetFinder: TweetCellDelegate {
    func favoritePressed(sender: MyTableViewCell) {
        if sender.favorited == false{
            let indexPath = tableView.indexPath(for: sender)
            let newTweet = Tweet(context:context)
            newTweet.text = tableData[indexPath!.row]["text"] as! String
            newTweet.user = userHandle
            newTweet.created_at = sender.dateLabel.text
            newTweet.liked_at = Date()
            newTweet.fullName = self.fullName
            newTweet.imagePath = self.imagePath
    //        addItemToCoreData(name: userName, text: tweetText, image: userPicture)
            currentFavorites.append(newTweet)
            appDelegate.saveContext()
            sender.favoriteLabel.setBackgroundImage(UIImage(named: "heartfilled"), for: .normal)
            sender.favorited = true
        }
        else{
            for i in 0..<currentFavorites.count{
                let tweet = currentFavorites[i]
                if tweet.text == sender.myTextView.text {
                    currentFavorites.remove(at: i)
                    context.delete(tweet)
                    appDelegate.saveContext()
//                    print("Successfully deleted")
                    break
                }
            }
            sender.favoriteLabel.setBackgroundImage(UIImage(named: "heartempty"), for: .normal)
            sender.favorited = false
        }
    }
}



