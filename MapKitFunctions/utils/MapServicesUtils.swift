//
//  MapViewServices.swift
//  MapKitFunctions
//
//  Created by Silas S. Caxias on 23/10/19.
//  Copyright © 2019 Silas S. Caxias. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class MapServices {
    static func createRoutes(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D, mapView: MKMapView) {
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: pickupCoordinate.latitude, longitude: pickupCoordinate.longitude), addressDictionary: nil))
        directionRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: destinationCoordinate.latitude, longitude: destinationCoordinate.longitude), addressDictionary: nil))
        directionRequest.requestsAlternateRoutes = true
        directionRequest.transportType = .automobile
        let directions = MKDirections(request: directionRequest)

        directions.calculate {
            (response, error) -> Void in

            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }

                return
            }

            let route = response.routes[0]

            mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)

            mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
    }
    static func getDistanceFromCoordinates(startCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D, onCompletion: @escaping (Double) -> Void) {
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: startCoordinate, addressDictionary: nil))
        directionRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
        directionRequest.requestsAlternateRoutes = true
        directionRequest.transportType = .automobile

        let directions = MKDirections(request: directionRequest)

        directions.calculate {
            (response, error) -> Void in

            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }
            let route = response.routes[0]
            onCompletion(route.distance)
        }
    }
}
