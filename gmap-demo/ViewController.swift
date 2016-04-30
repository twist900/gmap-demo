//
//  ViewController.swift
//  gmap-demo
//
//  Created by Georgy Shabunin on 30/04/16.
//  Copyright © 2016 Georgy Shabunin. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    var mapView: GMSMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GMSServices.provideAPIKey("AIzaSyBNUnjssHDGxAn89_r8jRRT46iDkJUgpso")
 
        let camera = GMSCameraPosition.cameraWithLatitude(37.621338, longitude: -122.378945, zoom: 12)
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        view = mapView
        
        let currentLocation = CLLocationCoordinate2D(latitude: 37.621338, longitude: -122.378945)
        let marker = GMSMarker(position: currentLocation)
        marker.title = "SFO Airport"
        marker.map = mapView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "next")
    
    }
    
    func next(){
        let nextLocation = CLLocationCoordinate2D(latitude: 37.793126, longitude: -122.397080)
        mapView?.camera = GMSCameraPosition.cameraWithLatitude( nextLocation.latitude, longitude: nextLocation.longitude, zoom: 15)
        
        let marker = GMSMarker(position: nextLocation)
        marker.title = "Embarcadero Station"
        marker.map = mapView
    }


}

