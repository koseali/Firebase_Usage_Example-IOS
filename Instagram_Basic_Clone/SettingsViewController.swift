//
//  SettingsViewController.swift
//  Instagram_Basic_Clone
//
//  Created by Ali Köse on 7.12.2020.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func logOutClick(_ sender: Any) {
        do {
            try  Auth.auth().signOut()
         performSegue(withIdentifier: "toVC", sender: nil)
        } catch  {
            Alert(title: "Logout Error!", error: "Something was wrong!")
        }
        performSegue(withIdentifier: "toVC", sender: nil)
    }
    func Alert(title: String,error : String) {
        
        let  alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
