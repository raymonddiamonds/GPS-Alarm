//
//  ViewController.swift
//  Hackathon
//
//  Created by Raymond Diamonds on 7/5/17.
//  Copyright © 2017 Connar Wang. All rights reserved.
//


import UIKit
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController, CLLocationManagerDelegate , GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate {
    
    // OUTLETS
    @IBOutlet weak var googleMapsView: GMSMapView!
    
    @IBAction func setAlarmTapped(_ sender: Any) {
        
    }
    
    @IBAction func openSearchAddress(_ sender: UIBarButtonItem) {
        
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
        
    }

    
    // VARIABLES
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        initGoogleMaps()
        
        //custom border/colour to the mapView edges
        googleMapsView.layer.borderWidth = 3
        googleMapsView.layer.borderColor = UIColor(red:192/255.0, green:192/255.0, blue:192/255.0, alpha: 1.0).cgColor
        googleMapsView.layer.cornerRadius = 3.5
        

        
    }
    
    func initGoogleMaps() {
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        self.googleMapsView.camera = camera
        
        self.googleMapsView.delegate = self
        self.googleMapsView.isMyLocationEnabled = true
        self.googleMapsView.settings.myLocationButton = true
        
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        
    }
    
    // MARK: CLLocation Manager Delegate
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while get location \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        self.googleMapsView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
        
    }
    
    // MARK: GMSMapview Delegate
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.googleMapsView.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        
        self.googleMapsView.isMyLocationEnabled = true
        if (gesture) {
            mapView.selectedMarker = nil
        }
        
    }
    
    // MARK: GOOGLE AUTO COMPLETE DELEGATE
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15.0)
        self.googleMapsView.camera = camera
        
        //Setting the markers
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        marker.title = place.formattedAddress
        marker.map = googleMapsView
        
        self.dismiss(animated: true, completion: nil) // dismiss after select place
        

        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        
        print("ERROR AUTO COMPLETE \(error)")
        
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil) // when cancel search
    }
    

    
    
    
    
    
}








//import UIKit
//import GoogleMaps
//import CoreLocation
//import GooglePlaces
//
//class ViewController: UIViewController, CLLocationManagerDelegate {
//    
//    var resultsViewController: GMSAutocompleteResultsViewController?
//    var searchController: UISearchController?
//    var resultView: UITextView?
//    let locationManager = CLLocationManager()
//    var currentLocationCoords: CLLocation!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        GMSServices.provideAPIKey("AIzaSyBh7vyTEC5MRbXipkNm_lc1oIuA1jJ8_ngQ")
//        
//        checkCoreLocationPermission()
//        
//        locationManager.delegate = self as? CLLocationManagerDelegate
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//        locationManager.stopMonitoringSignificantLocationChanges()
//        resultsViewController = GMSAutocompleteResultsViewController()
//        //resultsViewController?.delegate = self
////        
////        searchController = UISearchController(searchResultsController: resultsViewController)
////        searchController?.searchResultsUpdater = resultsViewController
////        
////        // Put the search bar in the navigation bar.
////        searchController?.searchBar.sizeToFit()
////        navigationItem.titleView = searchController?.searchBar
////        
////        // When UISearchController presents the results view, present it in
////        // this view controller, not one further up the chain.
////        definesPresentationContext = true
////        
////        // Prevent the navigation bar from being hidden when searching.
////        searchController?.hidesNavigationBarDuringPresentation = false
////        
//        
//    }
//
//    
//    func checkCoreLocationPermission() {
//        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
//            locationManager.startUpdatingLocation()
//            currentLocationCoords = locationManager.location
//            
//            setupMap(latitude: currentLocationCoords.coordinate.latitude, longitude: currentLocationCoords.coordinate.longitude)
//            
//        } else {
//            locationManager.requestWhenInUseAuthorization()
//            checkCoreLocationPermission()
//        }
//    }
//    
//    func setupMap(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
//        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 13)
//        let mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 85.0, width: 375, height: 400.0) , camera: camera)
//        view.addSubview(mapView)
//        
//        //custom border/colour to the mapView edges
//        mapView.layer.borderWidth = 3
//        mapView.layer.borderColor = UIColor(red:255/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
//        
//        mapView.isMyLocationEnabled = true
//        mapView.settings.myLocationButton = true
//        
//        //        let currentLocation = CLLocationCoordinate2DMake(latitude, longitude)
//        //        let marker = GMSMarker(position: currentLocation)
//        //        marker.title = "Make School"
//        //        marker.snippet = "This is school"
//        //        marker.appearAnimation = .pop
//        //        marker.map = mapView
//    }
//    
//    
//}
//extension ViewController: GMSAutocompleteViewControllerDelegate {
//    
//    // Handle the user's selection.
//    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//        print("Place name: \(place.name)")
//        print("Place address: \(place.formattedAddress)")
//        print("Place attributions: \(place.attributions)")
//        dismiss(animated: true, completion: nil)
//    }
//    
//    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
//        // TODO: handle the error.
//        print("Error: ", error.localizedDescription)
//    }
//    
//    // User canceled the operation.
//    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
//        dismiss(animated: true, completion: nil)
//    }
//    
//    // Turn the network activity indicator on and off again.
//    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//    }
//    
//    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//        UIApplication.shared.isNetworkActivityIndicatorVisible = false
//    }
//    
//}

//
//
//
//
//import UIKit
//import GoogleMaps
//import CoreLocation
//
//class ViewController: UIViewController, CLLocationManagerDelegate {
//
//    let locationManager = CLLocationManager()
//    var currentLocationCoords: CLLocation!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        GMSServices.provideAPIKey("AIzaSyBh7vyTEC5MRbXipkNm_lc1oIuA1jJ8_ngQ")
//        
//        checkCoreLocationPermission()
//        
//        locationManager.delegate = self as? CLLocationManagerDelegate
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//        locationManager.stopMonitoringSignificantLocationChanges()
//        
//
//
//    }
////    
////    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
////        if status == .authorizedWhenInUse {
////            
////            locationManager.startUpdatingLocation()
////            
////        }
////    }
//    
//    func checkCoreLocationPermission() {
//        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
//            locationManager.startUpdatingLocation()
//            currentLocationCoords = locationManager.location
//            
//            setupMap(latitude: currentLocationCoords.coordinate.latitude, longitude: currentLocationCoords.coordinate.longitude)
//
//        } else {
//            locationManager.requestWhenInUseAuthorization()
//            checkCoreLocationPermission()
//        }
//    }
//    
//    func setupMap(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
//        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 13)
//        let mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 85.0, width: 375, height: 400.0) , camera: camera)
//        view.addSubview(mapView)
//        
//        //custom border/colour to the mapView edges
//        mapView.layer.borderWidth = 3
//        mapView.layer.borderColor = UIColor(red:255/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
//        
//        mapView.isMyLocationEnabled = true
//        mapView.settings.myLocationButton = true
//        
////        let currentLocation = CLLocationCoordinate2DMake(latitude, longitude)
////        let marker = GMSMarker(position: currentLocation)
////        marker.title = "Make School"
////        marker.snippet = "This is school"
////        marker.appearAnimation = .pop
////        marker.map = mapView
//    }
//
//    
//}
//
