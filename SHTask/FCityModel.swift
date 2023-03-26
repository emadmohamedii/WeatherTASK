//
//  FCityModel.swift
//  SHTask
//
//  Created by Emad Habib on 25/03/2023.
//

import Foundation
import SwiftyJSON

class FCityModel{

    var coord : CoordModel!
    var country : String!
    var id : Int!
    var name : String!
    var population : Int!
    var sunrise : Int!
    var sunset : Int!
    var timezone : Int!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let coordJson = json["coord"]
        if !coordJson.isEmpty{
            coord = CoordModel(fromJson: coordJson)
        }
        country = json["country"].stringValue
        id = json["id"].intValue
        name = json["name"].stringValue
        population = json["population"].intValue
        sunrise = json["sunrise"].intValue
        sunset = json["sunset"].intValue
        timezone = json["timezone"].intValue
    }

}
