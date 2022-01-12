//
//  ViewController.swift
//  MapKitApp
//
//  Created by Ufuk Canlı on 12.01.2022.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    private let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }
}


// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationStatus()
    }
}


// MARK: - Initialize and check for status
private extension MapViewController {
    
    func initialize() {
        manager.delegate = self
        checkLocationStatus()
    }
    
    func checkLocationStatus() {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        case .denied, .restricted:
            displayAlert()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        @unknown default:
            fatalError()
        }
    }
}


// MARK: - Display alert extension
private extension MapViewController {
    func displayAlert() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(
                title: "Ooops!",
                message: "This app needs access to the GPS coordinates for your location.",
                preferredStyle: .alert
            )
            alertController.modalPresentationStyle = .overFullScreen
            alertController.modalTransitionStyle = .crossDissolve
            
            let goToSettingsAction = UIAlertAction(title: "Go to Settings", style: .default) { _ in
                if UIApplication.shared.canOpenURL(URL(string: UIApplication.openSettingsURLString)!){
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                self.dismiss(animated: true)
            }
            
            alertController.addAction(goToSettingsAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
