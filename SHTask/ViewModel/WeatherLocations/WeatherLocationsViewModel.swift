//
//  WeatherLocationsViewModel.swift
//  SHTask
//
//  Created by Emad Habib on 28/10/2022.
//


import Foundation
import Alamofire
import RxSwift
import RxCocoa
import CoreData

final class WeatherLocationsViewModel: BaseViewModel {
    typealias Dependencies = HasAPI & HasCoreData
    
    // Dependencies
    private let dependencies: Dependencies
    var managedObjectContext: NSManagedObjectContext!
    
    /// Network request in progress
    let isLoading: ActivityIndicator =  ActivityIndicator()
    
    //API Result
//    var locationsData = Variable<[LocationsModel]>([])
    
    //Custom method
    var goToHome = PublishSubject<Void>()
    var lastString = ""
//    var selectedLocation = PublishSubject<LocationModel>()
    
    //Custom method
//    var popToHomeWithSearchResult = PublishSubject<LocationsModel>()

    
    init(dependencies: Dependencies){
        self.dependencies = dependencies
        
        super.init()
    }
    
}


//MARK:- API Call
extension WeatherLocationsViewModel {
    
    func reSearch(){
//        self.locationsData.value = []
        searchLocationWith(name: self.lastString)
    }
    
    func searchLocationWith(name:String) {
        
//        dependencies.api.getLocations(name: name)
//            .trackActivity(isLoading)
//            .observeOn(MainScheduler.asyncInstance)
//            .subscribe {[weak self] (event) in
//                guard let `self` = self else { return }
//                switch event {
//                case .next(let result):
//                    switch result {
//                    case .success(let value):
//                        if let locations = value.location , locations.count > 0 {
//                            self.locationsData.value = locations
//                        }
//                    case .failure(let error):
//                        if error.code == InternetConnectionErrorCode.offline.rawValue {
//                            // GET FROM CACHED CORE DATA
//                        } else {
//                            self.alertDialog.onNext(("Error", error.message))
//                        }
//                    }
//                default:
//                    break
//                }
//            }.disposed(by: disposeBag)
    }
    
}
