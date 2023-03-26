//
//  DashboardVM.swift
//  SHTask
//
//  Created by Emad Habib on 26/03/2023.
//

import Foundation
import RxSwift
import RxRelay
import SwiftyJSON

class DashboardVM : BaseViewModel {
    
    typealias Dependencies = HasAPI & HasCoreData
    private let dependencies: Dependencies
    let isLoading: ActivityIndicator =  ActivityIndicator()
    var locationsResponse:  BehaviorRelay<[LocationSearchModel]> = BehaviorRelay<[LocationSearchModel]>(value: [])
    var currentScreenBehavior:  BehaviorRelay<SearchModel?> = BehaviorRelay<SearchModel?>(value: nil)
    var searchModel = SearchModel()
    
    init(dependencies: Dependencies){
        self.dependencies = dependencies
        super.init()
    }
    
    func clearSearchModel(){
        self.searchModel.clear()
        self.locationsResponse.accept([])
    }
    
}

extension DashboardVM {
    
    func searchLocationWith(searchType:DashSearchType) {
        var apiRouter : APIRouter
        switch searchType {
        case .city:
            apiRouter = APIRouter.searchByCity(cityName: searchModel.cityName)
        case .zip:
            apiRouter = APIRouter.searchByZip(zipCode: searchModel.zipCode)
        case .latlng,.current:
            apiRouter = APIRouter.searchByCoordinates(lat: searchModel.lat, lng: searchModel.lng)
        }
        
        dependencies.api.regularRequest(apiRouter: apiRouter)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe {[weak self] (event) in
                guard let `self` = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success(let value):
                        plog(value)
                        let json = JSON(value)
                        if searchType == .zip {
                            let response = LocationSearchModel(fromJson: json)
                            if let _ = response.name {
                                self.locationsResponse.accept([response])
                            }
                        }
                        else {
                            let response = LocationResponseModel(fromJson: json)
                            if let dta = response.data ,dta.count > 0 {
                                self.locationsResponse.accept(dta)
                            }
                        }
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

extension DashboardVM {
    
    func saveLastSearch(lat:String,lng:String){
        UserDefaults.standard.set(lat, forKey: "lat")
        UserDefaults.standard.set(lat, forKey: "lng")
    }
    
    func loadLastSearch() ->(String,String) {
        if let lat = UserDefaults.standard.object(forKey: "lat") as? String,  let lng = UserDefaults.standard.object(forKey: "lng") as? String {
            return (lat,lng)
        }
        return ("","")
    }
    
}
