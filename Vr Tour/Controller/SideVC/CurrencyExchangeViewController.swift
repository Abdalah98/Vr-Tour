//
//  CurrencyExchangeViewController.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 2/23/20.
//  Copyright © 2020 Hello Tomorrow. All rights reserved.
//

import UIKit

class CurrencyExchangeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

  
    var myCurrency:[String] = []
       var myValues:[Double] = []
       
       var activeCurrency:Double = 0;
       
       //OBJECTS
       @IBOutlet weak var input: UITextField!
       @IBOutlet weak var pickerView: UIPickerView!
       @IBOutlet weak var output: UILabel!
       
       //CREATING PICKER VIEW
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
       {print(  activeCurrency = myValues[row])

           activeCurrency = myValues[row]
       }
       
       //BUTTON
       @IBAction func action(_ sender: AnyObject)
       {
           if (input.text != "")
           {
               output.text = ("Currency Value : \(String(Double(input.text!)! * activeCurrency))")
           }
       }
       
       

       override func viewDidLoad()
       {
           super.viewDidLoad()
           
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

     

       @IBAction func cancelButton(_ sender: Any) {
           dismiss(animated: true, completion: nil)
       }
       
}
