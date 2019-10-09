//
//  Artwork.swift
//  recycle
//
//  Created by TORU ISHIHARA on 10/8/19.
//  Copyright © 2019 nariuchi. All rights reserved.
//

import MapKit

class Artwork: NSObject, MKAnnotation {
  let title: String?
  let locationName: String
  let discipline: String
  let coordinate: CLLocationCoordinate2D
  
  init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.locationName = locationName
    self.discipline = discipline
    self.coordinate = coordinate
    
    super.init()
  }
  
  var subtitle: String? {
    return locationName
  }
}
