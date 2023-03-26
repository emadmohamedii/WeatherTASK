//
//  ForecastModel.swift
//  SHTask
//
//  Created by Emad Habib on 25/03/2023.
//

import Foundation
import SwiftyJSON

class ForecastResponseModel{

    var city : FCityModel!
    var cnt : Int!
    var cod : String!
    var list : [FListModel]!
    var message : Int!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let cityJson = json["city"]
        if !cityJson.isEmpty{
            city = FCityModel(fromJson: cityJson)
        }
        cnt = json["cnt"].intValue
        cod = json["cod"].stringValue
        list = [FListModel]()
        let listArray = json["list"].arrayValue
        for listJson in listArray{
            let value = FListModel(fromJson: listJson)
            list.append(value)
        }
        message = json["message"].intValue
    }

}
