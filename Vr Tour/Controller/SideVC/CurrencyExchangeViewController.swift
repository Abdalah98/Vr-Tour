//
//  CurrencyExchangeViewController.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 2/23/20.
//  Copyright © 2020 Hello Tomorrow. All rights reserved.
//

import UIKit
import SVProgressHUD
import SCLAlertView
class CurrencyExchangeViewController: UIViewController {

  
    var myCurrency:[String] = []
       var myValues:[Double] = []
       
       var activeCurrency:Double = 0;
       
       //OBJECTS
       @IBOutlet weak var input: UITextField!
       @IBOutlet weak var pickerView: UIPickerView!
       @IBOutlet weak var output: UILabel!
       
    


       override func viewDidLoad()
       {
           super.viewDidLoad()
           self.hideKeyboardWhenTappedAround()

           //GETTING DATA
           let url = URL(string: "http://data.fixer.io/api/latest?access_key=f95707d8f158119001743621b95da57c")
           
           let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
               
               if error != nil
               {
                   print ("ERROR")
               }
               else
               {
                   if let content = data
                   {
                       do
                       {
                           let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                           
                           if let rates = myJson["rates"] as? NSDictionary
                           {
                               for (key, value) in rates
                               {
                                   self.myCurrency.append((key as? String)!)
                                   self.myValues.append((value as? Double)!)
                               }
                           }
                       }
                       catch
                       {
                           
                       }
                   }
               }
               DispatchQueue.main.async {
                               self.pickerView.reloadAllComponents()

               }
           }
           task.resume()
       }
    
    //MARK: - GetCurrency
    @IBAction func action(_ sender: AnyObject)
    {
         SVProgressHUD.show(withStatus: "Loading...")

     if (input.text!.isEmpty){
          SCLAlertView().showError("Error", subTitle:"Some field is empty add number in text to change manoy", closeButtonTitle:"Ok")
         SVProgressHUD.dismiss()
     }else{

         output.text = ("Currency Value : \(String(Double(input.text!)! * activeCurrency))")
     
         SVProgressHUD.dismiss()

     }


    }
    
    
     
    //MARK: - CancelButton

       @IBAction func cancelButton(_ sender: Any) {
           dismiss(animated: true, completion: nil)
       }
       
}



//MARK: - PickerView
extension CurrencyExchangeViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int
         {
             return 1
         }
         
         func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
         {
            

             return myCurrency.count
         }
         
         func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
         {
            

             return myCurrency[row]
         }
         
         func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
         {

             activeCurrency = myValues[row]
         }
         
}
