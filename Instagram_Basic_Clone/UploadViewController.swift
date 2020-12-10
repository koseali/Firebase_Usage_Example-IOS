//
//  UploadViewController.swift
//  Instagram_Basic_Clone
//
//  Created by Ali Köse on 7.12.2020.
//

import UIKit
import Firebase
class UploadViewController: UIViewController ,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var tfDate: UITextField!
    
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tfName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gesture)
    }
    @objc func chooseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func clickUpload(_ sender: Any) { // image save on firebase storage.
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let mediaFolder = storageRef.child("media") // child ile klasor icinde gidebiliyoruz.
        if let  data = imageView.image?.jpegData(compressionQuality: 0.5){
            
            let imageReferance = mediaFolder.child("image.jpeg")
            imageReferance.putData(data, metadata: nil) { (metadata, error) in
                if error != nil{
                    
                   let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Hata", preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    imageReferance.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteURL
                            print("Linkten onceki satir.")
                            print(imageUrl!)
                        }
                    }
                    
                    
                }
            
            }
        }
    }
    

}
