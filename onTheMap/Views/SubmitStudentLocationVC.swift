//
//  SubmitStudentLocationVC.swift
//  onTheMap
//
//  Created by Kevin Veldkamp on 6/21/19.
//  Copyright © 2019 kevin veldkamp. All rights reserved.
//

import UIKit
import MapKit

class SubmitStudentLocationVC: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func PostStudentInfoButton(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
}
