//
//  ConfirmLocationViewController.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 5/11/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//
import UIKit
import MapKit
import Alamofire



class ConfirmLocationViewController: UIViewController {

    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var mapConfirm: UIButton!
    @IBOutlet weak var mapview: MKMapView!
    
    var getUserInfo : GetRecievedTradeDetails!
    
    var locationManager:CLLocationManager?
    //let annotations = MKPointAnnotation()
    var lastKnownLocation: CLLocation!
    
    override func viewWillAppear(_ animated: Bool) {
        if (getUserInfo.trade.contactInformation.party1Name != nil) {
            userName.text = getUserInfo.trade.contactInformation.party1Name
        }
        
        if (getUserInfo.trade.contactInformation.party1PhoneNumber != nil) {
            phoneNumber.text = getUserInfo.trade.contactInformation.party1PhoneNumber
        }
        
        if getUserInfo.trade.contactInformation.party1Address != nil {
            address.text = getUserInfo.trade.contactInformation.party1Address
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapConfirm.layer.cornerRadius = 15
        getUserLocation()
    }

    func getUserLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.showsBackgroundLocationIndicator = true
        locationManager?.startUpdatingLocation()
    }
    
    @IBAction func getPositionClicked(_ sender: Any) {
        lastKnownLocation = CLLocation(latitude: mapview.region.center.latitude, longitude: mapview.region.center.longitude)
        
        print("Lat : \(lastKnownLocation.coordinate.latitude) \nLng : \(lastKnownLocation.coordinate.longitude)")
        
        mapConfirm.isHidden = true
        mapConfirm.isEnabled = false
        mapConfirm.backgroundColor = UIColor.darkGray
        
        NetworkLayer.acceptOffer(tradeID: getUserInfo.trade.id, latitude: String(lastKnownLocation.coordinate.latitude), longitude: String(lastKnownLocation.coordinate.longitude))
        
        navigationController?.popToRootViewController(animated: true)
    }
}

extension ConfirmLocationViewController:  CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            lastKnownLocation = location
            let coordinateRegion = MKCoordinateRegion(center: lastKnownLocation.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
            mapview.setRegion(coordinateRegion, animated: true)
            locationManager!.stopUpdatingLocation()
            let annotations = MKPointAnnotation()
            annotations.title = "Your current location"
            annotations.coordinate = lastKnownLocation.coordinate
            mapview.addAnnotation(annotations)
    
            let newPoint = self.mapview.convert(mapview.centerCoordinate, toPointTo: self.view)

            let pinImage = UIImage(systemName: "mappin")
            let imageView = UIImageView(image: pinImage) // set as you want
    
            imageView.image = pinImage
            imageView.backgroundColor = UIColor.clear
            imageView.contentMode = UIView.ContentMode.center
            imageView.center.y = newPoint.y
            imageView.center.x = newPoint.x
    
            self.view.addSubview(imageView)
        }
    }
}

