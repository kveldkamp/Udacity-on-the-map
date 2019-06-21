//
//  MapViewVC.swift
//  onTheMap
//
//  Created by Kevin Veldkamp on 6/16/19.
//  Copyright © 2019 kevin veldkamp. All rights reserved.
//

import UIKit
import MapKit

class MapViewVC: UIViewController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkingManager.getStudentsLocations(completion: handleGetLocationsResponse(studentLocations:error:))
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    @IBAction func logout(_ sender: Any) {
    }
    
    @IBAction func refresh(_ sender: Any) {
    }
    
    @IBAction func addPin(_ sender: Any) {
    }
    
    
    
    func handleGetLocationsResponse(studentLocations: [StudentLocation], error: Error?){
        if studentLocations.count > 0{
            configurePinsOnMap(studentLocations: studentLocations)
        }
        else{
            print("failed to get locations")
        }
    
    }
    
    
    func configurePinsOnMap(studentLocations: [StudentLocation]){
        var annotations = [MKPointAnnotation]()
        
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
    
}
