//
//  RequestHandler.swift
//  soldier
//
//  Created by Кирилл Жаренков on 25.12.16.
//  Copyright © 2016 Кирилл Жаренков. All rights reserved.
//
import Foundation

class RequestHandler{
   private var request : URLRequest
   private  var session : URLSession
    
    init(url:String) {
        request = URLRequest(url: URL(string: url)! as URL)
        session = URLSession.shared
    }
    var httpMethod: String?{
        
        get{
            return request.httpMethod
        }
        set(value) {
            self.request.httpMethod = value
        }
    }
    var httpBody:Data? {
        
        get{
            return request.httpBody
        }
        set (value){
            request.httpBody = value
        }
    }
    
    func sendRequest(){
        session.dataTask(with: request, completionHandler: {data, response, error ->() in
            print("Response: \(response)")}).resume()
        
    }
}
