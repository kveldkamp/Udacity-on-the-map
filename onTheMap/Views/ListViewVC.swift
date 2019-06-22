//
//  ListViewVC.swift
//  onTheMap
//
//  Created by Kevin Veldkamp on 6/16/19.
//  Copyright © 2019 kevin veldkamp. All rights reserved.
//

import UIKit

class StudentLocationTableViewCell : UITableViewCell{
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mediaLabel: UILabel!
}
    


class ListViewVC: UIViewController, UITableViewDelegate,  UITableViewDataSource  {
    
    let navBarFunctions = NavBarFunctions()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        NetworkingManager.getStudentsLocations(completion: handleGetLocationsResponse(studentLocations:error:))
        StudentLocations.data.sort(){$0.updatedAt > $1.updatedAt}
        tableView.reloadData()
    }
    
    @IBAction func logout(_ sender: Any) {
        navBarFunctions.logout()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func refresh(_ sender: Any) {
        NetworkingManager.getStudentsLocations(completion: handleGetLocationsResponse(studentLocations:error:))
        StudentLocations.data.sort(){$0.updatedAt > $1.updatedAt}
        tableView.reloadData()
    }
    
    
    @IBAction func addPin(_ sender: Any) {
         performSegue(withIdentifier: "showInputStudentInfoVC", sender: self)
    }
    
    func handleGetLocationsResponse(studentLocations: [StudentLocation], error: Error?){
        if studentLocations.count > 0{
            StudentLocations.data = studentLocations
        }
        else{
            displayAlert(title: "Failed To Get Locations", message: "Please refresh")
        }
        
    }
    
    //MARK: TableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentLocations.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentLocationTableViewCell", for: indexPath) as! StudentLocationTableViewCell
            cell.nameLabel?.text = StudentLocations.data[indexPath.row].firstName + " " +
                StudentLocations.data[indexPath.row].lastName
            cell.mediaLabel.text =  StudentLocations.data[indexPath.row].mediaURL
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let app = UIApplication.shared
        if let url = URL(string:StudentLocations.data[indexPath.row].mediaURL){
            if app.canOpenURL(url){
                app.openURL(url)
            }
            else{
                displayAlert(title: "Can't open URL", message: "Please choose a different pin")
            }
        }
    }
}
