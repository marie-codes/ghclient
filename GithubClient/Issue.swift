//
//  Issue.swift
//  GithubClient
//
//  Created by Marie Park on 3/22/17.
//  Copyright © 2017 Marie Park. All rights reserved.
//

import Foundation
import EVReflection

class Issue: EVNetworkingObject{
    var id: String?
    var url: String?
    var title: String?
    var state: String?
    var comments: String?
    var created_at: String?
    var closed_at: String?
    var body: String?
    var user: User = User()
    var repository_url: String?
    var number: String?
}
