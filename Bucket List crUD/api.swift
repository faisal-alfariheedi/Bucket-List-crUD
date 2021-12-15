//
//  api.swift
//  Bucket List crUD
//
//  Created by faisal on 11/05/1443 AH.
//

import Foundation

class BucketAPI {
    static func getAll(completionHandler: @escaping(_ data: Data?, _ response:URLResponse?, _ error:Error?) -> Void){
        URLSession.shared.dataTask(with: URL(string: "url-here/tasks")!, completionHandler: completionHandler).resume()
    }
    
    static func add(obj:String, completionHandler: @escaping(_ data: Data?, _ response:URLResponse?, _ error:Error?) -> Void){
        
        var req = URLRequest(url: URL(string:"url-here/tasks")!)
        req.httpMethod = "POST"
        let bodyData = "objective=\(obj)"
        req.httpBody = bodyData.data(using: .utf8)
        URLSession.shared.dataTask(with: req, completionHandler: completionHandler).resume()
    }
    
    static func delete(index:Int, completionHandler: @escaping(_ data: Data?, _ response:URLResponse?, _ error:Error?) -> Void){
        var req = URLRequest(url: URL(string: "url-here/tasks/\(index)")!)
        req.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: req,completionHandler: completionHandler).resume()
    }
    
    static func update(index:Int,obj:String,completionHandler: @escaping(_ data: Data?, _ response:URLResponse?, _ error:Error?) -> Void){
        var req = URLRequest(url: URL(string: "url-here/tasks/\(index)")!)
        req.httpMethod = "PATCH"
        let bodyObj = ["objective": obj]
        do{
            req.httpBody = try JSONSerialization.data(withJSONObject: bodyObj)
        }catch{
            print(error)
        }
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: req, completionHandler: completionHandler).resume()
    }
}
