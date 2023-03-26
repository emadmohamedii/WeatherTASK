//
//  Sy.swift
//  SHTask
//
//  Created by Emad Habib on 25/03/2023.
//


import Foundation
import SwiftyJSON

class SyModel{

    var country : String!
    var id : Int!
    var sunrise : Int!
    var sunset : Int!
    var type : Int!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        country = json["country"].stringValue
        id = json["id"].intValue
        sunrise = json["sunrise"].intValue
        sunset = json["sunset"].intValue
        type = json["type"].intValue
    }

}
