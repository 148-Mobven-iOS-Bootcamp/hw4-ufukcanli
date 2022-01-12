//
//  ViewController.swift
//  MapKitApp
//
//  Created by Ufuk Canlı on 12.01.2022.
//

import UIKit
import MapKit

final class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    private let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }
}

private extension ViewController {
    
    func initialize() {
        manager.delegate = self
        checkLocationStatus()
    }
    
    func checkLocationStatus() {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        case .denied, .restricted:
            // show popup
            break
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        @unknown default:
            fatalError()
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationStatus()
    }
}
