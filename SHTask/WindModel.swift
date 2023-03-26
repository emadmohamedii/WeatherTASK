//
//  Wind.swift
//  SHTask
//
//  Created by Emad Habib on 25/03/2023.
//

import Foundation
import SwiftyJSON

class WindModel{

    var deg : Int!
    var gust : Float!
    var speed : Float!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        deg = json["deg"].intValue
        gust = json["gust"].floatValue
        speed = json["speed"].floatValue
    }

}
