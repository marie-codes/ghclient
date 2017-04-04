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
        print("sending api request to create new issue")
        Api.createIssue(issue: issue, repo_name: repo.name!, success: { (response) in
            self.issueCreated(response)
        })
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    
    func issueCreated(_ issue: Issue){
        print("ISSUE NUMBER: "+(issue.number)!)
        print("redirecting to list view")
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
