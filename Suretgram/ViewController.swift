//
//  ViewController.swift
//  Suretgram
//
//  Created by Yerkegali Abubakirov on 04.07.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    
    @IBOutlet weak var userNameTxtField: UITextField!
    
    var userName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func searchBtnTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toFeed", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFeed" {
            if let feedVC = segue.destination as? FeedController {
                let userName = userNameTxtField.text ?? "NoName"
                feedVC.userName = userName
            }
        }
    }
}

