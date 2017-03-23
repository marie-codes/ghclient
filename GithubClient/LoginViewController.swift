//
//  LoginViewController.swift
//  GithubClient
//
//  Created by Marie Park on 3/23/17.
//  Copyright © 2017 Tim Samoilenko. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        Constant.sharedManager.username = userName.text
        Constant.sharedManager.password = passWord.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Constant.sharedManager.username = nil
        Constant.sharedManager.password = nil
    }

   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
