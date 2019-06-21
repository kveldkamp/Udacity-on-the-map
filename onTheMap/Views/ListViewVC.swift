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
    }
    
    @IBAction func logout(_ sender: Any) {
        navBarFunctions.logout()
    }
    
    
    @IBAction func refresh(_ sender: Any) {
        NetworkingManager.getStudentsLocations(completion: handleGetLocationsResponse(studentLocations:error:))
    }
    
    
    @IBAction func addPin(_ sender: Any) {
        navBarFunctions.addPin()
    }
    
    func handleGetLocationsResponse(studentLocations: [StudentLocation], error: Error?){
        if studentLocations.count > 0{
            StudentLocations.data = studentLocations
        }
        else{
            print("failed to get locations")
            //TODO: implement error dialog saying can't get locations
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
        //TODO: Sort cells by most recent update to oldest
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let app = UIApplication.shared
        if let url = URL(string:StudentLocations.data[indexPath.row].mediaURL){
            if app.canOpenURL(url){
                app.openURL(url)
            }
            else{
                //TODO: implement error dialog saying can't open URL
            }
        }
    }
}
