//
//  MainModel.swift
//  SHTask
//
//  Created by Emad Habib on 25/03/2023.
//


import Foundation
import SwiftyJSON

class MainModel{

    var feelsLike : Float!
    var grndLevel : Int!
    var humidity : Int!
    var pressure : Int!
    var seaLevel : Int!
    var temp : Float!
    var tempMax : Float!
    var tempMin : Float!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        feelsLike = json["feels_like"].floatValue
        grndLevel = json["grnd_level"].intValue
        humidity = json["humidity"].intValue
        pressure = json["pressure"].intValue
        seaLevel = json["sea_level"].intValue
        temp = json["temp"].floatValue
        tempMax = json["temp_max"].floatValue
        tempMin = json["temp_min"].floatValue
    }

}
