//
//  InputStudentLocationVC.swift
//  onTheMap
//
//  Created by Kevin Veldkamp on 6/21/19.
//  Copyright © 2019 kevin veldkamp. All rights reserved.
//

import UIKit

class InputStudentLocationVC: UIViewController{
    
    
    @IBOutlet weak var locationQuery: UITextField!
    
    @IBOutlet weak var mediaURLInput: UITextField!
    
    
    @IBAction func searchLocation(_ sender: Any) {
        performSegue(withIdentifier: "showSubmitStudentLocationVC", sender: self)
    }
    
}
