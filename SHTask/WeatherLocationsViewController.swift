//
//  WeatherLocationsViewController.swift
//  SHTask
//
//  Created by Emad Habib on 28/10/2022.
//

import UIKit
import RxSwift
import CoreLocation
import MapKit

class WeatherLocationsViewController: BaseViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var superViewHeight:NSLayoutConstraint!
    @IBOutlet weak var footerView:UIView!
    @IBOutlet weak var searchTF:UITextField!
    
    var viewModel : WeatherLocationsViewModel!
    var locations = [Location]()
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultSearch()
        setup()
        setLocation()
    }
    
    private func setLocation(){
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
    }
    
    private func setup(){
        searchTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tableView.register(UINib(nibName: "LocationTCell", bundle: nil), forCellReuseIdentifier: "LocationTCell")
        tableView.delegate = self
        tableView.dataSource = self
        searchTF.textColor = .black
        searchTF.attributedPlaceholder =
        NSAttributedString(string: "Search City", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
    }
    
    @IBAction func backTapped(_ sender:UIButton) {
        self.viewModel.goToHome.onNext(Void())
    }
    
    @IBAction func reneewSearchTapped(_ sender:UIButton) {
        defaultSearch()
    }
    
    private func defaultSearch(){
        self.viewModel.lastString = ""
        self.footerView.isHidden = true
        self.superViewHeight.constant = 145
        self.tableView.isHidden = true
        DispatchQueue.main.async {
            self.view.layoutIfNeeded()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        plog("didUpdateLocations")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied) {
            // The user denied authorization
        } else if (status == CLAuthorizationStatus.authorizedAlways) {
            // The user accepted authorization
            self.locationManager.startUpdatingLocation()
        }
    }
}

extension WeatherLocationsViewController {
    
    func performSearchRequest() {
        let request = MKLocalSearch.Request()
        let locationManager = CLLocationManager()
        guard let coordinate = locationManager.location?.coordinate else { return }
        
        request.naturalLanguageQuery = "\(searchTF.text ?? "")"
        request.region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 100000000, longitudinalMeters: 100000000)
        // about a couple miles around you
        
        MKLocalSearch(request: request).start { (response, error) in
            guard error == nil else { return }
            guard let response = response else { return }
            guard response.mapItems.count > 0 else { return }
            
            var locations = [Location]()
            for location in response.mapItems {
                plog(location.name)
                let location = Location(locationName: location.name!, location: "")
                locations.append(location)
            }
            
            DispatchQueue.main.async {
                self.footerView.isHidden = false
                self.superViewHeight.constant = 400
                self.tableView.isHidden = false
                self.view.layoutIfNeeded()
                
                self.locations = locations
                self.tableView.reloadData()
            }
        }
    }
}

extension WeatherLocationsViewController :  UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTCell", for: indexPath) as! LocationTCell
        cell.locationBoldLbl.text = self.locations[indexPath.row].locationName ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // SELECT LOCATION
        // DISMISS SCREEN
        // CHANGE HOME INFO
        
        //        let selectedModel = self.viewModel.locationsData.value[indexPath.row]
        //        self.viewModel.popToHomeWithSearchResult.onNext(selectedModel)
    }
    
}

extension WeatherLocationsViewController  {
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text , text.count > 1 {
            self.viewModel.lastString = text
            self.performSearchRequest()
        }
        else {
            defaultSearch()
        }
    }
}

class Location: NSObject {
    var locationName: String!
    var location: String!
    
    init(locationName: String, location: String) {
        self.locationName = locationName
        self.location = location
    }
}
