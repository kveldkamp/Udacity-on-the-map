//
//  InputStudentLocationVC.swift
//  onTheMap
//
//  Created by Kevin Veldkamp on 6/21/19.
//  Copyright © 2019 kevin veldkamp. All rights reserved.
//

import UIKit
import CoreLocation

class InputStudentLocationVC: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var locationQuery: UITextField!
    @IBOutlet weak var mediaURLInput: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchButton: UIButton!
    
    
    var location = ""
    var mediaURL = ""
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        mediaURLInput.delegate = self
        locationQuery.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableUI(true)
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.unsubscribeFromKeyboardNotifications()
        super.viewWillDisappear(animated)
    }
    
    @IBAction func searchLocation(_ sender: Any) {
        
        if locationQuery.text!.isEmpty{
            displayAlert(title: "Location is Empty", message: "You must enter your location")
        }else if mediaURLInput.text!.isEmpty{
            displayAlert(title: "Media URL is Empty", message: "You must enter a Website")
        }else{
            location = locationQuery.text!
            UserInfo.mapString = locationQuery.text!
            UserInfo.mediaURL = mediaURLInput.text!
            geocodeLocation(location: location)
        }
    }
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func geocodeLocation(location: String){
        enableUI(false)
        CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
            guard error == nil else{
                self.displayAlert(title: "Unable to find Location", message: "Unable to find this location, please try again")
                self.enableUI(true)
                return
            }
            
            if let placemarks = placemarks, placemarks.count > 0 {
                let placemark = placemarks[0]
                if let location = placemark.location {
                    let coordinate = location.coordinate
                    
                    UserInfo.latitude = coordinate.latitude
                    UserInfo.longitude = coordinate.longitude
                    
                    if let locality = placemark.locality, let administrativeArea = placemark.administrativeArea{
                         UserInfo.mapString = ("\(locality),\(administrativeArea)")
                    }
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "showSubmitStudentLocationVC", sender: self)
                    }
                } else {
                    self.displayAlert(title: "User Data", message: "No Matching Location Found")
                }
            }
            
        }
        
    }
    
    
    func enableUI(_ enabled: Bool){
        if enabled{
            activityIndicator.stopAnimating()
            locationQuery.text = ""
            mediaURLInput.text = ""
        }
        else {
            activityIndicator.startAnimating()
        }
        searchButton.isEnabled = enabled
        searchButton.isHidden = !enabled
    }
    
    
    
    
    
    
    //UITextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
