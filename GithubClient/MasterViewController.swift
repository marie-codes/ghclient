//
//  MasterViewController.swift
//  GithubClient
//
//  Created by Marie Park on 3/22/17.
//  Copyright © 2017 Marie Park. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UITextView!
    @IBOutlet weak var avatar: UIImageView!
    @IBAction func logoutPressed(_ sender: Any) {
        Constant.sharedManager.password = nil
        Constant.sharedManager.username = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem

//        if let split = self.splitViewController {
//            let controllers = split.viewControllers
//            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
//        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.userLoaded(_:)), name: NSNotification.Name(rawValue: "user-loaded"), object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        //self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func userLoaded(_ notification: NSNotification){
        if let user = notification.userInfo?["user"] as? User {
            nameLabel.text = user.name
            bioLabel.text = user.bio
            avatar.image = user.getAvatarImage()
        }
    }

}

