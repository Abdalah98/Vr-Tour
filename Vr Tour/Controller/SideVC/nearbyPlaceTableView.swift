//
//  nearbyPlaceTableView.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 3/10/20.
//  Copyright © 2020 Hello Tomorrow. All rights reserved.
//

import UIKit

class nearbyPlaceTableView: UIViewController {

    @IBOutlet weak var nearvyPalceTVC: UITableView!{
        didSet {
            nearvyPalceTVC.tableFooterView = UIView()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

  var ArrayNerbyPalces :[Nearby] = [Nearby(palces: "policies"),Nearby(palces: "Cafes"),Nearby(palces: "Banks"),Nearby(palces: "Airports"),Nearby(palces: "Hotels"),Nearby(palces: "Restaurants")]
    
    //MARK: - CancelButton
    @IBAction func CancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
// MARK: - Table view data source

extension nearbyPlaceTableView : UITableViewDelegate , UITableViewDataSource{
       func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return  ArrayNerbyPalces.count
        }

       
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellNearbyPalce", for: indexPath)
            let aa = ArrayNerbyPalces[indexPath.row]
            cell.textLabel?.text = aa.palces
            return cell
        }
    
    
    //MARK: - Segue
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                 if segue.identifier == "showMap" {
                     let destinationController = segue.destination as! MapViewController
                     if let indexPath = nearvyPalceTVC.indexPathForSelectedRow {
                         destinationController.locationNearby = ArrayNerbyPalces[indexPath.row]
                     }else{
                       return print("error")
                   }
                 }
             }
    }


  
