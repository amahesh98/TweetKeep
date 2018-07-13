//
//  ViewController.swift
//  TweetKeep
//
//  Created by Ashwin Mahesh on 7/12/18.
//  Copyright © 2018 AshwinMahesh. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBAction func goPressed(_ sender: UIButton) {
        errorLabel.text=""
        if let username = usernameField.text{
            var allSpaces = true
            for char in username{
                if char != " "{
                    allSpaces = false
                }
            }
            if allSpaces==true{
                errorLabel.text = "Name must be atleast 4 characters"
                return
            }
            if username.count<4{
                errorLabel.text = "Name must be atleast 4 characters"
                return
            }
            performSegue(withIdentifier: "SearchUserSegue", sender: "search")
        }
        else{
            errorLabel.text = "You cannot search for an empty name"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
        goButton.layer.cornerRadius = 6
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector("endEditing:")))
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! SearchUserVC
        dest.searchName = usernameField.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

