//
//  NewIssueViewController.swift
//  GithubClient
//
//  Created by Marie Park on 3/22/17.
//  Copyright © 2017 Marie Park. All rights reserved.
//

import UIKit

class NewIssueViewController: UIViewController {
    
    let issue: Issue = Issue()
    var repo: Repo = Repo()
    
    @IBOutlet weak var body: UITextView!
    @IBOutlet weak var issueTitle: UITextField!
   
    @IBAction func saveButtonPressed(_ sender: Any) {
        issue.title = issueTitle.text
        issue.body = body.text
        Api.createIssue(issue: issue, repo_name: repo.name!)
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(repo)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
