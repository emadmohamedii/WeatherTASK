//
//  CurrentVM.swift
//  SHTask
//
//  Created by Emad Habib on 26/03/2023.
//

import Foundation
import RxSwift
import RxRelay
import SwiftyJSON

class CurrentVM : BaseViewModel {
    
    typealias Dependencies = HasAPI & HasCoreData
    private let dependencies: Dependencies
    let isLoading: ActivityIndicator =  ActivityIndicator()
    var currentResponse:  BehaviorRelay<WeatherResponseModel?> = BehaviorRelay<WeatherResponseModel?>(value: nil)
    var lat:String
    var lng:String
    
    
    init(dependencies: Dependencies , lat:String , lng:String){
        self.dependencies = dependencies
        self.lat = lat
        self.lng = lng
        super.init()
        
        getCurrent(lat: lat, lng: lng)
    }
    
}

extension CurrentVM {
    
    func getCurrent(lat: String, lng: String) {
        let apiRouter : APIRouter = APIRouter.currentWeather(lat: lat, lng: lng)
        dependencies.api.regularRequest(apiRouter: apiRouter)
            .trackActivity(isLoading)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe {[weak self] (event) in
                guard let `self` = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success(let value):
                        plog(value)
                        let json = JSON(value)
                        let response = WeatherResponseModel(fromJson: json)
                        self.currentResponse.accept(response)
                    case .failure(let error):
                        if error.code == InternetConnectionErrorCode.offline.rawValue {
                            // GET FROM CACHED CORE DATA
                        } else {
                            self.alertDialog.onNext(("Error", error.message))
                        }
                    }
                default:
                    break
                }
            }.disposed(by: disposeBag)
    }
}
