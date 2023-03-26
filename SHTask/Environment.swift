//
//  Environment.swift
//  SHTask
//
//  Created by Emad Habib on 28/10/2022.
//

import Foundation

enum Server {
    case developement
    case staging
    case production
}

class Environment {
    
    static let server:Server    =   .developement
    
    // To print the log set true.
    static let debug:Bool       =   true
    
    class func APIBasePath() -> String {
        switch self.server {
        case .developement:
            return "https://api.openweathermap.org/data/2.5/"
        case .staging:
            return "https://api.openweathermap.org/data/2.5/"
        case .production:
            return "https://api.openweathermap.org/data/2.5/"
        }
    }
    
    class func APILoctionPath() ->String {
        return "http://api.openweathermap.org/geo/1.0/"
    }
    
    class func APIVersionPath() -> String {
        switch self.server {
        case .developement:
            return "2.5"
        case .staging:
            return "2.5"
        case .production:
            return "2.5"
        }
    }
    
    class func WAETHER_APIKEY() -> String {
        switch self.server {
        case .developement:
            return "844312116c4766d5602e80720d13663a"
        case .staging:
            return "844312116c4766d5602e80720d13663a"
        case .production:
            return "844312116c4766d5602e80720d13663a"
        }
    }
}
