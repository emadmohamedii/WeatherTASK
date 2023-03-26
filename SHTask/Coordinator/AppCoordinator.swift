//
//  AppCoordinator.swift
//  SHTask
//
//  Created by Emad Habib on 28/10/2022.
//

import UIKit
import RxSwift
import CoreData


final class AppCoordinator: Coordinator<Void> {
    
    private let navigationController:UINavigationController
    private let window: UIWindow
    let dependencies: AppDependency
    
    init(window:UIWindow, navigationController:UINavigationController, managedContext: NSManagedObjectContext?) {
        self.window = window
        self.navigationController = navigationController
        self.dependencies = AppDependency(window: self.window, managedContext: managedContext)
    }
    
    override func start() -> Observable<Void> {
        return showWeatherHome()
    }
    
    private func showWeatherHome() -> Observable<Void> {
        let rootCoordinator = RootCoordinator(navigationController: navigationController, dependencies: self.dependencies)
        return coordinate(to: rootCoordinator)
    }
    
    deinit {
        plog(AppCoordinator.self)
    }
    
}

class RootCoordinator: Coordinator<Void>{
    typealias Dependencies = HasWindow & HasAPI & HasCoreData
    
    private let rootNavigationController:UINavigationController
    private let dependencies: Dependencies
    
    init(navigationController:UINavigationController, dependencies: Dependencies) {
        self.rootNavigationController = navigationController
        self.dependencies = dependencies
    }
    
    override func start() -> Observable<CoordinationResult> {
        let viewModel = DashboardVM(dependencies: self.dependencies)
        let viewController = DashboardVC()
        viewController.viewModel = viewModel
        
        viewModel.currentScreenBehavior.asObservable().subscribe(onNext: {[weak self] searchModel in
            guard let `self` = self ,let model = searchModel else {return}
            let vc = CurrentVC()
            let vm = CurrentVM(dependencies: self.dependencies, lat: model.lat, lng: model.lng)
            vc.viewModel = vm
            self.rootNavigationController.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
        
        rootNavigationController.pushViewController(viewController, animated: true)
        return Observable.never()
    }
    
//    func pushToLocationsView(selection:@escaping (String,String)->() ) {
//
//        let viewModel = WeatherLocationsViewModel.init(dependencies: self.dependencies)
//        let viewController = UIStoryboard.main.weatherLocationsViewController
//        viewController.viewModel = viewModel
//
//        viewModel.goToHome
//            .subscribe(onNext: { [weak self] in
//                guard let `self` = self else { return }
//                self.rootNavigationController.dismiss(animated: true)
//            }).disposed(by: disposeBag)
//
//        //        viewModel.popToHomeWithSearchResult
//        //            .subscribe(onNext: { [weak self] location in
//        //                guard let `self` = self else { return }
//        //                selection(location)
//        //            }).disposed(by: disposeBag)
//
//        viewController.modalPresentationStyle = .overFullScreen
//        viewController.modalTransitionStyle = .crossDissolve
//        rootNavigationController.present(viewController, animated: true)
//    }
    
    deinit {
        plog(RootCoordinator.self)
    }
}
