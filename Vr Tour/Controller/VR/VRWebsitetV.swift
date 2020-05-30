//
//  TableViewController.swift
//  ss
//
//  Created by Abdalah Omar on 4/10/20.
//  Copyright © 2020 Hello Tomorrow. All rights reserved.
//

import UIKit
struct VRWeb {
    var namePlace : String
    var url :String
    var imagePlace :String
}
class VRWebsitetV: UITableViewController {
    var palces:[VRWeb] = [VRWeb(namePlace: "Tomb of Menna in the Theban Necropolis",url: "https://my.matterport.com/show/?m=vLYoS66CWpk&fbclid=IwAR3UPmjDDyQXToUi4d1kglfBiWwteFCyqqgOo46bx47_bzTs-GaZC3zViKI",imagePlace:"Tomb of Menna in the Theban Necropolis")
        ,VRWeb(namePlace: "Tomb of Queen Meresankh III", url: "https://my.matterport.com/show/?m=d42fuVA21To&fbclid=IwAR2F_SsmCcs9MZzieOMmh0hgT0hAI3z08nvkrxM1nGhr_PtmcaqTCS2RsN0",imagePlace:"Tomb of Queen Meresankh III"),
         VRWeb(namePlace: "Cairo From Above cairo tower", url: "https://roundme.com/tour/213801/view/588356/",imagePlace: "Cairo From Above cairo tower"),
         VRWeb(namePlace: "Sinai Canyons", url: "https://roundme.com/tour/213881/view/588687/",imagePlace:"Sinai Canyons"),
         VRWeb(namePlace: "Emerald City", url: "https://roundme.com/tour/217886/view/605643",imagePlace:"Emerald City"),
         VRWeb(namePlace: "Habu Temple Medinet Habu", url: "https://roundme.com/tour/212009/view/580995/",imagePlace:"Habu Temple Medinet Habu"),
         VRWeb(namePlace: "Dendera Temple Complex", url: "https://roundme.com/tour/205310/view/561351/",imagePlace:"Dendera Temple Complex"),
         VRWeb(namePlace: "Kom Ombo Temple", url: "https://roundme.com/tour/207054/view/575025/",imagePlace:"Kom Ombo Temple"),
         VRWeb(namePlace: "Mortuary Temple of Hatshepsut", url: "https://roundme.com/tour/207387/view/565418/",imagePlace:"Mortuary Temple of Hatshepsut"),
         VRWeb(namePlace: "Qaitbay Citadel", url: "https://roundme.com/tour/188829/view/491881/",imagePlace:"Qaitbay Citadel"),
         VRWeb(namePlace: "Egypt Mosques omar ibn alas", url: "https://roundme.com/tour/188877/view/495191/",imagePlace:"Egypt Mosques omar ibn alas"),
         VRWeb(namePlace: "Abu Simbel temples", url: "https://roundme.com/tour/18915/view/46341/",imagePlace:"Abu Simbel temples"),
         VRWeb(namePlace:"Valley of the Whales (Wadi Al-Hitan)" , url: "https://roundme.com/tour/6706/view/17765",imagePlace:"Valley of the Whales (Wadi Al-Hitan)"),
         VRWeb(namePlace: "El-Medawara Mount - Wadi El Rayan", url: "https://roundme.com/tour/6649/view/17661",imagePlace:"El-Medawara Mount - Wadi El Rayan"),
         VRWeb(namePlace: "Qesm Al Wahat Al Khargah, New Valley Governorate, Egypt", url: "https://roundme.com/tour/8307/view/21390/",imagePlace:"Qesm Al Wahat Al Khargah, New Valley Governorate"),
         VRWeb(namePlace: "Edfu Temple The Temple of Horus", url: "https://roundme.com/map/tour/19806",imagePlace:"Edfu Temple The Temple of Horus"),
         VRWeb(namePlace: "Sannur Cave", url: "https://roundme.com/tour/18197/view/44827",imagePlace:"Sannur Cave")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return palces.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "otherPlacesCell", for: indexPath) as! otherPlacesCell
        let otherPlaces = palces[indexPath.row]
        cell.labelNamePlaces.text = otherPlaces.namePlace
        cell.imagePlaces.image = UIImage(named:otherPlaces.imagePlace)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVRwem" {
            let destinationController = segue.destination as! VRWebSiteCV
            
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationController.urls = palces[indexPath.row].url
            }else{
                return print("error")
            }
        }
    }
    
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
}

