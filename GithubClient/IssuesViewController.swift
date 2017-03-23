//
//  IssuesViewController.swift
//  GithubClient
//
//  Created by Marie Park on 3/22/17.
//  Copyright © 2017 Marie Park. All rights reserved.
//

import Foundation
import UIKit

class IssuesViewController: UITableViewController{
    
    var repo: Repo?
    var issues: [Issue] = [Issue]()
    
    @IBAction func addNewBtnPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "showNewIssue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.issuesLoaded(_:)), name: NSNotification.Name(rawValue: "issues-loaded"), object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(self.issueUpdated), name: NSNotification.Name(rawValue: "issue-updated"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Api.getIssuesList(url: prepareUrl(str: repo!.issues_url!))
        
    }
    
    func prepareUrl(str: String) -> String{
        let c = str.characters
        let r = c.startIndex..<c.index(c.endIndex, offsetBy: -9)
        let substring = String(str[r])
        return substring!
    }
    
    func issuesLoaded(_ notification: NSNotification){
        if let repo_issues = notification.userInfo?["issues"] as? [Issue] {
            issues = repo_issues
            print(issues)
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issues.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "issueCell", for: indexPath) as! IssueCell
        let issue = issueForIndexPath(indexPath: indexPath)
        cell.titleLabel.text = issue.title
        cell.authorLabel.text = issue.created_at
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "issue-detail"{
            let destinationVC = segue.destination as! IssueDetailViewController
            let issue = issueForIndexPath(indexPath: sender as! IndexPath)
            destinationVC.issue = issue
        }
        
        if segue.identifier == "showNewIssue" {
            let destinationVC = segue.destination as! NewIssueViewController
            destinationVC.repo = repo!
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "issue-detail", sender: indexPath)
    }
}

// MARK: - Private
private extension IssuesViewController {
    func issueForIndexPath(indexPath: IndexPath) -> Issue {
        return issues[(indexPath as IndexPath).row]
    }
}
