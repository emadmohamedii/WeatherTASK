//
//  APIManager.swift
//  SHTask
//
//  Created by Emad Habib on 28/10/2022.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire


class APIManager {

    static let shared:APIManager = {
        let instance = APIManager()
        return instance
    }()
    
    let sessionManager:Session
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.urlCache = nil
        sessionManager = Alamofire.Session(configuration: configuration)
    }
    
    func requestObservable(api:APIRouter) -> Observable<DataRequest> {
        return sessionManager.rx.request(urlRequest: api)
    }
    
    func requestObservable(api:URLRequestConvertible) -> Observable<DataRequest> {
        return sessionManager.rx.request(urlRequest: api)
    }
}
