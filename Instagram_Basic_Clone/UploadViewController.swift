//
//  UploadViewController.swift
//  Instagram_Basic_Clone
//
//  Created by Ali Köse on 7.12.2020.
//

import UIKit

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

    @IBAction func clickUpload(_ sender: Any) {
    }
    

}
