//
//  Constants.swift
//  GithubClient
//
//  Created by Marie Park on 3/22/17.
//  Copyright © 2017 Marie Park. All rights reserved..
//

import Foundation

class Constant {
    private var u: String? // Username
    private var p: String? // Password
    var username: String? {
        get {
            if u == nil {
                let defaults = UserDefaults()
                u  = defaults.object(forKey: "username") as? String
                return u
            }
            return u
        }
        set {
            let defaults = UserDefaults()
            defaults.set(newValue, forKey: "username")
            defaults.synchronize()
            u = newValue
        }
    }
    
    var password: String? {
        get {
            if p == nil {
                let defaults = UserDefaults()
                p  = defaults.object(forKey: "password") as? String
                return p
            }
            return p
        }
        set {
            let defaults = UserDefaults()
            defaults.set(newValue, forKey: "password")
            defaults.synchronize()
            p = newValue
        }
    }
    
    class var sharedManager : Constant {
        
        struct Static {
            static let instance : Constant = Constant()
        }
        return Static.instance
    }
}
