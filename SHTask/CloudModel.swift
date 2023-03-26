//
//  CloudModel.swift
//  SHTask
//
//  Created by Emad Habib on 25/03/2023.
//


import Foundation
import SwiftyJSON

class CloudModel{

    var all : Int!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        all = json["all"].intValue
    }

}
