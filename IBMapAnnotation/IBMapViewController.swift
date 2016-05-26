//
//  IBMapViewController.swift
//  IBMapAnnotation
//
//  Created by Issam Bendaas on 26/05/16.
//  Copyright © 2016 Issam Bendaas. All rights reserved.
//

import UIKit
import MapKit

class IBMapViewController: UIViewController {

	@IBOutlet weak var mapView: MKMapView!
	
	
	let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
	
	let regionRadius: CLLocationDistance = 1000
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.mapView.delegate = self
		
        centerMapOnLocation(initialLocation)
		showAnnotation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func centerMapOnLocation(location: CLLocation) {
		let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
		mapView.setRegion(coordinateRegion, animated: true)
	}

	func showAnnotation() {
		let annotation = IBAnnotation(title: "King David Kalakaua", locationName: "Waikik Gateway Park", coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
		mapView.addAnnotation(annotation)
	}

}
