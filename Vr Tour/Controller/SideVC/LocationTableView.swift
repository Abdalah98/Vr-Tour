
//
//  File.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 3/8/20.
//  Copyright © 2020 Hello Tomorrow. All rights reserved.
//

import UIKit
class LocationVrTableVC: UIViewController {

    @IBOutlet weak var LoactionsTVC: UITableView!{
        didSet {
            LoactionsTVC.tableFooterView = UIView()
        }
    }
    
    
    
    var locations:[LocationVr] = [
      LocationVr(name: "Homei", type: "Cafe", location: "75 9th Ave, New York, NY 10011", image: "homei.jpg", isVisited: false,rating: "1"),
      LocationVr(name: "Teakha", type: "Tea House", location: "110 St Marks Pl New York, NY 10009", image: "teakha.jpg", isVisited: false,rating: "4"),
      LocationVr(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "259 W 4th St, New York, NY 10014", image: "cafeloisl.jpg", isVisited: false,rating: "2"),
      LocationVr(name: "Petite Oyster", type: "French", location: "326 Dekalb Ave, Brooklyn, NY 11205", image: "petiteoyster.jpg", isVisited: false,rating: "3"),
          LocationVr(name: "CASK Pub and Kitchen", type: "Thai", location: "379 Grand St, New York, NY 10002", image: "caskpubkitchen.jpg", isVisited: false, rating: "8")
     ]
      override func viewDidLoad() {
            super.viewDidLoad()

          
        }

      
    //MARK: - CancelPressed
    @IBAction func CancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}


// MARK: - Table view

extension LocationVrTableVC :UITableViewDataSource, UITableViewDelegate{
     func numberOfSections(in tableView: UITableView) -> Int {
       
         return 1
     }

      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         // #warning Incomplete implementation, return the number of rows
         return locations.count
     }

    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
         let location = locations[indexPath.row]
         cell.textLabel?.text = location.name
         cell.detailTextLabel?.text = location.type
         cell.imageView?.image = UIImage(named:location.image)
         
         
         return cell
     }
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "showMap" {
               let destinationController = segue.destination as! MapViewController
               if let indexPath = LoactionsTVC.indexPathForSelectedRow {
                   destinationController.showLocationByVR = locations[indexPath.row]
               }else{
                 return print("error")
             }
           }
       }
}
