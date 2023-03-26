//
//  FListModel.swift
//  SHTask
//
//  Created by Emad Habib on 25/03/2023.
//

import Foundation
import SwiftyJSON

class FListModel{

    var clouds : CloudModel!
    var dt : Int!
    var dtTxt : String!
    var main : MainModel!
    var pop : Int!
    var sys : FSyModel!
    var visibility : Int!
    var weather : [FWeatherModel]!
    var wind : WindModel!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let cloudsJson = json["clouds"]
        if !cloudsJson.isEmpty{
            clouds = CloudModel(fromJson: cloudsJson)
        }
        dt = json["dt"].intValue
        dtTxt = json["dt_txt"].stringValue
        let mainJson = json["main"]
        if !mainJson.isEmpty{
            main = MainModel(fromJson: mainJson)
        }
        pop = json["pop"].intValue
        let sysJson = json["sys"]
        if !sysJson.isEmpty{
            sys = FSyModel(fromJson: sysJson)
        }
        visibility = json["visibility"].intValue
        weather = [FWeatherModel]()
        let weatherArray = json["weather"].arrayValue
        for weatherJson in weatherArray{
            let value = FWeatherModel(fromJson: weatherJson)
            weather.append(value)
        }
        let windJson = json["wind"]
        if !windJson.isEmpty{
            wind = WindModel(fromJson: windJson)
        }
    }

}
