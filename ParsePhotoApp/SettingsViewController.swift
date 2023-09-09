//
//  SettingsViewController.swift
//  ParsePhotoApp
//
//  Created by Hasan Hazırbulan on 19.08.2023.
//

import UIKit
import Parse

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cikisYapTiklandi(_ sender: Any) {
        
        PFUser.logOutInBackground { (error) in
            if error != nil {
                let alert = UIAlertController(title: "Hata!", message: error?.localizedDescription ?? "Hata!", preferredStyle: .alert)
                let OKButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(OKButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "toViewController", sender: nil)
            }
        }
        
        
        
        
    }
    
    

}
