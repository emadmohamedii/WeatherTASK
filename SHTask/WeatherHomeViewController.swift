//
//  WeatherHomeVC.swift
//  SHTask
//
//  Created by Emad Habib on 28/10/2022.
//

import UIKit
import RxSwift
import RxCocoa

class WeatherHomeViewController: BaseViewController {
    
    var viewModel: WeatherHomeViewModel!
    
    @IBOutlet weak var dateTimeHoursLbl: UILabel!
    @IBOutlet weak var LocationTitleLbl: UILabel!
    @IBOutlet weak var fullDateLbl: UILabel!
    
    @IBOutlet weak var weatherSmallDescLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var mphlbl: UILabel!
    @IBOutlet weak var precentLbl: UILabel!
    
    @IBOutlet weak var weatherIconImgV: UIImageView!
    
    //MARK:- View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBindingData()

        
        self.viewModel.goToLocations.onNext(Void())
    }
    
    // MARK: - Memory Management Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchTapped(_ sender:UIButton) {
        self.viewModel.goToLocations.onNext(Void())
    }
}


//MARK: - Setup Methods
extension WeatherHomeViewController {
    
    private func setupBindingData(){
        
        viewModel.isLoading
            .distinctUntilChanged()
            .drive(onNext: { [weak self] (isLoading) in
                guard let `self` = self else { return }
                self.hideActivityIndicator()
                if isLoading {
                    self.showActivityIndicator()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.alertDialog.observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] (title, message) in
                guard let `self` = self else {return}
                let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                    //                    self.viewModel.popTo.onNext(())
                }
                self.showAlertDialogueWithAction(title: title, withMessage: message, withActions: okAction)
                
            }).disposed(by: disposeBag)
        
        
//        viewModel.weatherDetailResponse.subscribe(onNext: { [weak self] model in
//            guard let self else { return }
//            guard let _model = model , let currentData = _model.current , let location = _model.location , let forecast = _model.forecast else { return }
//
//            DispatchQueue.main.async {
//
//                self.LocationTitleLbl.text = location.name ?? "Location"
//
//                if let lastUpdatedDate = DateApp.date(fromString: currentData.lastUpdated ?? "", withFormat: .birthdayServer) {
//                    self.fullDateLbl.text = DateApp.string(fromDate: lastUpdatedDate, withFormat: .weatherFull)
//                    self.dateTimeHoursLbl.text = DateApp.string(fromDate: lastUpdatedDate, withFormat: .DayHour12)
//                }
//
//                self.tempLbl.text = "\(currentData.tempF ?? 0.0) °F"
//                self.mphlbl.text = "\(currentData.windMph ?? 0) mph"
//                self.precentLbl.text = "\(currentData.humidity ?? 0)%"
//
//                if let iconImage = currentData.condition.iconWithHttp , let url = URL(string: iconImage){
//                    self.weatherIconImgV.kf.setImage(with: url,placeholder: UIImage(named: "sun")) // sun as placeholder only
//                }
//
//                // you have two ways to filter array of days , filtler by date , filter by arrange
////                if let forecast = forecast.forecastday , forecast.count > 0 {
////                    for dayIndex in 0..<forecast.count {
////                        // you have only 3 days as configured in api request
////                        //first day is today , >>
////
////                        if dayIndex == 0 { // today
////                            self.todayTempLbl.text = "\(forecast[dayIndex].day.mintempF ?? 0.0)° / \(forecast[dayIndex].day.maxtempF ?? 0.0)°F"
////                            self.weatherSmallDescLbl.text = forecast[dayIndex].day.condition.text ?? currentData.condition.text
////                            if let iconImage = forecast[dayIndex].day.condition.iconWithHttp , let url = URL(string: iconImage){
////                                self.todayIconImgV.kf.setImage(with: url,placeholder: UIImage(named: "sun")) // sun as placeholder only
////                            }
////                        }
////                        else if dayIndex == 1 { // tom
////                            self.todayTempLbl.text = "\(forecast[dayIndex].day.mintempF ?? 0.0)° / \(forecast[dayIndex].day.maxtempF ?? 0.0)°F"
////                            if let iconImage = forecast[dayIndex].day.condition.iconWithHttp , let url = URL(string: iconImage){
////                                self.tomorrowIconImgV.kf.setImage(with: url,placeholder: UIImage(named: "sun")) // sun as placeholder only
////                            }
////                        }
////                        else { // next
////
////                            if let lastUpdatedDate = DateApp.date(fromString: forecast[dayIndex].date ?? "", withFormat: .yearMonthDay) {
////                                self.nextDayNameLbl.text = DateApp.string(fromDate: lastUpdatedDate, withFormat: .weekDayName)
////                            }else {
////                                self.nextDayNameLbl.text = ""
////                            }
////
////
////                            self.todayTempLbl.text = "\(forecast[dayIndex].day.mintempF ?? 0.0)° / \(forecast[dayIndex].day.maxtempF ?? 0.0)°F"
////                            if let iconImage = forecast[dayIndex].day.condition.iconWithHttp , let url = URL(string: iconImage){
////                                self.dayIconImgV.kf.setImage(with: url,placeholder: UIImage(named: "sun")) // sun as placeholder only
////                            }
////                        }
////                    }
////                }
//            }
//
//        }).disposed(by: disposeBag)
        
    }
}
