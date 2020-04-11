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
    var palces:[VRWeb] = [VRWeb(ver: "1",url: "https://my.matterport.com/show/?m=vLYoS66CWpk&fbclid=IwAR3UPmjDDyQXToUi4d1kglfBiWwteFCyqqgOo46bx47_bzTs-GaZC3zViKI"),VRWeb(ver: "2", url: "https://my.matterport.com/show/?m=d42fuVA21To&fbclid=IwAR2F_SsmCcs9MZzieOMmh0hgT0hAI3z08nvkrxM1nGhr_PtmcaqTCS2RsN0")]
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
