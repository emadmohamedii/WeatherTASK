//
//  CurrentVC.swift
//  SHTask
//
//  Created by Emad Habib on 26/03/2023.
//

import UIKit

class CurrentVC: BaseViewController {
    
    var viewModel:CurrentVM!
    
    @IBOutlet weak var countryLbl:UILabel!
    @IBOutlet weak var tempLbl:UILabel!
    @IBOutlet weak var humLbl:UILabel!
    @IBOutlet weak var windLbl:UILabel!
    @IBOutlet weak var descLbl:UILabel!
    
    @IBOutlet weak var stackDataVw:UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBinding()
        setUI()
    }
    
    private func setUI(){
        stackDataVw.isHidden = true
    }
    
    private func setBinding(){
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
        
        self.viewModel.currentResponse.asObservable().subscribe { [weak self] model in
            guard let self = self , let _model = model.element , let model = _model else {return}
            DispatchQueue.main.async {
                self.countryLbl.text = model.name
                self.descLbl.text = model.weather.first?.descriptionField ?? "NOT FOUND"
                if let main = model.main , let hum = main.humidity , let temp = main.temp {
                    self.humLbl.text = "\(hum)%"
                    self.tempLbl.text = "\(temp)°F"
                }
                self.windLbl.text = "\(model.wind.gust ?? 0) meter/sec"
                self.stackDataVw.isHidden = false
            }
        }.disposed(by: disposeBag)
        
    }
}
