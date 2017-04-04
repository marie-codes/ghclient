//
//  IssueDetailViewController.swift
//  GithubClient
//
//  Created by Marie Park on 3/22/17.
//  Copyright © 2017 Marie Park. All rights reserved.
//

import UIKit

class IssueDetailViewController: UIViewController {
    
    var issue: Issue?
    @IBOutlet weak var issueTitle: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    
    @IBOutlet weak var issueNumber: UILabel!
    @IBOutlet weak var issueStatus: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var issueAuthorImage: UIImageView!
    
    @IBOutlet weak var body: UITextView!
    @IBOutlet weak var created_at: UILabel!
    @IBOutlet weak var author: UILabel!
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        issue?.body = body.text
        Api.updateIssue(issue: issue!)
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        if issue?.state == "closed"{
            issue?.state = "open"
        }else{
            issue?.state = "closed"
        }
        updateStatusButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.issueLoaded(_:)), name: NSNotification.Name(rawValue: "issue-updated"), object: nil)
        updateUI()
        print(issue?.repository_url)
    }
    
    func issueLoaded(_ notification: NSNotification){
        //updateStatusButton()
    }
    
    func updateUI(){
        issueNumber.text = issue?.id
        issueStatus.text = issue?.state
        comments.text = issue?.comments
        issueAuthorImage.image = issue?.user.getAvatarImage()
        body.text = issue?.body
        author.text = issue?.user.login
        created_at.text = issue?.created_at
        issueTitle.text = issue?.title
        updateStatusButton()
    }
    
    func updateStatusButton(){
        if issue?.state == "open"{
            statusButton.setTitle("Close Issue", for: .normal)
            statusButton.backgroundColor = UIColor.red
        }else{
            statusButton.setTitle("Open Issue", for: .normal)
            statusButton.backgroundColor = UIColor.green
        }
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
