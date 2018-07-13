//
//  SearchUserVC.swift
//  TweetKeep
//
//  Created by Ashwin Mahesh on 7/12/18.
//  Copyright © 2018 AshwinMahesh. All rights reserved.
//

import UIKit

class SearchUserVC: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var tableData:[NSDictionary] = []
    var searchName:String?
    var twitter:STTwitterAPI!
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 129
//        searchName = searchName?.replacingOccurrences(of: " ", with: "")
//        TWITTER CODE
        twitter = STTwitterAPI(oAuthConsumerKey: "RFykEoNMVQhhHa8olba2tUr19", consumerSecret: "dvzlVHmGkaiBmiO2okO1o4Vc4oQKYfuF3Ed1v4bhcz9y2F4ZCU", oauthToken: "833497354116464644-8bYBjlHqFaenWvlYxkhAhcDYNaLUAix", oauthTokenSecret: "Cw4Eg4ShkkrYKD0XGoPLZlbwSJNrNxvnBY55OlKPieoVl")!
        twitter.verifyCredentials(userSuccessBlock: { (username, userID) in
            print(username, userID)
        }, errorBlock: { (error) in
            print(error)
        })
//        twitterPlay()
        searchForUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func twitterPlay(){
        twitter.getUsersSearchQuery("ashwin", page:"1", count:"15", includeEntities: 15, successBlock: { (users) in
            print(users)
        }) { (error) in
            print(error)
        }
    }
    func searchForUsers(){
        twitter.getUsersSearchQuery(searchName!, page:"1", count:"15", includeEntities: 15, successBlock: { (users) in
            let usersChanged = users as! NSArray
            for user in users!{
                let userChanged = user as! NSDictionary
                print(user)
//                print(userChanged["name"])
                self.tableData.append(userChanged)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // change 2 to desired number of seconds
                self.tableView.reloadData()
            }
            
        }) { (error) in
            print(error)
        }
       
    }
}
extension SearchUserVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
//        cell.profileImage.image = UIImage(named: )
        let currentUser = tableData[indexPath.row]
        if let profilePic = currentUser.value(forKey: "profile_image_url_https") as? String{
//            print(profilePic)
            let imageURL = URL(string: profilePic)
            if let data = try? Data(contentsOf: imageURL!){
                cell.profileImage.image = UIImage(data: data)
            }
        }
        if let name = currentUser.value(forKey: "name") as? String{
            cell.handleLabel.text = name+"\n"
        }
        if let handle = currentUser.value(forKey: "screen_name") as? String{
            cell.handleLabel.text?.append(handle)
        }
        return cell
    }
}
