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
        if  let  data = imageView.image?.jpegData(compressionQuality: 0.5){
           
            let uuid = UUID().uuidString // different image save firebase storage and different names.
            
            let imageReferance = mediaFolder.child("\(uuid).jpeg") // if you dont add jpeg. You save the .dms extension.
            
            imageReferance.putData(data, metadata: nil) { (metadata, error) in
                if error != nil{
                    self.makeAlert(title: "Storage Error!", error: error?.localizedDescription ?? "Error about Storage")
                }
                
                else{
                    imageReferance.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteURL
                            print("Linkten onceki satir.")
                            print(imageUrl!)
                            // DATABASE
                            let fireStore = Firestore.firestore()
                            var fireStorRef : DocumentReference? = nil
                            
                            let fireStorePost = ["imageUrl" : imageUrl?.absoluteString ?? "Error image url" ,"postedBy" : Auth.auth().currentUser!.email!,"postComment" : self.tfName.text!, "date" : "date" , "likes" : 0 ] as [String : Any]
                            
                            fireStorRef = fireStore.collection("Posts").addDocument(data: fireStorePost, completion: { (error) in
                                if error != nil{
                                    self.makeAlert(title: "Error", error: error?.localizedDescription ?? "firestore Error")
                                }
                            })
                    
                            
                    }
                  }
                }
                
               }
        }
    }
       
    func makeAlert( title : String , error : String){
        let alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertController.Style.alert)
         let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
         alert.addAction(okButton)
         self.present(alert, animated: true, completion: nil)
        
    }
        
    }
    


