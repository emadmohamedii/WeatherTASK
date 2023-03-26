//
//  Weather.swift
//  SHTask
//
//  Created by Emad Habib on 25/03/2023.
//

import Foundation
import SwiftyJSON

class WeatherResponseModel{
    
    var base : String!
    var clouds : CloudModel!
    var cod : Int!
    var coord : CoordModel!
    var dt : Int!
    var id : Int!
    var main : MainModel!
    var name : String!
    var sys : SyModel!
    var timezone : Int!
    var visibility : Int!
    var weather : [WeatherModel]!
    var wind : WindModel!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        base = json["base"].stringValue
        let cloudsJson = json["clouds"]
        if !cloudsJson.isEmpty{
            clouds = CloudModel(fromJson: cloudsJson)
        }
        cod = json["cod"].intValue
        let coordJson = json["coord"]
        if !coordJson.isEmpty{
            coord = CoordModel(fromJson: coordJson)
        }
        dt = json["dt"].intValue
        id = json["id"].intValue
        let mainJson = json["main"]
        if !mainJson.isEmpty{
            main = MainModel(fromJson: mainJson)
        }
        name = json["name"].stringValue
        let sysJson = json["sys"]
        if !sysJson.isEmpty{
            sys = SyModel(fromJson: sysJson)
        }
        timezone = json["timezone"].intValue
        visibility = json["visibility"].intValue
        weather = [WeatherModel]()
        let weatherArray = json["weather"].arrayValue
        for weatherJson in weatherArray{
            let value = WeatherModel(fromJson: weatherJson)
            weather.append(value)
        }
        let windJson = json["wind"]
        if !windJson.isEmpty{
            wind = WindModel(fromJson: windJson)
        }
    }
    
}


class WeatherModel{

    var descriptionField : String!
    var icon : String!
    var id : Int!
    var main : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        descriptionField = json["description"].stringValue
        icon = json["icon"].stringValue
        id = json["id"].intValue
        main = json["main"].stringValue
    }

}
