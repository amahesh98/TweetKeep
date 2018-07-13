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
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 129
        searchName = searchName?.replacingOccurrences(of: " ", with: "")
        searchForUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func searchForUsers(){
        print("Entering function")
        var request = "https://api.twitter.com/1.1/users/search.json?q="
        request.append(searchName!)
        print(request)
//        request = "https://twitter.com/Ashwin_m2"
        let url = URL(string: request)
        print("Session created, url made")
        let task = URLSession.shared.dataTask(with: url!){
            (data, response,error) in
            if error != nil{
                DispatchQueue.main.async{
                    if let errorMessage = error?.localizedDescription{
                        print(errorMessage)
                    }
                    else{
                        print("There has been an error")
                    }
                }
            }
            else{
//                Put Data manipulating code in here
                do{
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary{
                        print(jsonResult)
                    }
                }
                catch{
                    print(error)
                }
//                print(data ?? "no data")
            }
        }
        task.resume()
    }
}
extension SearchUserVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        
        return cell
    }
}
