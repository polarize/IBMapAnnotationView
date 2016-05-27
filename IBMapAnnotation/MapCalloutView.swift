//
//  MapCalloutView.swift
//  IBMapAnnotation
//
//  Created by Issam Bendaas on 26/05/16.
//  Copyright © 2016 Issam Bendaas. All rights reserved.
//

import UIKit
import MapKit

class MapCalloutView: UIView {

	@IBOutlet weak var fromLabel: UILabel!
	@IBOutlet weak var  containerView:UIView!
	@IBOutlet weak var  hotelImageElementsContainer:UIView!
	@IBOutlet weak var  hotelImagePlaceholder:UIImageView!
	@IBOutlet weak var  hotelImageActivityIndicator:UIActivityIndicatorView!
	@IBOutlet weak var  noPhotoLabel:UILabel!
	
	@IBOutlet weak var   hotelImage: UIImageView!
	@IBOutlet weak var   backgroundImage: UIImageView!
	@IBOutlet weak var   hotelName: UILabel!
	@IBOutlet weak var   recommendationLabel: UILabel!
	@IBOutlet weak var   furtherRecommendationLabel: UILabel!
	@IBOutlet weak var   recommendationPlaceholder: UILabel!
	@IBOutlet weak var   priceLabel: UILabel!
	@IBOutlet weak var   goToHotelButton: UIButton!
	@IBOutlet weak var   vacationDaysLabel: UILabel!
	@IBOutlet weak var   vacationDaysValueLabel: UILabel!
	@IBOutlet weak var   starRatingView: UIView!
	@IBOutlet weak var   cityName: UILabel!

	
	weak var mapview: MKMapView?
	weak var parentAnnotationView: CustomAnnotationView?
	
	func setupViewWithModel(){
	
	}
}
