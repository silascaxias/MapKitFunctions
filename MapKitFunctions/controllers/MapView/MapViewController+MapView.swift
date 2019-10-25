//
//  ViewController+MapView.swift
//  MapKitFunctions
//
//  Created by Silas S. Caxias on 23/10/19.
//  Copyright © 2019 Silas S. Caxias. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

extension MapViewController : MKMapViewDelegate {
    
    // MARK: Custom annotation setup to show
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if !(annotation is CustomPoint) {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "userLocation")
            annotationView.image = ImageUtils.imageWithSize(image: UIImage(named: "icon-motorista")!, scaledToSize: CGSize(width: 35.0, height: 40.0))
            return annotationView
        }
            
        let identifier = "Annotation"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            let calloutButton = UIButton(type: .detailDisclosure)
            calloutButton.tintColor = #colorLiteral(red: 0.8926053643, green: 0.5932921171, blue: 0.3987112045, alpha: 1)
            annotationView!.rightCalloutAccessoryView = calloutButton
            annotationView!.sizeToFit()
        } else {
            annotationView!.annotation = annotation
        }

        if let customAnnotation = annotation as? CustomPoint, let image = customAnnotation.image {
            annotationView!.image = image
        }
        return annotationView
    }

     // MARK: Button info did tapped
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation else {
            return
        }
        
        if control == view.rightCalloutAccessoryView {
             self.performSegue(withIdentifier: "toDetailsPoint", sender: annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(red: 17.0/255.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1)
        renderer.lineWidth = 5.0
        return renderer
    }

}
