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
        // Do any additional setup after loading the view.
    }
    var ChangeBk:Bool = false
    var speechSynthesizer = AVSpeechSynthesizer()
    
    func RatingBar(_ ratingBar: RatingBar, didChangeValue value: Int) {
           print(value)
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
}

