//
//  ReposViewController.swift
//  GithubClient
//
//  Created by Marie Park on 3/22/17.
//  Copyright © 2017 Marie Park. All rights reserved.
//

import Foundation
import UIKit

class ReposViewController: UIViewController{
    // MARKvar Properties
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate let itemsPerRow: CGFloat = 3
    fileprivate let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    fileprivate var repos: [Repo] = [Repo]()
    fileprivate var selectedRepo: Repo?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.userLoaded(_:)), name: NSNotification.Name(rawValue: "user-loaded"), object: nil)
    }
    
    func userLoaded(_ notification: NSNotification){
        if let user = notification.userInfo?["user"] as? User {
            repos = user.repos
            collectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "issues"{
            let destinationVC = segue.destination as! IssuesViewController
            let repo = repoForIndexPath(indexPath: sender as! IndexPath)
            destinationVC.repo = repo
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "issues", sender: indexPath)
    }
    
}

// MARK: - Private
private extension ReposViewController {
    func repoForIndexPath(indexPath: IndexPath) -> Repo {
        return repos[(indexPath as IndexPath).row]
    }
}

extension ReposViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RepoCell
        let repo = repoForIndexPath(indexPath: indexPath)
        let borderColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.1)
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderWidth = 1
        cell.layer.borderColor = borderColor.cgColor
        cell.layer.cornerRadius = 5
        
        cell.repoName.text = repo.name
        
        return cell
    }
    
    
}

extension ReposViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem / 2.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
