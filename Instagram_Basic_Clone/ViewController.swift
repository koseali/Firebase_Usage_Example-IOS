//
//  ViewController.swift
//  Instagram_Basic_Clone
//
//  Created by Ali Köse on 5.12.2020.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    @IBOutlet weak var tfMail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func signinClicked(_ sender: Any) {

        
        performSegue(withIdentifier: "toFeedVC", sender: nil)
    }
    
    @IBAction func singupClick(_ sender: Any) {
        
        if tfMail.text != "" &&  tfPassword.text != "" { // Auth firebase  Auth.auth
            Auth.auth().createUser(withEmail: tfMail.text!, password: tfPassword.text!) { (authdata, errorAuth ) in
                if errorAuth != nil{
                    self.Alert(title: "Error!", error:errorAuth?.localizedDescription ?? "Sig in Error")
    
                }
                else{self.performSegue(withIdentifier: "toFeedVC", sender: nil)}
                                                                                        }
        }
        else{
            Alert(title: "Error",error: "Password/mail is not empty")
        
            }                                   }
    func Alert(title: String,error : String) {
        
        let  alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

