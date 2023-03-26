//
//  API.swift
//  SHTask
//
//  Created by Emad Habib on 28/10/2022.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire
import SwiftyJSON

class API {
    
    static let shared:API = {
        let instance = API()
        return instance
    }()
    
    init() {
        
    }
    
    private static func handleDataRequest(dataRequest: Observable<DataRequest>) -> Observable<[String:Any]?> {
        
        if NetworkReachabilityManager()!.isReachable == false {
            return Observable<[String: Any]?>.create({ (observer) -> Disposable in
                observer.on(.next(["Error":NSLocalizedString("Unable to contact the server", comment: "") ,
                                   "IsInternetOff":true]))
                observer.on(.completed)
                return Disposables.create()
            })
        }
        
        return Observable<[String: Any]?>.create({ (observer) -> Disposable in
            dataRequest.observeOn(MainScheduler.instance).subscribe({ (event) in
                switch event {
                case .next(let e):
                    plog(e.description)
                    e.responseJSON(completionHandler: { (dataResponse) in
                        switch dataResponse.result {
                        case .success(let data):
                            if let json = data as? [String:Any]  {
                                observer.onNext(json)
                            }
                            else if let json = data as? [Any] {
                                observer.onNext(["data":json])
                            }
                            else {
                                observer.onNext(nil)
                                return
                            }
                        case .failure(let error):
                            plog(error)
                            let errorCode = (error as NSError).code
                            if errorCode == -1005 || errorCode == -1009 {
                                observer.onNext(["Error": NSLocalizedString("Unable to contact the server", comment: ""),
                                                 "IsInternetOff":true])
                            } else {
                                observer.onNext(["Error":error.localizedDescription,
                                                 "IsInternetOff":false])
                            }
                            observer.onCompleted()
                        }
                    })
                case .error(let error):
                    plog(error)
                    observer.onNext(["Error":error.localizedDescription])
                    observer.onNext(nil)
                case .completed:
                    observer.onCompleted()
                }
            })
        })
    }
    
    func regularRequest(apiRouter :URLRequestConvertible) -> Observable<APIResult<[String:Any]>> {
        return API.handleDataRequest(dataRequest: APIManager.shared.requestObservable(api: apiRouter)).map({ (response) -> APIResult<([String:Any])> in
            guard let response = response else {return .failure(error: .init())}
            if (response).keys.contains("Error") {
                if (response).keys.contains("IsInternetOff") {
                    if let isInternetOff = response["IsInternetOff"] as? Bool {
                        if isInternetOff {
                            return APIResult.failure(error: APICallError(critical: false, code: InternetConnectionErrorCode.offline.rawValue, reason: response["Error"] as! String, message: response["Error"] as! String))
                        }
                    }
                }
                return APIResult.failure(error: APICallError(critical: false, code: response["code"] as? Int ?? 0, reason: response["Error"] as! String, message: response["Error"] as! String))
            }
            return APIResult.success(value: response)
        })
    }
    
    
    func getWeatherDetails(lat: String, lng: String) -> Observable<APIResult<WeatherResponseModel>> {
        return API.handleDataRequest(dataRequest: APIManager.shared.requestObservable(api: APIRouter.currentWeather(lat: lat, lng: lng))).map({ (response) -> APIResult<WeatherResponseModel> in
            if (response ?? [:]).keys.contains("Error"){
                if (response ?? [:]).keys.contains("IsInternetOff"){
                    if let isInternetOff = response!["IsInternetOff"] as? Bool{
                        if isInternetOff{
                            return APIResult.failure(error: APICallError(critical: false, code: InternetConnectionErrorCode.offline.rawValue, reason: response!["Error"] as! String, message: response!["Error"] as! String))
                        }
                    }
                }
                return APIResult.failure(error: APICallError(critical: false, code: 1111, reason: response!["Error"] as! String, message: response!["Error"] as! String))
            }
            let json = JSON(response)
            let apiResponse = WeatherResponseModel(fromJson: json)
            let (apiStatus, _) = (true,APICallError.init(status: .success))
            if apiStatus { return APIResult.success(value: apiResponse) }
        })
    }
    
}
