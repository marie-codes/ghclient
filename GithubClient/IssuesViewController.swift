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
    
    @IBOutlet weak var loadingContainer: UIView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBAction func addNewBtnPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "showNewIssue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadingContainer.isHidden = false
        self.loadingIndicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Api.getIssuesList(url: (repo?.getIssuesUrl())!, success: { (response) in
            self.issues = response
            self.tableView.reloadData()
            self.loadingIndicator.stopAnimating()
            self.loadingContainer.isHidden = true
        })
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
