//
//  ViewController.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/4/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let level = "county"
    let zip = "10001"
    let api = "acs5"
    let year = "2014"
    // data: [CitySDKData] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let api = CitySDKAPIClient.sharedInstance
        
        let data = DataStore.sharedInstance
        data.getCitySDKData() {
            print(data.cityDataPoints)
        }
        print(data.cityDataPoints)
        
        
        
//        print(api.sendAPIRequest(self.level, zip: self.zip, api: self.api, year: self.year, completion: ()->()))
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

