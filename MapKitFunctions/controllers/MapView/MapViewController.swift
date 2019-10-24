//
//  ViewController.swift
//  MapKitFunctions
//
//  Created by Silas S. Caxias on 22/10/19.
//  Copyright © 2019 Silas S. Caxias. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var distanceView: UILabel!
    
    @IBOutlet weak var buttonStart: UIButton!

    var arrayLocations : [MapMark] = []

    var initialMark: MapMark!

    var userPositionMark: MapMark? = nil

    var selectedCoordinate: CLLocationCoordinate2D? = nil
    
    var initialLocation: CLLocation = CLLocation(latitude: -22.402927, longitude: -47.565726)

    var motoristSize: CGSize = CGSize(width: 35.0, height: 40.0)

    var iconSize: CGSize = CGSize(width: 30.0, height: 50.0)
    
    var finishSize: CGSize = CGSize(width: 40.0, height: 60.0)
    
    var viewDistanceMap: Double = 500.0

    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        mapView.delegate = self
        mapView.userTrackingMode = .follow
        
    
        initialMark = MapMark(id: 1, title: "Motorista Posição", locationName: "", image: ImageUtils.imageWithSize(image: UIImage(named: "icon-motorista")!, scaledToSize: motoristSize), coordinate: locationManager.location?.coordinate ?? initialLocation.coordinate)

        userPositionMark = MapMark(id: 1, title: "Motorista Posição", locationName: "", image: ImageUtils.imageWithSize(image: UIImage(named: "icon-motorista")!, scaledToSize: motoristSize), coordinate: initialLocation.coordinate)
    
        arrayLocations = [
            MapMark(id: 1, title: "PONTO INICIAL", locationName: "PONTO INICIAL", image: ImageUtils.imageWithSize(image: UIImage(named: "bus-icon")!, scaledToSize: iconSize), coordinate: CLLocationCoordinate2D(latitude: -22.402911, longitude: -47.565512)),
            MapMark(id: 2, title: "PONTO A", locationName: "MINAS TINTAS", image: ImageUtils.imageWithSize(image: UIImage(named: "bus-icon")!, scaledToSize: iconSize), coordinate: CLLocationCoordinate2D(latitude: -22.401431, longitude: -47.564881)),
            MapMark(id: 3, title: "PONTO B", locationName: "SICRED RIO CLARO", image: ImageUtils.imageWithSize(image: UIImage(named: "bus-icon")!, scaledToSize: iconSize), coordinate: CLLocationCoordinate2D(latitude: -22.399617, longitude: -47.563602)),
            MapMark(id: 4, title: "PONTO C", locationName: "TORRE EIFFEL", image: ImageUtils.imageWithSize(image: UIImage(named: "finish-icon")!, scaledToSize: iconSize), coordinate: CLLocationCoordinate2D(latitude: -22.395408, longitude: -47.563064))
        ]
        
        mapView.addAnnotations(arrayLocations.map({ return $0.point} ))
        
        setupInitialPosition()
    }
    
    func setupInitialPosition() {
        let center = CLLocationCoordinate2D(latitude: initialMark.coordinate.latitude, longitude: initialMark.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func startRouteDidTapped() {
        for (index, location) in arrayLocations.enumerated() {
            if arrayLocations.first!.id == location.id {
                MapServices.createRoutes(pickupCoordinate: initialMark.coordinate, destinationCoordinate: location.coordinate, mapView: mapView)
            } else {
                MapServices.createRoutes(pickupCoordinate: arrayLocations[index - 1].coordinate, destinationCoordinate: location.coordinate, mapView: mapView)
            }
        }
        
        updateDistance(distance: CLLocation(latitude: initialMark.coordinate.latitude, longitude: initialMark.coordinate.longitude).distance(from: CLLocation(latitude: arrayLocations.last!.coordinate.latitude, longitude: arrayLocations.last!.coordinate.longitude)))
        buttonStart.isHidden = true
    }
    
    @IBAction func enlargeViewDidTapped() {
        if (viewDistanceMap <= 2000.0) {
            viewDistanceMap += 100.0
        }
    }
    
    @IBAction func DecreaseViewDidTapped() {
        if (viewDistanceMap > 500.5) {
            viewDistanceMap -= 100.0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsPoint",
            let pointDetailsViewController = segue.destination as? PointDetailsViewController,
                let nameDetails = sender as? String {
            pointDetailsViewController.pointName = nameDetails
        }
    }
    
    func updateDistance(distance: Double) {
        let kmDistance: Int = Int(distance / 1000)
        
        if kmDistance > 1 {
            distanceView.text = "\(kmDistance) km faltando até o destino!"
        } else {
            distanceView.text = "\(Int(distance)) metros faltando até o destino!"
        }
        
        if distance > 0 {
            distanceView.isHidden = false
        } else {
            distanceView.isHidden = true
        }
    }
}
