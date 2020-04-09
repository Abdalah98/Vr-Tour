//
//  AbourVrViewController.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 3/12/20.
//  Copyright © 2020 Hello Tomorrow. All rights reserved.
//

import UIKit
import RateBar
import AVFoundation
import Firebase
class AboutVrViewController: UIViewController,RatingBarDelegate {
    @IBOutlet weak var ratingbar: RatingBar!
    @IBOutlet weak var imageVr: UIImageView!
    @IBOutlet weak var explainedAboutPlace: UITextView!
    @IBOutlet weak var SpeechText: UIButton!
    @IBOutlet weak var vrButton: UIButton!
    var iamgeShow :UIImage?
    var documentation = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        ratingbar.delegate = self
        imageVr.image = iamgeShow
        explainedAboutPlace.text = documentation
        fetchPost()
    }
    var ChangeBk:Bool = false
    var speechSynthesizer = AVSpeechSynthesizer()
    
    func RatingBar(_ ratingBar: RatingBar, didChangeValue value: Int) {
           print(value)
        saveRate(value: String(value))
       }
   
    @IBAction func GetPressedSpeech(_ sender: Any) {
    
        
        if !speechSynthesizer.isSpeaking{
                let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: explainedAboutPlace.text)
            speechUtterance.rate =  0.3
                   //AVSpeechUtteranceMaximumSpeechRate /
                      speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                      speechSynthesizer.speak(speechUtterance)
                       if #available(iOS 13.0, *) {
                                        SpeechText.setImage(UIImage(systemName: "speaker.slash.fill"), for: .normal)
                                      } else {
                                          // Fallback on earlier versions
                                     }
             
        }else{
            speechSynthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
                   if #available(iOS 13.0, *) {
                                SpeechText.setImage(UIImage(systemName: "speaker.3.fill"), for: .normal)
                           } else {
                             // Fallback on earlier versions
                           }
        }
    }
    @IBAction func CancelPressed(_ sender: Any) {
         dismiss(animated: true, completion: nil)
     }
     

    @IBAction func GetPressedVrWatch(_ sender: Any) {


    }


    fileprivate func fetchPost(){
          guard let uid = Auth.auth().currentUser?.uid else{return}
          Database.database().reference().child("Rates").child(uid).observeSingleEvent(of: .value
              , with: { (snapshot) in
               //   print("value is: ", snapshot.value ?? "" )
                  guard let dictionarys = snapshot.value as? [String:Any] else{return}
                  dictionarys.forEach { (key,value) in
                    guard let dictionary = value as? [String:Any]else { return}
                  let rateView = dictionary["rate"] as? String

                    self.ratingbar.setRatingValue(rateValue: Double(rateView ?? "err") as! Double)
                }
          }) { (err) in
              print(err.localizedDescription)
          }
          
      }
    
    
    fileprivate func saveRate(value:String){
        
  guard let uid = Auth.auth().currentUser?.uid  else { return}
           let userPostRef = Database.database().reference().child("Rates").child(uid)
          let ref = userPostRef.childByAutoId()
         let value = ["rate":value]
           ref.onDisconnectUpdateChildValues(value) { (err, ref) in
                if let err = err {
                    print(err.localizedDescription)
            }
            print("done")
           }

}
}
