//
//  APIRouter.swift
//  SHTask
//
//  Created by Emad Habib on 28/10/2022.
//

import Foundation
import Alamofire


enum APIRouter:URLRequestConvertible {
    
    case none
    case searchByCity(cityName:String)
    case searchByZip(zipCode:String)
    case searchByCoordinates(lat:String,lng:String)
    
    case currentWeather(lat:String,lng:String)
    case forecastWeather(lat:String,lng:String)
    
    func asURLRequest() throws -> URLRequest {
        
        var method: HTTPMethod {
            switch self {
            case .currentWeather,.forecastWeather , .searchByCity , .searchByZip , .searchByCoordinates:
                return .get
            default:return.get
            }
        }
        
        let params: ([String: Any]?) = {
            switch self {
            case .currentWeather(let lat,let lng),.forecastWeather(let lat,let lng):
                return [
                    Params.lat.rawValue : lat,
                    Params.lon.rawValue : lng,
                    Params.appid.rawValue : Environment.WAETHER_APIKEY()
                ]
            case.searchByCity(let cityName):
                return [
                    Params.q.rawValue : cityName,
                    Params.limit.rawValue : 2,
                    Params.appid.rawValue : Environment.WAETHER_APIKEY()
                ]
            case.searchByZip(let zipCode):
                return [
                    Params.zip.rawValue : zipCode,
                    Params.appid.rawValue : Environment.WAETHER_APIKEY()
                ]
            case.searchByCoordinates(let lat,let lng):
                return [
                    Params.lat.rawValue : lat,
                    Params.lon.rawValue : lng,
                    Params.limit.rawValue : 2,
                    Params.appid.rawValue : Environment.WAETHER_APIKEY()
                ]
            default:return [:]
            }
        }()
        
        let url: URL = {
            // Add base url for the request
            let baseURL:String = {
                switch self {
                case.searchByCoordinates,.searchByZip,.searchByCity:
                    return Environment.APILoctionPath()
                default:
                    return Environment.APIBasePath()
                }
            }()
            
            // build up and return the URL for each endpoint
            let relativePath: String? = {
                switch self {
                case .currentWeather:
                    return "weather"
                case.forecastWeather:
                    return "forecast"
                case.searchByCity:
                    return "direct"
                case.searchByZip:
                    return "zip"
                case.searchByCoordinates:
                    return "reverse"
                default:return ""
                }
            }()
            
            var url = URL(string: baseURL)!
            if let relativePath = relativePath {
                url = url.appendingPathComponent(relativePath)
            }
            plog(url)
            return url
        }()
        
        let encoding:ParameterEncoding = {
            return URLEncoding.default
        }()
        
        let headers:[String:String]? = {
            return nil
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        return try encoding.encode(urlRequest, with: params)
    }
}
