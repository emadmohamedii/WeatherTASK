//
//  WeatherHomeVM.swift
//  SHTask
//
//  Created by Emad Habib on 28/10/2022.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa
import CoreData

final class WeatherHomeViewModel: BaseViewModel {
    typealias Dependencies = HasAPI & HasCoreData
    
    // Dependencies
    private let dependencies: Dependencies
    var managedObjectContext: NSManagedObjectContext!
    
    /// Network request in progress
    let isLoading: ActivityIndicator =  ActivityIndicator()
    
    //API Result
    var getWeatherDetailData: Observable<APIResult<WeatherResponseModel>> {
        return _getWeatherDetailData.asObservable().observeOn(MainScheduler.instance)
    }
    private let _getWeatherDetailData = ReplaySubject<APIResult<WeatherResponseModel>>.create(bufferSize: 1)
    
    //Data
    var weatherDetailResponse:  BehaviorRelay<WeatherResponseModel?> = BehaviorRelay<WeatherResponseModel?>(value: nil)
    
    //Custom method
    var goToLocations = PublishSubject<Void>()
    //    var selectedLocation = PublishSubject<LocationsModel>()
    
    
    init(dependencies: Dependencies){
        self.dependencies = dependencies
        
        super.init()
        
        //        selectedLocation.asObservable().subscribe { [weak self] location in
        //            guard let  self  else {return}
        //            guard let locationElement = location.element  else { return }
        //            self.getWeatherDetails(location: locationElement.name)
        //        }.disposed(by: disposeBag)
        
        getWeatherDetailData
            .subscribe(onNext: { [weak self] (result) in
                guard let `self` = self else { return }
                switch result {
                case .success(let response):
                    self.weatherDetailResponse.accept(response)
                    // SAVE DATA TO CORE DATA FOR OFFLINE MODE IF U NEED
                    // HERE
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
}


//MARK:- API Call
extension WeatherHomeViewModel {
    
    func getWeatherDetails(lat:String,lon:String) {
        dependencies.api.getWeatherDetails(lat: lat, lng: lon)
            .trackActivity(isLoading)
            .observeOn(SerialDispatchQueueScheduler(qos: .default))
            .subscribe {[weak self] (event) in
                guard let `self` = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success:
                        self._getWeatherDetailData.on(event)
                    case .failure(let error):
                        self.alertDialog.onNext(("Error", error.message))
                    }
                default:
                    break
                }
            }.disposed(by: disposeBag)
    }
    
}
