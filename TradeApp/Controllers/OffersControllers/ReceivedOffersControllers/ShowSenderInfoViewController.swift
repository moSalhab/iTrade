//
//  ShowUserInfoViewController.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 5/11/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

//ShowUserInfoViewController

import UIKit
import MapKit

class ShowSenderInfoViewController: UIViewController {
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var mapView: MKMapView!

    var lat: String!
    var lon: String!
    
    var lat1 = 31.9518
    var lon1 = 35.9404
    
    var  getUserInfo: GetRecievedTradeDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if getUserInfo.trade.contactInformation.party1Name != nil {
            userName.text = getUserInfo.trade.contactInformation.party1Name
        }
        
        if getUserInfo.trade.contactInformation.party1PhoneNumber != nil {
            
            phoneNumber.text = getUserInfo.trade.contactInformation.party1PhoneNumber
        }
        
        if getUserInfo.trade.contactInformation.party1Address != nil {
            address.text = getUserInfo.trade.contactInformation.party1Address
        }
        
        if ( getUserInfo.trade.contactInformation.lat != nil || getUserInfo.trade.contactInformation.lon != nil ) {
            let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(Double(getUserInfo.trade.contactInformation.lat)!), longitude:  CLLocationDegrees(Double(getUserInfo.trade.contactInformation.lon)!))
            
            let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: 800, longitudinalMeters: 800)
            mapView.setRegion(coordinateRegion, animated: true)
            
            let annotations = MKPointAnnotation()
            annotations.title = "Drop off location"
            annotations.coordinate = location
            mapView.addAnnotation(annotations)
            
        } else {
            let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat1), longitude:  CLLocationDegrees(lon1))
            
            let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: 800, longitudinalMeters: 800)
            mapView.setRegion(coordinateRegion, animated: true)
            
            let annotations = MKPointAnnotation()
            annotations.title = "Drop off location"
            annotations.coordinate = location
            mapView.addAnnotation(annotations)
        }
    }
}
