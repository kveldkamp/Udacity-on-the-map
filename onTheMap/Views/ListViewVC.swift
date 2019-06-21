//
//  ListViewVC.swift
//  onTheMap
//
//  Created by Kevin Veldkamp on 6/16/19.
//  Copyright © 2019 kevin veldkamp. All rights reserved.
//

import UIKit

class ListViewVC: UIViewController {
    
    
    let navBarFunctions = NavBarFunctions()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    @IBAction func logout(_ sender: Any) {
        navBarFunctions.logout()
    }
    
    
    @IBAction func refresh(_ sender: Any) {
    }
    
    
    @IBAction func addPin(_ sender: Any) {
        navBarFunctions.addPin()
    }
    
}
