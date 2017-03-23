//
//  RepoCell.swift
//  GithubClient
//
//  Created by Marie Park on 3/22/17.
//  Copyright © 2017 Marie Park. All rights reserved.
//

import UIKit

class RepoCell: UICollectionViewCell {
    
    @IBOutlet weak var repoName: UILabel!
    
    // MARK: - Properties
    override var isSelected: Bool {
        didSet {
            self.layer.borderWidth = isSelected ? 4 : 1
        }
    }
}
