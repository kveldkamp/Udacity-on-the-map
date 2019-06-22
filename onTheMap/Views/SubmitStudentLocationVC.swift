//
//  SubmitStudentLocationVC.swift
//  onTheMap
//
//  Created by Kevin Veldkamp on 6/21/19.
//  Copyright © 2019 kevin veldkamp. All rights reserved.
//

import UIKit
import MapKit

class SubmitStudentLocationVC: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        configurePinOnMap()
    }
    
    
    
    func configurePinOnMap(){
        let lat = UserInfo.latitude
        let long = UserInfo.longitude
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate

        
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        self.mapView.addAnnotation(annotation)
    }
    
    
    
    
    @IBAction func PostStudentInfoButton(_ sender: Any) {
        NetworkingManager.getUserData(completion: handleGetUserInfo(success:error:))
        //self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MKMapViewDelegate methods
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        //TODO: make pin match
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .blue
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func handleGetUserInfo(success: Bool, error: Error?){
        if success{
            
        }
        else{
            displayAlert(title: "Bad User Data", message: error?.localizedDescription)
        }
    }
    
}
