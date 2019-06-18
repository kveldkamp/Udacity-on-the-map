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
            print(studentLocations)
        }
        else{
            print("failed to get locations")
        }
    
    }
    
}
