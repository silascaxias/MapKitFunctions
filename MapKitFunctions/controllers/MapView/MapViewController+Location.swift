//
//  ViewController+LocationManager.swift
//  MapKitFunctions
//
//  Created by Silas S. Caxias on 23/10/19.
//  Copyright © 2019 Silas S. Caxias. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

extension MapViewController: CLLocationManagerDelegate {
    // MARK: Starting location tracker
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.locationManager.startUpdatingLocation()
    }
    
     // MARK: Action on updating locations

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let userLocation = locations.first else {
            return print("Failed to get user's location")
        }

        userPositionMark = MapMark(id: 1, title: "Motorista Posição", locationName: "", image: ImageUtils.imageWithSize(image: UIImage(named: "icon-motorista")!, scaledToSize: motoristSize), coordinate: userLocation.coordinate)
        
        let coordinateRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: viewDistanceMap, longitudinalMeters: viewDistanceMap)
        mapView.setRegion(coordinateRegion, animated: true)
        
        if userLocation.coordinate.longitude == initalMark.coordinate.longitude && userLocation.coordinate.latitude == initalMark.coordinate.latitude {
            return
        }
        
        if let selectedCoordinate = selectedCoordinate {
            MapServices.getDistanceFromCoordinates(startCoordinate: userLocation.coordinate, destinationCoordinate: CLLocationCoordinate2D(latitude: selectedCoordinate.latitude, longitude: selectedCoordinate.longitude), onCompletion: { distance in
                self.updateDistance(distance: distance)
            })
            
        }
    }
}
