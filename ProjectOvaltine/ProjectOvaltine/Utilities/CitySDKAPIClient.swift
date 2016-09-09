
//
//  CitySDKAPIClient.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/5/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON

class CitySDKAPIClient {
    
    let baseURL: String = Constants.CITYSDK_URL
    let key = Constants.CITYSDK_API_KEY
    
    var couldNotReturn = false
    
    // MARK: Request
    func sendAPIRequest(params: NSDictionary, completion: ([CitySDKData]) -> ()) {
        guard let url = NSURL(string:baseURL)
            else {
                print("ERROR: Unable to get url path for API call")
                return
        }
        
        let request = NSMutableURLRequest(URL:url)
        
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(self.key, forHTTPHeaderField: "Authorization")
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
        
        Alamofire.request(request).responseJSON { (response) in
            
            switch response.result {
                
            case .Success(let responseObject):
                var cityDataPoints: [CitySDKData] = []
                
                let response = responseObject as! NSDictionary
                
                guard let feat = response["features"] as? NSArray else { return }
                guard let geo = feat[0]["geometry"] as? NSDictionary else { return }
                
                let jsonProperties = JSON(feat[0]["properties"] as! NSDictionary)
                
                if let coords = geo["coordinates"] as? NSArray {
                    
                    if coords[0].count > 100 {
                        
                        let newData = CitySDKData(json: jsonProperties, geoJSON: coords[0] as! NSArray)
                        cityDataPoints.append(newData)
                        
                    } else if coords[0][0].count > 100 {
                        
                        guard let deeperCoords = (coords[0] as! NSArray)[0] as? NSArray else { return }
                        
                        let otherData = CitySDKData(json: jsonProperties, geoJSON: deeperCoords)
                        cityDataPoints.append(otherData)
                        
                    } else {
                        print("ERROR - SOMETHING IS WRONG WITH THE CALL TO THE ARRAYS")}
                }
                completion(cityDataPoints)
            default:
                print("ERROR - CITYSDK CANNOT BE REACHED")
                self.couldNotReturn = true
            }
        }
    }
}