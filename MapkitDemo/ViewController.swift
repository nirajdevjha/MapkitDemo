//
//  ViewController.swift
//  MapkitDemo
//
//  Created by Niraj Jha on 06/05/19.
//  Copyright © 2019 Niraj Jha. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editMapView))
    
        let delhi = Capital(title: "Delhi", coordinate: CLLocationCoordinate2D(latitude: 28.7041, longitude: 77.1025), info: "Famous for its food and monuments")
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotations([delhi, london, oslo, paris, rome, washington])

    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.pinTintColor = UIColor.orange
            
            let button = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = button
            
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let placeInfo = capital.info
        
        let alertController = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    
    @objc func editMapView() {
        let alertController = UIAlertController(title: nil, message: "Choose map view", preferredStyle: .actionSheet)
        let standardAction = UIAlertAction(title: "standard", style: .default) { _ in
            self.mapView.mapType = .standard
        }
        let hybridAction = UIAlertAction(title: "hybrid", style: .default) { _ in
            self.mapView.mapType = .hybrid
        }
        let hybridFlyoverAction = UIAlertAction(title: "hybrid flyover", style: .default) { _ in
             self.mapView.mapType = .hybridFlyover
        }
        let satelliteAction = UIAlertAction(title: "satellite", style: .default) { _ in
            self.mapView.mapType = .satellite
        }
        let satelliteFlyoverAction = UIAlertAction(title: "satellite flyover", style: .default) { _ in
            self.mapView.mapType = .satelliteFlyover
        }
        let mutedStndardAction = UIAlertAction(title: "muted standard", style: .default) { _ in
            self.mapView.mapType = .mutedStandard
        }
        
        alertController.addAction(standardAction)
        alertController.addAction(hybridAction)
        alertController.addAction(hybridFlyoverAction)
        alertController.addAction(satelliteAction)
        alertController.addAction(satelliteFlyoverAction)
        alertController.addAction(mutedStndardAction)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = alertController.view
            popoverController.sourceRect = alertController.view.bounds
        }
       
        present(alertController, animated: true)
    }


}

