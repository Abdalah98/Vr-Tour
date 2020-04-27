//
//  TableViewController.swift
//  ss
//
//  Created by Abdalah Omar on 4/10/20.
//  Copyright © 2020 Hello Tomorrow. All rights reserved.
//

import UIKit
struct VRWeb {
    var ver : String
    var url :String
}
class VRWebsitetV: UITableViewController {
    var palces:[VRWeb] = [VRWeb(ver: "Tomb of Menna in the Theban Necropolis",url: "https://my.matterport.com/show/?m=vLYoS66CWpk&fbclid=IwAR3UPmjDDyQXToUi4d1kglfBiWwteFCyqqgOo46bx47_bzTs-GaZC3zViKI")
        ,VRWeb(ver: "Tomb of Queen Meresankh III", url: "https://my.matterport.com/show/?m=d42fuVA21To&fbclid=IwAR2F_SsmCcs9MZzieOMmh0hgT0hAI3z08nvkrxM1nGhr_PtmcaqTCS2RsN0"),
        VRWeb(ver: "Cairo From Above cairo tower", url: "https://roundme.com/tour/213801/view/588356/"),
        VRWeb(ver: "Sinai Canyons", url: "https://roundme.com/tour/213881/view/588687/"),
        VRWeb(ver: "Emerald City", url: "https://roundme.com/tour/217886/view/605643"),
        VRWeb(ver: "Habu Temple Medinet Habu", url: "https://roundme.com/tour/212009/view/580995/"),
        VRWeb(ver: "Dendera Temple Complex", url: "https://roundme.com/tour/205310/view/561351/"),
        VRWeb(ver: "Kom Ombo Temple", url: "https://roundme.com/tour/207054/view/575025/"),
        VRWeb(ver: "Mortuary Temple of Hatshepsut", url: "https://roundme.com/tour/207387/view/565418/"),
        VRWeb(ver: "Qaitbay Citadel", url: "https://roundme.com/tour/188829/view/491881/"),
        VRWeb(ver: "Egypt Mosques omar ibn alas", url: "https://roundme.com/tour/188877/view/495191/"),
        VRWeb(ver: "Abu Simbel temples", url: "https://roundme.com/tour/18915/view/46341/"),
        VRWeb(ver:"Valley of the Whales (Wadi Al-Hitan)" , url: "https://roundme.com/tour/6706/view/17765"),
        VRWeb(ver: "El-Medawara Mount - Wadi El Rayan", url: "https://roundme.com/tour/6649/view/17661"),
        VRWeb(ver: "Qesm Al Wahat Al Khargah, New Valley Governorate, Egypt", url: "https://roundme.com/tour/8307/view/21390/"),
        VRWeb(ver: "Edfu Temple The Temple of Horus", url: "https://roundme.com/map/tour/19806"),
        VRWeb(ver: "Sannur Cave", url: "https://roundme.com/tour/18197/view/44827")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
        
        
        
        
       
        
     
        
        
        
       
        
        
        
        
        
        
        
       
        
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = palces[indexPath.row].ver

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
     
     
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
//44682139
