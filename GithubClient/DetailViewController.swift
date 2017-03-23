//
//  DetailViewController.swift
//  GithubClient
//
//  Created by Marie Park on 3/22/17.
//  Copyright © 2017 Marie Park. All rights reserved.
//

import UIKit
import Alamofire

let reuseIdentifier = "repoCell"

class DetailViewController: UIViewController{

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    //@IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
//        activityIndicator.center = view.center;
//        activityIndicator.hidesWhenStopped = true;
//        activityIndicator.startAnimating();
        NotificationCenter.default.addObserver(self, selector: #selector(self.userLoaded(_:)), name: NSNotification.Name(rawValue: "user-loaded"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func userLoaded(_ notification: NSNotification){
        if let user = notification.userInfo?["user"] as? User {
            //activityIndicator.stopAnimating();
            print("User loaded")
            print(user)
        }
    }

}

