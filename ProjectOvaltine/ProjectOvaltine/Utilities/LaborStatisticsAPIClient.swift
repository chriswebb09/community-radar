//
//  LaborStatisticsAPIClient.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/5/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import Alamofire

class LaborStatisticsAPIClient: Request {
    
    static let sharedInstance = LaborStatisticsAPIClient()
    
    let baseURL: String? = " "
    let path: String? = "/"
    let parameters = ["parameterOne": "not implemented"]
    
    let key = Constants.BLS_API_KEY
    
    
    //MARK request
    func sendAPIRequest() {
        guard self.baseURL != nil
            else {
                print("ERROR: Unable to get url path for API call")
                return
        }
        
        let url = NSURL(string: self.baseURL!)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let json = ["notImplemented": "yet"]
        request.setValue(self.key, forHTTPHeaderField: "Authorization")
        
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(json, options: [])
        
        
        Alamofire.request(request)
            .responseJSON { response in
                print(response.response)
        }
    }
    
}