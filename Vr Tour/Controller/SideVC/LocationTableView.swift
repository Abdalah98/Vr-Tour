
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
       LocationVr(name: "Mosque Muhammad Ali", type: "Mosque", location: "Mosque of Muhammad AliMosque of Muhammad Ali", image: "Kairo_Zitadelle_Muhammad-Ali-Moschee_01.jpg", isVisited: false, rating: "", AboutPlace: "Muhammad Ali chose to build his state mosque entirely in the architectural style of his former overlords, the Ottomans, unlike the Mamluks who, despite their political submission to the Ottomans, stuck to the architectural styles of the previous Mamluk dynasties.The mosque was built with a central dome surrounded by four small and four semicircular domes. It was constructed in a square plan and measured 41x41 meters. The central dome is 21 meters in diameter and the height of the building is 52 meters. Two elegant cylindrical minarets of Turkish type with two balconies and conical caps are situated on the western side of the mosque, and rise to 82 meters.The use of this style, combined with the presence of two minarets and multiple half-domes surrounding the central dome — features reserved for mosques built on the authority of the Sultan — were a defiant declaration of de facto Egyptian independence.The main material is limestone likely sourced from the Great Pyramids of Giza but the lower storey and forecourt is tiled with alabaster up to 11,3 meters. The external facades are severe and angular and rise about four storeys until the level of the lead-covered domes.The mihrab on the southeastern wall is three storeys high and covered with a semicircular dome. There are two arcades on the second storey, rising on columns and covered with domes. Although there are three entrances on each side of the forecourt, the usual entry is through the northeastern gate. The forecourt measures 50x50 meters. It is enclosed by arched riwaks rising on pillars and covered by domes.There is a brass clock tower in the middle of the northwestern riwak, which was presented to Muhammad Ali by King Louis Philippe of France in 1845. The clock was reciprocated with the obelisk of Luxor now standing in Place de la Concorde in Paris.The interior has a measure of 41x41 meters and gives a great feeling of space. The use of two levels of domes gives a much greater sense of space than there actually is. The central dome rises on four arches standing on colossal piers. There are four semicircular domes around the central dome. There are four smaller domes on the corners as well. The domes are painted and embellished with motifs in relief. The walls and pillars are covered with alabaster up to 11 meters high.")
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
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 80
    }
}
