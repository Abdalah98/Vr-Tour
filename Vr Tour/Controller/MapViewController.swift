//
//  MapViewController.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 11/21/19.
//  Copyright © 2019 Hello Tomorrow. All rights reserved.
//

import UIKit
import Firebase
import SCLAlertView
import Firebase
import MapKit
import Speech
import CoreLocation
import SVProgressHUD

class MapViewController: UIViewController{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var recordButton: UIButton!
    
    var showLocationByVR : LocationVr!
    var locationNearby :Nearby?
      
    var currentPlacemark:CLPlacemark?
    var currentRoute: MKRoute?
    //MARK: - SpeechRecording
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))  //1 "ar-SA" "en-US"
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1000
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        checkLocationServices()
        searchBar.delegate = self
     //   mapView.delegate = self

        recordButton.isEnabled = false  //2
        
        speechRecognizer!.delegate = self  //3
        
        speechDelegateAudio()
        shownearby()

        convertAddressStringtoLocation()
    }
    override func viewWillAppear(_ animated: Bool) {
              navigationController?.isNavigationBarHidden = true
          }
     override func viewWillDisappear(_ animated: Bool) {
              navigationController?.isNavigationBarHidden = false
              
          }
    
    //MARK: - Buttons
    
    //MARK: - recordDidPressed
    
    @IBAction func recordDidPressed(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            
            recognitionRequest?.endAudio()
            recordButton.isEnabled = false
            clean ()
            if #available(iOS 13.0, *) {
                recordButton.setImage(UIImage(systemName: "mic.fill"), for: .normal)
            } else {
                // Fallback on earlier versions
            }
        } else {
            
            clean ()
            startRecording()
            
            if #available(iOS 13.0, *) {
                recordButton.setImage(UIImage(systemName: "square.fill"), for: .normal)
            } else {
                // Fallback on earlier versions
            }
            
        }
        
    }
    //MARK: - getMyLocationdirection
    @IBAction func getMyLocation(_ sender: Any) {
        //centerViewOnUserLocation()
        guard let currentPlacemark = currentPlacemark else {
                       return
                   }
               let directionRequest = MKDirections.Request()
                   // Set the source and destination of the route
               directionRequest.source = MKMapItem.forCurrentLocation()
               let destinationPlacemark = MKPlacemark(placemark: currentPlacemark)
               directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
               directionRequest.transportType = MKDirectionsTransportType.automobile
                   // Calculate the direction
               let directions = MKDirections(request: directionRequest)
               directions.calculate { (routeResponse, routeError) -> Void in
                       guard let routeResponse = routeResponse else {
                           if let routeError = routeError {
                               print("Error: \(routeError)")
                           }
               return
               }
                  
               let route = routeResponse.routes[0]
                   let rect = route.polyline.boundingMapRect
                   self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                   self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads) }
    }
    
}




//MARK: - CLLocationManagerDelegate Map
extension MapViewController: CLLocationManagerDelegate {
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
            SCLAlertView().showError("Error", subTitle: " tha app needed to permissions location ot turn on location ", closeButtonTitle:"Ok")
            
        }
    }
    
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Show alert instructing them how to turn on permissions
            SCLAlertView().showError("Error", subTitle: " tha app needed to permissions location ", closeButtonTitle:"Ok")
            
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted:
            // Show an alert letting them know what's up
            SCLAlertView().showError("Error", subTitle: "letting them know what's up", closeButtonTitle:"Ok")
            
            break
        case .authorizedAlways:
            break
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    
    
}



//MARK: - mapDelegate
 
 // MARK: - MKMapViewDelegate methods
extension MapViewController :MKMapViewDelegate{
func convertAddressStringtoLocation()
{

          
         //   Request for a user's authorization for location services
            locationManager.requestWhenInUseAuthorization()
            let status = CLLocationManager.authorizationStatus()
            if status == CLAuthorizationStatus.authorizedWhenInUse { mapView.showsUserLocation = true
             }
                
     //
     /*The framework provides a Geocoder class for developers to convert a textual address, known as placemark, into global coordinates. This process is usually referred to forward geocoding. Conversely, you can use Geocoder to convert latitude and longtitude values back to a placemark. This process is known as reverse geocoding.*/

              // Convert address to coordinate and annotate it on map
              let geoCoder = CLGeocoder()
             geoCoder.geocodeAddressString(showLocationByVR?.location ?? "", completionHandler: { placemarks, error in
                  if let error = error {
                      print(error)
                      return
                  }
                  
                  if let placemarks = placemarks {
                      // Get the first placemark
                      let placemark = placemarks[0]
                      self.currentPlacemark = placemark
                      // Add annotation
                     //We convert the address into a coordinate for annotation
                      let annotation = MKPointAnnotation()
                     annotation.title = self.showLocationByVR?.name
                     annotation.subtitle = self.showLocationByVR?.type
                      
                      if let location = placemark.location {
                          annotation.coordinate = location.coordinate
                          
                          // Display the annotation
                          self.mapView.showAnnotations([annotation], animated: true)
                          self.mapView.selectAnnotation(annotation, animated: true)
                      }
                  }
                  
              })
              mapView.delegate = self
                   

    }

         func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
             let identifier = "MyPin"
             
             if annotation.isKind(of: MKUserLocation.self) {
                 return nil
             }
             
             // Reuse the annotation if possible
             var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
             
             if annotationView == nil {
                 annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                 annotationView?.canShowCallout = true
             }
             
             // Pin color customization based on the type of annotation
             if let currentPlacemarkCoordinate = currentPlacemark?.location?.coordinate {
                 if currentPlacemarkCoordinate.latitude == annotation.coordinate.latitude &&
                     currentPlacemarkCoordinate.longitude == annotation.coordinate.longitude {
                     
                     let leftIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53, height: 53))
                     leftIconView.image = UIImage(named: showLocationByVR?.image ?? "")
                     annotationView?.leftCalloutAccessoryView = leftIconView
                     
                     // Pin color customization
                    
                         annotationView?.pinTintColor = UIColor.orange
                     
                 } else {
                     // Pin color customization
                     
                         annotationView?.pinTintColor = UIColor.red
                     
                 }
             }
             
             annotationView?.rightCalloutAccessoryView = UIButton(type: UIButton.ButtonType.detailDisclosure)
             
             return annotationView
         }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 3.0
            return renderer
        }
          func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
              performSegue(withIdentifier: "showVRdetaiels", sender: view)
          }
     

        @IBAction func showDirection(sender: AnyObject) {
             guard let currentPlacemark = currentPlacemark else {
                    return
                }
            let directionRequest = MKDirections.Request()
                // Set the source and destination of the route
            directionRequest.source = MKMapItem.forCurrentLocation()
            let destinationPlacemark = MKPlacemark(placemark: currentPlacemark)
            directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
            directionRequest.transportType = MKDirectionsTransportType.automobile
                // Calculate the direction
            let directions = MKDirections(request: directionRequest)
            directions.calculate { (routeResponse, routeError) -> Void in
                    guard let routeResponse = routeResponse else {
                        if let routeError = routeError {
                            print("Error: \(routeError)")
                        }
            return
            }
               
            let route = routeResponse.routes[0]
                let rect = route.polyline.boundingMapRect
                self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads) }
    }

        func shownearby(){
            let searchRequest = MKLocalSearch.Request()
                        // searchRequest.naturalLanguageQuery = locationMap.type
                   searchRequest.naturalLanguageQuery = locationNearby?.palces
                         searchRequest.region = mapView.region
                         
                         let localSearch = MKLocalSearch(request: searchRequest)
                         localSearch.start { (response, error) -> Void in
                             guard let response = response else {
                                 if let error = error {
                                     print(error)
                                 }
                                 
                                 return
                             }
                             
                             let mapItems = response.mapItems
                             var nearbyAnnotations: [MKAnnotation] = []
                             if mapItems.count > 0 {
                                 for item in mapItems {
                                     // Add annotation
                                     let annotation = MKPointAnnotation()
                                     annotation.title = item.name
                                     annotation.subtitle = item.phoneNumber
                               
                                     if let location = item.placemark.location {
                                         annotation.coordinate = location.coordinate
                                     }
                                     nearbyAnnotations.append(annotation)
                                 }
                             }
                             
                             self.mapView.showAnnotations(nearbyAnnotations, animated: true)
                         }
        }
}






//MARK: - searchBar in map
extension MapViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        //Ignoring user
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        SVProgressHUD.show(withStatus: "Loading...")
        
        //Hide search bar
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        //Create the search request
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
            SVProgressHUD.dismiss()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil
            {
                print("ERROR")
            }
            else
            {
                //Remove annotations
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                //Getting data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //Create annotation
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.mapView.addAnnotation(annotation)
                
                //Zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapView.setRegion(region, animated: true)
            }
            
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
    
}




//MARK: - SpeechRecognizerDelegate
extension MapViewController :SFSpeechRecognizerDelegate{
    
    
    
    func startRecording() {
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.record)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: AVAudioSession.CategoryOptions.mixWithOthers )
            
            try audioSession.setActive(true)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                
                self.searchBar.text = result?.bestTranscription.formattedString
                print("print voce\(result?.bestTranscription.formattedString)")
                isFinal = (result?.isFinal)!
                
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.recordButton.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        searchBar.text = "Say something, I'm listening!"
        
    }
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            recordButton.isEnabled = true
        } else {
            
            recordButton.isEnabled = false
        }
    }
    func clean (){
        searchBar.text = ""
    }
    
    func speechDelegateAudio(){
        SFSpeechRecognizer.requestAuthorization { (authStatus) in  //4
            
            var isButtonEnabled = false
            
            switch authStatus {  //5
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                SCLAlertView().showError("Error", subTitle: "User denied access to speech recognition", closeButtonTitle:"Ok")
                
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                SCLAlertView().showError("Error", subTitle:"Speech recognition restricted on this device", closeButtonTitle:"Ok")
                
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
                SCLAlertView().showError("Error", subTitle: "Speech recognition not yet authorized", closeButtonTitle:"Ok")
                
            }
            
            OperationQueue.main.addOperation() {
                self.recordButton.isEnabled = isButtonEnabled
            }
        }
    }
}
