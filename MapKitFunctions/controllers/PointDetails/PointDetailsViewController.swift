//
//  PointDetailsViewController.swift
//  MapKitFunctions
//
//  Created by Silas S. Caxias on 24/10/19.
//  Copyright © 2019 Silas S. Caxias. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class PointDetailsViewController : UIViewController {
    
    @IBOutlet weak var pointNameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var coordinateLabel: UILabel!
    
    var pointAnnotation: MKAnnotation?
    
    var iconSize: CGSize = CGSize(width: 30.0, height: 50.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        mapView.mapType = .standard
        defineAnnotation()
    }
    
    func defineAnnotation() {
        if let annotation = pointAnnotation, let title = annotation.title as? String, let subtitle = annotation.subtitle as? String {
            pointNameLabel.text = "\(title): \(subtitle)"
            coordinateLabel.text = "Coordenadas: \(annotation.coordinate.latitude),\(annotation.coordinate.longitude)"
            
            let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 100.0, longitudinalMeters: 100.0)
            mapView.setRegion(coordinateRegion, animated: true)
            
            let mark: MapMark = MapMark(id: 1, title: title, locationName: subtitle,coordinate: annotation.coordinate)
            mapView.addAnnotation(mark.point)
        }
    }
    
    @IBAction func backButtonDidTapped() {
        
        navigationController?.popViewController(animated: true)
        title = pointAnnotation!.title!!
    }
}
