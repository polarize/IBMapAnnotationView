//
//  CustomAnnotationView.swift
//  IBMapAnnotation
//
//  Created by Issam Bendaas on 26/05/16.
//  Copyright © 2016 Issam Bendaas. All rights reserved.
//

import UIKit
import MapKit

protocol CustomAnnotationViewDelegate: class {
	
	func getNewMapCenter(newCenterCoords: CGPoint)
	func getNewMapCenterWithCoordinate(newCenterCoord: CLLocationCoordinate2D)
}



class CustomAnnotationView: MKPinAnnotationView {
	
	weak var mapView: MKMapView!
	var  calloutView: UIView!
	var preventSelectionChange: Bool = false
	weak var delegate: CustomAnnotationViewDelegate!
	var mapAnnotationView: MapCalloutView!
	
	
	override func addSubview(view: UIView) {
		// Filter the view and allow only our custom subview to be added
		guard let subView = view as? MapCalloutView else { return }
		super.addSubview(subView)
	}
	
	func setAnnotationPosistionOnView(annotationCoords: CLLocationCoordinate2D) {
		
		guard let mView = mapView else { return }
		guard let anno = annotation else { return }
		// set the annotation position if it'S not visible
		let topLeftPoint = CGPointMake(CGRectGetMinX(mView.bounds), CGRectGetMinY(mView.bounds))
		
		// get pin CGPoint
		guard let pinPoint = mapView?.convertCoordinate(anno.coordinate, toPointToView: mView) else { return }
		
		//get mapCenter CGPoint
		guard let mapCenterPoint = mapView?.convertCoordinate(mView.centerCoordinate, toPointToView: mView) else { return }
		
		// get the annotation points
		let mapAnnotationWidth:CGFloat = 336
		let mapAnnotationHeight:CGFloat = 108
		let pinHeight:CGFloat = 40
		
		let annNWPoint = CGPointMake(pinPoint.x - (mapAnnotationWidth / 2), pinPoint.y - mapAnnotationWidth - pinHeight)
		let annNEPoint = CGPointMake(pinPoint.x + (mapAnnotationHeight / 2), annNWPoint.y)
		let annSWPoint = CGPointMake(annNWPoint.x, mapAnnotationHeight - (mapAnnotationHeight - pinPoint.y))
		
		var xCoord: CGFloat = 0
		var yCoord: CGFloat = 0
		
		let mapViewWidth = mView.frame.size.width
		
		if (annNWPoint.x < topLeftPoint.x) && (annNWPoint.y < topLeftPoint.y) && (annSWPoint.x < topLeftPoint.x) && (annNEPoint.y < topLeftPoint.y) {
			// check if NW, NE and SW annotation points aren't visible
			xCoord = (mapAnnotationWidth / 2) - pinPoint.x
			yCoord = mapAnnotationWidth - pinPoint.y + pinHeight
		}
		else if ((annNWPoint.x < topLeftPoint.x) && (annNEPoint.y > topLeftPoint.y)) {
		 // verify if NW and SW annotation points aren't visible
			xCoord = (mapAnnotationWidth / 2) - pinPoint.x;
			yCoord = 0;
		} else if ((annNWPoint.y < topLeftPoint.y) && (annSWPoint.x > topLeftPoint.x) && (annNEPoint.x < mapViewWidth)) {
			// verify if NW and NE annotation points aren't visible
			xCoord = 0;
			yCoord = mapAnnotationHeight - pinPoint.y + pinHeight;
		} else if ((annNWPoint.y < topLeftPoint.y) && (annNEPoint.x > mapViewWidth)) {
			// verify if NW, NE and SE annotation points aren't visible
			xCoord = -(mapAnnotationWidth - (mapViewWidth - annNWPoint.x));
			yCoord = mapAnnotationHeight - pinPoint.y + pinHeight;
		} else if ((annNWPoint.y > topLeftPoint.y) && (annNEPoint.x > mapViewWidth)) {
			// verify if NE and SE annotation points aren't visible
			xCoord = -(mapAnnotationWidth - (mapViewWidth - annNWPoint.x));
			yCoord = 0;
		}
		
		let centerPoint = CGPointMake(mapCenterPoint.x - xCoord, mapCenterPoint.y - yCoord)
		delegate?.getNewMapCenter(centerPoint)
	}
	
	override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
		let isXInsideAnnotation = (point.x > -10) && (point.x < (self.frame.size.width + 10));
		let isYInsideAnnotation = (point.y > -10) && (point.y < (self.frame.size.height + 10));
		var isInsideCallout = false
		
		// if it has a callout, check if the touch was made inside the callout
		if (self.selected) {
			
			guard let callout = subviews.first else { return false }
			let isXInsideCallout = (point.x >= callout.frame.origin.x) && (point.x <= (callout.frame.size.width + callout.frame.origin.x));
			let isYInsideCallout = (point.y >= callout.frame.origin.y) && (point.y <= (callout.frame.size.height + callout.frame.origin.y));
			
			isInsideCallout = isXInsideCallout && isYInsideCallout;
		}
		return (isXInsideAnnotation && isYInsideAnnotation) || isInsideCallout;
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		
		if preventSelectionChange { return }
		
		super.setSelected(selected, animated: animated)
		
		if selected {
			
			guard let cView = NSBundle.mainBundle().loadNibNamed("MapDetailsCalloutView", owner: self, options: nil).first as? MapCalloutView else { return }
			guard let ann = annotation else { return }
			
			mapAnnotationView = cView
			
			mapAnnotationView.mapview = mapView
			mapAnnotationView.setupViewWithModel()
			
			//Set the pin color to green - selected
			pinTintColor = UIColor.greenColor()
			calloutView = mapAnnotationView
			
			// Set the callout view frame to appear above the pin
			let annotationVerticalOffset:CGFloat = 2;
			let annotationHorizontalOffset:CGFloat = 8;
			
			let x = (-(mapAnnotationView.frame.size.width / 2) + annotationHorizontalOffset)
			
			let y = -mapAnnotationView.frame.size.height - annotationVerticalOffset
			
			calloutView.frame = CGRectMake(x, y, self.calloutView.frame.size.width, self.calloutView.frame.size.height)
			
			// Pin will be new mapcenter, so annotation view always will be centered
			let annotationCoordonate = ann.coordinate
			
			delegate?.getNewMapCenterWithCoordinate(annotationCoordonate)
			
			addSubview(calloutView)
			
		}else {
			// Set the pin color to red - default - not selected
			pinTintColor = UIColor.redColor()
			
			 // Remove the custom view
			calloutView.removeFromSuperview()
			
			// Deallocate the annotation so it is created again the next time
			mapAnnotationView = nil
		}
	}
	
}


