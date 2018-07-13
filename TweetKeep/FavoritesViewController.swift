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
    
    var favorites: [Tweets] = []
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ListOfFavorites.dataSource = self
        ListOfFavorites.delegate = self
        ListOfFavorites.rowHeight = 120
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchUsers() {
        let request:NSFetchRequest<Tweets> = Tweets.fetchRequest()
        do {
            let result = try context.fetch(request)
            favorites =  result
        } catch {
            print("\(error)")
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let indexPath = sender as? IndexPath{
//            let destination = segue.destination as! FavoriteTweetsViewController
//            
//            destination.user = (favorites[indexPath.row].user)!
//            destination.created_at = "\(favorites[indexPath.row].created_at!)"
//            destination.indexPath = indexPath
//        }
//    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return favorites.count
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ListOfFavorites.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
//        let empty = ""
//        cell.UserPhoto.image = UIImage(named: "\(favorites[indexPath.row].img_url)")
//        cell.NameLabel.text = "\(favorites[indexPath.row].user ?? empty) \(favorites[indexPath.row].lastName ?? empty)"
//        cell.HandleLabel.text = "\(favorites[indexPath.row].text ?? empty)"
//        cell.LastUpdateLabel.text = "\(favorites[indexPath.row].updated_at ?? empty)"
        cell.NameLabel.text = "Ismael Lee"
        cell.HandleLabel.text = "smiley"
        cell.LastUpdateLabel.text = "01/01/01"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "TweetsSegue", sender: indexPath)
    }
    
}
