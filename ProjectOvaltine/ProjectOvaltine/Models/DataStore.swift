//
//  CitySDKDataStore.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/5/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import CoreLocation


class DataStore {
    static let sharedInstance = DataStore()
    
    var cityModel = CityModel()
    var usModel = USModel()
    var cityScoresByDataSet: [String : String] = [:]
    var cityScoresByType: [String : String] = [:]
    var cityName : String?
    var countyName : String?
    var zipCode = "00000"
    var cityDataPoints:[CitySDKData] = []
    var comparisonData: ScoreModel?
    var comparisonPercentageData: ScoreModel?
    
    let cityAPI = CitySDKAPIClient()
    let censusAPI = CensusAPIClient()
    let levelOfLocationDetails = "county"
    let censusSurveyAPI = "acs5"
    let yearOfSurvey = "2014"
    let variablesToAdd = Array(CensusConstants.CENSUS_REQUEST_PARAMS.keys)
    let requestParameters = ["age",
                     "education_high_school",
                     "income_per_capita",
                     "median_contract_rent",
                     "employment_labor_force",
                     "population",
                     "commute_time_walked",
                     "poverty",
                     "employment_employed"]
    
    func getCitySDKData(completion: () -> ()) {
        cityAPI.sendAPIRequest(["level":self.levelOfLocationDetails, "zip":self.zipCode, "api":self.censusSurveyAPI, "year":self.yearOfSurvey, "variables":self.requestParameters]) { (cityData) in
            self.cityDataPoints = cityData
            completion()
        }
    }
    
    func getScoreModel(completion: () -> ()) {}
}