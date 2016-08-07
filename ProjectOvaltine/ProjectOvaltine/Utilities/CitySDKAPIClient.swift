//
//  CitySDKAPIClient.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/5/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import Alamofire

class CitySDKAPIClient: Request {
    
    // MARK: Path Router
    let baseURL: String? = "http://citysdk.commerce.gov"
    let path: String? = "/"
    
    let parameters = ["parameterOne": "not implemented"]
    
    let key = Constants.CITYSDK_API_KEY
    
  
    // MARK: Request
    func sendAPIRequest() {
        guard self.baseURL != nil
            else {
                print("ERROR: Unable to get url path for API call")
                return
        }
        let url = NSURL(string: self.baseURL!)
        let request = NSMutableURLRequest(URL:url!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let json = ["level" : "county",
                    "zip" : "10001",
                    "variables" :[ "age" ],
                    "api":"acs5",
                    "year":"2014"]
        request.setValue(self.key, forHTTPHeaderField: "Authorization")
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(json, options: [])
        Alamofire.request(request)
            .responseJSON { response in
                switch response.result {
                case .Success(let responseObject):
                    print(responseObject)
                default:
                    print("ERROR")
                }

        }
    }

}