//
//  ViewController.swift
//  Hackathon
//
//  Created by Linglong Wang on 7/5/17.
//  Copyright © 2017 Connar Wang. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    var currentLocationCoords: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSServices.provideAPIKey("AIzaSyBh7vyTEC5MRbXipkNm_lc1oIuA1jJ8_ngQ")
        
        checkCoreLocationPermission()
        
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.stopMonitoringSignificantLocationChanges()
        


    }
//    
//    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse {
//            
//            locationManager.startUpdatingLocation()
//            
//        }
//    }
    
    func checkCoreLocationPermission() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            currentLocationCoords = locationManager.location
            
            setupMap(latitude: currentLocationCoords.coordinate.latitude, longitude: currentLocationCoords.coordinate.longitude)

        } else {
            locationManager.requestWhenInUseAuthorization()
            checkCoreLocationPermission()
        }
    }
    
    func setupMap(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 13)
        let mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 85.0, width: 375, height: 400.0) , camera: camera)
        view.addSubview(mapView)
        
        //custom border/colour to the mapView edges
        mapView.layer.borderWidth = 3
        mapView.layer.borderColor = UIColor(red:255/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
//        let currentLocation = CLLocationCoordinate2DMake(latitude, longitude)
//        let marker = GMSMarker(position: currentLocation)
//        marker.title = "Make School"
//        marker.snippet = "This is school"
//        marker.appearAnimation = .pop
//        marker.map = mapView
    }

    
}

