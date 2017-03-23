//
//  Repos.swift
//  GithubClient
//
//  Created by Marie Park on 3/22/17.
//  Copyright © 2017 Marie Park. All rights reserved.
//

import Foundation
import EVReflection

class Repo: EVNetworkingObject{
    var id: String?
    var name: String?
    var languages_url: String?
    var issues_url: String?
    var has_issues: String?
    var created_at: String?
    var forks_count: String?
    var stargazers_count: String?
    var open_issues: String?
}
