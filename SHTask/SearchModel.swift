//
//  SearchModel.swift
//  SHTask
//
//  Created by Emad Habib on 26/03/2023.
//

import Foundation


enum DashSearchType :Int{
    case city = 0
    case zip = 1
    case latlng = 2
    case current = 3
}

class SearchModel {
    var cityName:String = ""
    var zipCode:String = ""
    var lat:String = ""
    var lng:String = ""
    
    func clear(){
        self.cityName = ""
        self.zipCode = ""
        self.lat = ""
        self.lng = ""
    }
}
