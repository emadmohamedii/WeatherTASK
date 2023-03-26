//
//  FWeatherModel.swift
//  SHTask
//
//  Created by Emad Habib on 25/03/2023.
//


import Foundation
import SwiftyJSON

class FWeatherModel{

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
