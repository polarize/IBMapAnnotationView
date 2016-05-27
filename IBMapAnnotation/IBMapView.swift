//
//  IBMapView.swift
//  IBMapAnnotation
//
//  Created by Issam Bendaas on 26/05/16.
//  Copyright © 2016 Issam Bendaas. All rights reserved.
//

import UIKit
import MapKit

extension IBMapViewController: MKMapViewDelegate {

	func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
		if let annotation = annotation as? IBAnnotation {
			
			// Try to dequeue an existing pin view first.
			let identifier = "CustomPinAnnotationView"
			if let dequeudView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? CustomAnnotationView {
				dequeudView.annotation = annotation
				return dequeudView
			} else {
				let pinView = CustomAnnotationView(annotation: annotation, reuseIdentifier: identifier)
				pinView.mapView = mapView
				pinView.delegate = self
				pinView.animatesDrop = true
				pinView.canShowCallout = false
				return pinView
			}
		}
		return nil
	}

	
	func mapView(mapView: MKMapView, didAddAnnotationViews views: [MKAnnotationView]) {
		
		for annot in views {
			guard let ann = annot.annotation else { return }
			// Don't pin drop if annotation is user location
			if ((ann.isKindOfClass(MKUserLocation))) {
				continue
			}
			
			// Check if current annotation is inside visible map rect, else go to next one
			let point =  MKMapPointForCoordinate(ann.coordinate);
			if (!MKMapRectContainsPoint(mapView.visibleMapRect, point)) {
				continue;
			}
		}
	}
}

extension IBMapViewController: CustomAnnotationViewDelegate {
	
	func getNewMapCenter(newCenterCoords: CGPoint) {
		
	}
	
	func getNewMapCenterWithCoordinate(coordinate: CLLocationCoordinate2D) {
		mapView.setCenterCoordinate(coordinate, animated: true)
	}
	
}
