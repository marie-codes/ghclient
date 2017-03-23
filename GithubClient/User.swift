//
//  User.swift
//  GithubClient
//
//  Created by Marie Park on 3/22/17.
//  Copyright © 2017 Marie Park. All rights reserved.
//

import Foundation
import EVReflection

class User: EVNetworkingObject{
    var id: String?
    var avatar_url: String?
    var login: String?
    var name: String?
    var bio: String?
    var repos_url: String?
    var repos: [Repo] = [Repo]()
    
    func getAvatarImage() -> UIImage{
        var image = UIImage()
        if let url = NSURL(string: avatar_url!) {
            if let data = NSData(contentsOf: url as URL) {
                image = UIImage(data: data as Data)!
            }        
        }
        return image
    }
}
