//
//  MapMark.swift
//  MapKitFunctions
//
//  Created by Silas S. Caxias on 23/10/19.
//  Copyright © 2019 Silas S. Caxias. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapMark {
    let id: Int
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    let image: UIImage?
    var point: CustomPoint

    init(id: Int, title: String, locationName: String, image: UIImage? = nil, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        self.image = image

        self.point = CustomPoint()
        self.point.coordinate = coordinate
        self.point.title = title
        self.point.subtitle = locationName
        
        if let image = image {
            self.point.image = image
        }
    }
}


class CustomPoint: MKPointAnnotation {
    var image: UIImage!
}
