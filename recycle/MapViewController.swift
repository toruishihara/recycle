//
//  MapViewController.swift
//  tab10
//
//  Created by TORU ISHIHARA on 10/6/19.
//  Copyright © 2019 nariuchi. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    // set initial location in Honolulu
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerMapOnLocation(location: initialLocation)
        
        // show artwork on map
        let artwork = Artwork(title: "ABC mart recycle",
          locationName: "Waikiki Gateway Park",
          discipline: "Sculpture",
          coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
        mapView.addAnnotation(artwork)
        
        // show artwork on map
        let artwork2 = Artwork(title: "Seven recycle",
          locationName: "Waikiki Gateway Park",
          discipline: "Sculpture",
          coordinate: CLLocationCoordinate2D(latitude: 21.285921, longitude: -157.831661))
        mapView.addAnnotation(artwork2)
        
        // show artwork on map
        let artwork3 = Artwork(title: "Long drug recycle",
          locationName: "Waikiki Gateway Park",
          discipline: "Sculpture",
          coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.829661))
        mapView.addAnnotation(artwork3)


    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
      mapView.setRegion(coordinateRegion, animated: true)
    }
    
}
