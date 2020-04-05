//
//  PhotoSelectorController.swift
//  Instagram Firebase
//
//  Created by Abdalah Omar on 3/30/20.
//  Copyright © 2020 Hello Tomorrow. All rights reserved.
//

import UIKit
import Photos
private let reuseIdentifier = "PhotoSelector"

class PhotoSelectorController: UICollectionViewController,UICollectionViewDelegateFlowLayout{

    override func viewDidLoad() {
        super.viewDidLoad()


    fatchImage()

    }
    
  
    @IBAction func nextAction(_ sender: Any) {
        
        handelNext()
    }
    
    
    func handelNext(){
        
   
        performSegue(withIdentifier: "GoShareImage", sender: view)

    }
    
          
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoShareImage"{
            let destination = segue.destination as! SharePhotoController
            destination.selectedImage =  header?.headerImage.image
            
        }
    
    }
    
    //MARK: - fetchimage
    var selectedImage:UIImage?
        var images = [UIImage]()
    var assets = [PHAsset]()
    fileprivate func assetsFetchOptions()->PHFetchOptions{
        let fetchOptions = PHFetchOptions()
       let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
         fetchOptions.sortDescriptors = [sortDescriptor]
        return fetchOptions
    }
    
 fileprivate func fatchImage(){
     let allPhotos = PHAsset.fetchAssets(with: .image, options: assetsFetchOptions())
    DispatchQueue.global(qos: .background).async {

      allPhotos.enumerateObjects { (asset, count, stop) in
      
            let imageManger = PHImageManager.default()
            let targetSize = CGSize(width: 300, height: 300)
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            imageManger.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options) { (image, info) in
                if let image = image {

                    self.images.append(image)
                    self.assets.append(asset)
          

                    if self.selectedImage == nil {
                        self.selectedImage = image
                    }
                }
                if count == allPhotos.count - 1 {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                     
                    }
            }
           
        }
    }
    }
    }

    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
   
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoSelectorCell
        

       cell.imageShow?.image = self.images[indexPath.item]
       cell.backgroundColor = .blue
      
        return cell
    }
    var header : PhotoSelectorReusableView?
     
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
              let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PhotoSelectorResuable", for: indexPath) as! PhotoSelectorReusableView
        self.header = header

        header.headerImage.image = selectedImage

        if let selectedImage = selectedImage {
            if  let index = self.images.firstIndex(of: selectedImage){
                let selectedAssets = self.assets[index]
                let imageMager = PHImageManager.default()
                let targetSize = CGSize(width: 600, height: 600)

                imageMager.requestImage(for:selectedAssets, targetSize: targetSize, contentMode: .default, options: nil) { (image, info) in
                    header.headerImage.image = image
                }
            }
        }
       
              return header
          }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                  let width = view.frame.width
                  let height = view.frame.width
                  return CGSize(width: (width / 3) - 2 , height: (height / 3) - 2)
              }
              func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                  return 1
              }
              func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                  return 1
              }
              func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
                  let width = view.frame.width
                  return CGSize(width: width, height: 400)
              }
     
   
        
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          self.selectedImage = images[indexPath.item]
          self.collectionView.reloadData()
        let indexPath = IndexPath(item : 0,section: 0)
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
      }
}
