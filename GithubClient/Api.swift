//
//  Api.swift
//  GithubClient
//
//  Created by Marie Park on 3/22/17.
//  Copyright © 2017 Marie Park. All rights reserved.
//

import Foundation
import Alamofire

class Api{
    
    static func headers() -> HTTPHeaders{
        var headers: HTTPHeaders = [:]
        
        if let authorizationHeader = Request.authorizationHeader(user: Constant.sharedManager.username!, password: Constant.sharedManager.password!) {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        //Disable Cache
        headers["Cache-Control"] = "max-age=0, private, must-revalidate"
        
        return headers
        
    }
    
    static func getUser(){
        Alamofire.request("https://api.github.com/user", headers: self.headers())
            .responseObject { (response: DataResponse<User>) in
                if let user = response.result.value{
                    self.getUserRepos(user: user)
                }
        }
    }
    
    static func getUserRepos(user: User){
        Alamofire.request(user.repos_url!, headers: self.headers())
            .responseArray { (response: DataResponse<[Repo]>) in
                if let repos = response.result.value{
                    user.repos = repos
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "user-loaded"), object: self, userInfo: ["user":user])
                }
        }
    }
    
    static func getIssuesList(url: String, success: @escaping (_ response: [Issue]) -> Void){
        Alamofire.request(url, headers: self.headers())
            .responseArray { (response: DataResponse<[Issue]>) in
                switch response.result{
                case .success:
                    if let issues = response.result.value{
                        success(issues)
                        //NotificationCenter.default.post(name: Notification.Name(rawValue: "issues-loaded"), object: self, userInfo: ["issues":issues])
                    }
                    
                case .failure(let error):
                    print(error)
                }
                
        }
    }
    
    static func updateIssue(issue: Issue){
        let parameters: Parameters = issue.toDictionary() as! [String: Any]
        Alamofire.request(issue.url!, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: self.headers()).responseJSON { response in
            NotificationCenter.default.post(name: Notification.Name(rawValue: "issue-updated"), object: self)
            print(response.result)
        }
    }
    
    static func createIssue(issue: Issue, repo_name: String, success: @escaping (_ response: Issue) -> Void){
        let parameters: Parameters = issue.toDictionary() as! [String: Any]
        let url = "https://api.github.com/repos/" + Constant.sharedManager.username! + "/" + repo_name + "/issues"
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: self.headers()).responseObject { (response: DataResponse<Issue>) in
            switch response.result{
            case .success:
                print("issue has been created")
                if let issue = response.result.value{
                    success(issue)
                }
            case .failure(let error):
                print("error occured when creating new issue")
                print(error)
            }
        }
    }
    
    static func getIssue(_ issueNumber: String, _ repo: Repo, success: @escaping (_ response: Issue) -> Void){
        let url = repo.getIssuesUrl() + "/" + issueNumber
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: self.headers()).responseObject { (response: DataResponse<Issue>) in
            switch response.result{
            case .success:
                if let issue = response.result.value{
                    success(issue)
                }
            case .failure(let error):
                print("error occured")
                print(error)
            }
        }
    }
    
}
