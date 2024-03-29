//
//  MapViewVC.swift
//  onTheMap
//
//  Created by Kevin Veldkamp on 6/16/19.
//  Copyright © 2019 kevin veldkamp. All rights reserved.
//

import UIKit
import MapKit

class MapViewVC: UIViewController, MKMapViewDelegate {
    
    
    let navBarFunctions = NavBarFunctions()
    var annotations = [MKPointAnnotation]()
    
    
    override func viewDidLoad() {
         NetworkingManager.getStudentsLocations(completion: handleGetLocationsResponse(studentLocations:error:))
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    @IBAction func logout(_ sender: Any) {
        NetworkingManager.logout(completion: handleLogoutResponse(success:error:))
    }
    
    @IBAction func refresh(_ sender: Any) {
        mapView.removeAnnotations(annotations)
        NetworkingManager.getStudentsLocations(completion: handleGetLocationsResponse(studentLocations:error:))
    }
    
    @IBAction func addPin(_ sender: Any) {
        performSegue(withIdentifier: "showInputStudentInfoVC", sender: self)
    }
    
    
    
    func handleGetLocationsResponse(studentLocations: [StudentLocation], error: Error?){
        if studentLocations.count > 0{
            configurePinsOnMap(studentLocations: studentLocations)
            StudentLocations.data = studentLocations
        }
        else{
            displayAlert(title: "Failed to Get Locations", message: "Please try reloading")
        }
    
    }
    
    func handleLogoutResponse(success: Bool, error: Error?){
        if success {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        else if error != nil{
             displayAlert(title: "Logout Error", message: error?.localizedDescription)
        }
        else{
             displayAlert(title: "Logout Error", message: "Something went wrong logging out")
        }
    }
    
    
    func configurePinsOnMap(studentLocations: [StudentLocation]){
        
        
        for student in studentLocations {

            let lat = student.latitude
            let long = student.longitude
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = student.firstName
            let last =  student.lastName
            let mediaURL = student.mediaURL

            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            annotations.append(annotation)
        }
        
        self.mapView.addAnnotations(annotations)

    }
    
    
    //MARK MKMapViewDelegate functions
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
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
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.openURL(URL(string: toOpen)!)
            }
        }
    }
    
}
