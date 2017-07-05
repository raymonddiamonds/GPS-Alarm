//
//  ViewController.swift
//  Hackathon
//
//  Created by Linglong Wang on 7/5/17.
//  Copyright © 2017 Connar Wang. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSServices.provideAPIKey("AIzaSyDRya3DLy6VT-weK--kGZf27i9y3B5tl4Q")
        let camera = GMSCameraPosition.camera(withLatitude: 37.773760, longitude: -122.417764, zoom: 12)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        let currentLocation = CLLocationCoordinate2DMake(37.773760, -122.417764)
        let marker = GMSMarker(position: currentLocation)
        marker.title = "Make School"
        marker.map = mapView

    }


}
