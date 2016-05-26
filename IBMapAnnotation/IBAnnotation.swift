//
//  IBAnnotation.swift
//  IBMapAnnotation
//
//  Created by Issam Bendaas on 26/05/16.
//  Copyright © 2016 Issam Bendaas. All rights reserved.
//

import UIKit
import MapKit

class IBAnnotation: NSObject, MKAnnotation {
	let title: String?
	let locationName: String
	let coordinate: CLLocationCoordinate2D
	
	init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
		self.title = title
		self.locationName = locationName
		self.coordinate = coordinate
		
		super.init()
	}
	
	var subtitle: String? {
		return locationName
	}

}
