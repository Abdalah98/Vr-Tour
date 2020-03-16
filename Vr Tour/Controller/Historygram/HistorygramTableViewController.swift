//
//  HistorygramTableViewController.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 3/14/20.
//  Copyright © 2020 Hello Tomorrow. All rights reserved.
//

import UIKit
import  Social

class HistorygramViewController: UIViewController {

    @IBOutlet weak var tableviewHistory: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
}
   var Array = ["caskpubkitchen.jpg","barrafina","bourkestreetbakery","cafeloisl","forkeerestaurant","bourkestreetbakery","bourkestreetbakery","upstate","bourkestreetbakery","grahamavenuemeats","bourkestreetbakery","royaloak","bourkestreetbakery","confessional","bourkestreetbakery"]
   // var Array :[pla] = [pla(iamge: "barrafina"),pla(iamge: "barrafina"),pla(iamge: "barrafina"),pla(iamge: "barrafina"),pla(iamge: "barrafina"),pla(iamge: "barrafina"),pla(iamge: "royaloak"),pla(iamge: "bourkestreetbakery"),pla(iamge: "confessional"),pla(iamge: "barrafina"),pla(iamge: "bourkestreetbakery")]
     @IBAction func CancelPressed(_ sender: Any) {
            dismiss(animated: true, completion: nil)
        }
        
   
    
    }
    // MARK: - Table view data source

    extension HistorygramViewController : UITableViewDelegate , UITableViewDataSource{
           func numberOfSections(in tableView: UITableView) -> Int {
                // #warning Incomplete implementation, return the number of sections
                return 1
            }

             func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                // #warning Incomplete implementation, return the number of rows
                return Array.count
            }

           
             func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellOfHistorygram", for: indexPath) as! HistorygramTableViewCell
                
                cell.imagePlace.image = UIImage(named:Array[indexPath.row])
                return cell
            }
        
        @IBAction func shar(_ sender: AnyObject) {
let buttonPosition = sender.convert(CGPoint.zero, to: tableviewHistory)
      guard let indexPath = tableviewHistory.indexPathForRow(at: buttonPosition) else {
          return
      }
              // Display the share menu
               let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .actionSheet)
               let twitterAction = UIAlertAction(title: "Twitter", style:
               UIAlertAction.Style.default) { (action) in
               // Check if Twitter is available. Otherwise, display an error message
               guard SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) else {
               let alertMessage = UIAlertController(title: "Twitter Unavailable", message: "You haven't registered your Twitter account. Please go to Settings > Twitter to create one.", preferredStyle: .alert)
               alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   self.present(alertMessage, animated: true, completion: nil); return
               }
                   // Display Tweet Composer
                   if let tweetComposer = SLComposeViewController(forServiceType:
               SLServiceTypeTwitter) {
               tweetComposer.setInitialText("Having lunch at " + self.Array[indexPath.row])
               tweetComposer.add(UIImage(named: self.Array[indexPath.row]))
               self.present(tweetComposer, animated: true, completion: nil) }
               }

               let facebookAction = UIAlertAction(title: "Facebook", style: UIAlertAction.Style.default) { (action) in
               // Check if Facebook is available. Otherwise, display an error message
               guard SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) else {
                       let alertMessage = UIAlertController(title: "Facebook Unavailable",
                            message: "You haven't registered your Facebook account. Please go to Settings > Facebook to create one.", preferredStyle: .alert)
               alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   self.present(alertMessage, animated: true, completion: nil)
                   return
               }
                   // Display Tweet Composer
                   if let fbComposer = SLComposeViewController(forServiceType:
               SLServiceTypeFacebook) {
               fbComposer.setInitialText("Having lunch at " + self.Array[indexPath.row])
                       fbComposer.add(UIImage(named: self.Array[indexPath.row]));
                    self.present(fbComposer, animated: true, completion: nil)
               } }

               let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
               
               shareMenu.addAction(twitterAction)
               shareMenu.addAction(facebookAction)
               shareMenu.addAction(cancelAction)
               
               self.present(shareMenu, animated: true, completion: nil)
           }
    
        }

//Array[indexPath.row]
