//
//  ViewController.swift
//  gmap-demo
//
//  Created by Georgy Shabunin on 30/04/16.
//  Copyright © 2016 Georgy Shabunin. All rights reserved.
//

import UIKit
import GoogleMaps

class VacationDestination: NSObject{

    let name: String
    let location: CLLocationCoordinate2D
    let zoom: Float
    
    init(name: String, location: CLLocationCoordinate2D, zoom: Float) {
        self.name = name
        self.location = location
        self.zoom = zoom
    }
}

class ViewController: UIViewController {

    var mapView: GMSMapView?
    
    let destinations = [
        VacationDestination(name: "SFO Airport", location: CLLocationCoordinate2D(latitude: 37.621338, longitude: -122.378945), zoom: 15),
        VacationDestination(name: "Embarcadero Station", location: CLLocationCoordinate2D(latitude: 37.793126, longitude: -122.397080), zoom: 15),
        VacationDestination(name: "Ferry Building", location: CLLocationCoordinate2D(latitude: 37.795793, longitude: -122.393418), zoom: 18)]

    var currentDestinationIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GMSServices.provideAPIKey("AIzaSyBNUnjssHDGxAn89_r8jRRT46iDkJUgpso")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "next")
        
        setInitialMapCamera()
    
    }
    
    func next(){

        if currentDestinationIndex < (destinations.count - 1){
            currentDestinationIndex++
        } else {
            currentDestinationIndex = 0
        }
        
        setNextMapCamera()
        
        
    }
    
    private func setInitialMapCamera(){
        currentDestinationIndex = 0
        let currentDestination = destinations[currentDestinationIndex]
        let camera = GMSCameraPosition.cameraWithTarget(currentDestination.location, zoom: currentDestination.zoom)
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        view = mapView
        
        setMarker(currentDestination)

    }
    
    private func setNextMapCamera() {
        let currentDestination = destinations[currentDestinationIndex]
        CATransaction.begin()
        CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
        mapView?.animateToCameraPosition(GMSCameraPosition.cameraWithTarget(currentDestination.location, zoom: currentDestination.zoom))
        CATransaction.commit()
        
        setMarker(currentDestination)
    }
    
    private func setMarker(destination: VacationDestination){
        let marker = GMSMarker(position: destination.location)
        marker.title = destination.name
        marker.map = mapView
    }


}

