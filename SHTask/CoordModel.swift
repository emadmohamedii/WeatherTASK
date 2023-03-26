//
//  CoordModel.swift
//  SHTask
//
//  Created by Emad Habib on 25/03/2023.
//

import Foundation
import SwiftyJSON

class CoordModel{

    var lat : Float!
    var lon : Float!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        lat = json["lat"].floatValue
        lon = json["lon"].floatValue
    }

}
