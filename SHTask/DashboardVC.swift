//
//  DashboardVC.swift
//  SHTask
//
//  Created by Emad Habib on 25/03/2023.
//

import UIKit
import RxSwift

class DashboardVC: BaseViewController{
    
    @IBOutlet weak var tableView :UITableView!
    
    @IBOutlet weak var cityNameTF :UITextField!
    @IBOutlet weak var zipCodeTF :UITextField!
    @IBOutlet weak var latTF :UITextField!
    @IBOutlet weak var lonTF :UITextField!
    
    @IBOutlet weak var cityControl :UISwitch!
    @IBOutlet weak var zipControl :UISwitch!
    @IBOutlet weak var latlngControl :UISwitch!
    @IBOutlet weak var currentControl :UISwitch!
    
    @IBOutlet weak var cityNameVw :UIView!
    @IBOutlet weak var zipCodeVw :UIView!
    @IBOutlet weak var latlngVw :UIStackView!
    
    @IBOutlet weak var currentLbl :UILabel!
    @IBOutlet weak var selectedLbl :UILabel!
    
    @IBOutlet weak var navigationsButtVw :UIStackView!
    
    var viewModel : DashboardVM!
    var selectedSearchType:DashSearchType? = nil
    
    enum TabCells : String{
        case RecentTCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHiddenFields()
        setupUI()
        setTextFieldsListen()
        setupBindingData()
        LocationManager.requestGPS()
        
    }
    
    private func setupUI() {
        tableView.register(UINib(nibName: TabCells.RecentTCell.rawValue, bundle: nil), forCellReuseIdentifier: TabCells.RecentTCell.rawValue)
    }
    
    @IBAction func switchValueDidChange(_ control : UISwitch) {
        // SET CURRENT SEARCH TYPE
        self.selectedSearchType = DashSearchType(rawValue: control.tag)
        // CHANGE ACTIVATE FIELDS
        self.enableTextField(searchType: self.selectedSearchType!,isOn: !control.isOn)
    }
    
    private func setTextFieldsListen(){
        self.cityNameTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.zipCodeTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.latTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.lonTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func setHiddenFields(){
        self.viewModel.clearSearchModel()
        self.navigationsButtVw.isHidden = true
        self.cityNameVw.isHidden = true
        self.zipCodeVw.isHidden = true
        self.latlngVw.isHidden = true
        self.currentLbl.isHidden = true
        self.selectedLbl.isHidden = true
    }
    
    private func enableTextField(searchType:DashSearchType,isOn:Bool) {
        setHiddenFields()
        
        switch searchType {
        case .city:
            self.cityNameVw.isHidden = isOn
            self.zipControl.isOn = false
            self.latlngControl.isOn = false
            self.currentControl.isOn = false
        case .zip:
            self.zipCodeVw.isHidden = isOn
            self.cityControl.isOn = false
            self.latlngControl.isOn = false
            self.currentControl.isOn = false
        case .latlng:
            self.latlngVw.isHidden = isOn
            self.cityControl.isOn = false
            self.zipControl.isOn = false
            self.currentControl.isOn = false
        case .current:
            self.currentLbl.isHidden = isOn
            self.cityControl.isOn = false
            self.zipControl.isOn = false
            self.latlngControl.isOn = false
            if !isOn {
                // GET CURRENT LOCATION AND COMPLETE ALL TASKS SELF
                // GET YOUR WEATHER STATES
                if let location = LocationManager.shared.location {
                    self.currentLbl.text = "\(location.coordinate.latitude) , \(location.coordinate.longitude)"
                    self.navigationsButtVw.isHidden = false
                }
            }
        }
        
        DispatchQueue.main.async {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func navigationAction(sender:UIButton) {
        if sender.tag == 0 { // Current Screen
            if  self.viewModel.searchModel.lat != "" && self.viewModel.searchModel.lng != "" {
                self.viewModel.currentScreenBehavior.accept(self.viewModel.searchModel)
            }
        }
        else { // Forecast Screen
            
        }
    }
    
}

extension DashboardVC  {
    func setupBindingData(){
        
        LocationManager.shared.locationHandler = { [weak self] location in
            guard let self = self else {return}
            if self.selectedSearchType == .current {
                // GET YOUR WEATHER STATES
                self.currentLbl.text = "\(location.coordinate.latitude) , \(location.coordinate.longitude)"
                self.navigationsButtVw.isHidden = false
            }
        }
        
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
                let okAction = UIAlertAction(title: "Ok", style: .default)
                self.showAlertDialogueWithAction(title: title, withMessage: message, withActions: okAction)
                
            }).disposed(by: disposeBag)
        
        viewModel.locationsResponse.bind(to: tableView.rx.items(cellIdentifier: TabCells.RecentTCell.rawValue,
                                                                cellType: RecentTCell.self)) { (index, model, cell) in
            cell.recentTitleLbl.text = model.name
        }.disposed(by: disposeBag)
        
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(LocationSearchModel.self)).bind {
            [weak self] index, location in
            guard let self = self else { return }
            if let lat = location.lat , let lng = location.lon {
                self.viewModel.saveLastSearch(lat: "\(lat)", lng: "\(lng)")
                self.viewModel.searchModel.lat = "\(lat)"
                self.viewModel.searchModel.lng = "\(lng)"
                self.navigationsButtVw.isHidden = false
                self.selectedLbl.isHidden = false
                self.selectedLbl.text = "Selected : \(location.name ?? "")"
            }
            
        }.disposed(by: disposeBag)
        
    }
}

extension DashboardVC  {
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == self.cityNameTF , let text = textField.text{
            if text.count > 0 {
                self.viewModel.searchModel.cityName = text
                self.viewModel.searchLocationWith(searchType: .city)
            }
            else {textClear()}
        }
        else if textField == self.zipCodeTF , let text = textField.text , text.count > 0{
            if text.count > 0 {
                self.viewModel.searchModel.zipCode = text
                self.viewModel.searchLocationWith(searchType: .zip)
            }
            else {textClear()}
        }
        else if textField == self.latTF , let text = textField.text , text.count > 0 {
            if text.count > 0 {
                self.viewModel.searchModel.lat = text
                if viewModel.searchModel.lng.count > 0{
                    self.viewModel.searchLocationWith(searchType: .latlng)
                }
            }
            else {textClear()}
        }
        else if textField == self.lonTF , let text = textField.text , text.count > 0{
            if text.count > 0 {
                self.viewModel.searchModel.lng = text
                if viewModel.searchModel.lat.count > 0 {
                    self.viewModel.searchLocationWith(searchType: .latlng)
                }
            }
            else {textClear()}
        }
    }
    
    private func textClear(){
        self.viewModel.clearSearchModel()
        self.navigationsButtVw.isHidden = true
        self.selectedLbl.isHidden = true
        self.selectedLbl.text = ""
    }
}
