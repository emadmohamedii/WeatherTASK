//
//  CityModelResponse.swift
//  SHTask
//
//  Created by Emad Habib on 26/03/2023.
//

import Foundation
import SwiftyJSON

class LocationResponseModel{
    
    var data : [LocationSearchModel]!
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        data = [LocationSearchModel]()
        let listArray = json["data"].arrayValue
        for listJson in listArray{
            let value = LocationSearchModel(fromJson: listJson)
            data.append(value)
        }
    }
}

class LocationSearchModel{
    

    var country : String!
    var lat : Float!
    var localNames : LocalNameModel!
    var lon : Float!
    var name : String!
    var state : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }

        country = json["country"].stringValue
        lat = json["lat"].floatValue
        let localNamesJson = json["local_names"]
        if !localNamesJson.isEmpty{
            localNames = LocalNameModel(fromJson: localNamesJson)
        }
        lon = json["lon"].floatValue
        name = json["name"].stringValue
        state = json["state"].stringValue
    }
    
}


class LocalNameModel{
    
    var ascii : String!
    var ca : String!
    var en : String!
    var featureName : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        ascii = json["ascii"].stringValue
        ca = json["ca"].stringValue
        en = json["en"].stringValue
        featureName = json["feature_name"].stringValue
    }
    
}
