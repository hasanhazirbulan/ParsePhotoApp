//
//  ViewController.swift
//  ParsePhotoApp
//
//  Created by Hasan Hazırbulan on 19.08.2023.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var kullaniciAdiText: UITextField!
    @IBOutlet weak var parolaText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
   
        }
    
  
    
    @IBAction func girisYapTiklandi(_ sender: Any) {
        if kullaniciAdiText.text != "" && parolaText.text != "" {
            
            PFUser.logInWithUsername(inBackground: kullaniciAdiText.text!, password: parolaText.text!) { (user, error) in
                if error != nil {
                   
                } else {
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                    
                }
            }
        } else {
            self.hataMesajiGoster(title: "Hata!", message: "Kullancı Adı ve Parola girmelisiniz")
        }
    }
    
    
    @IBAction func kayitOlTiklandi(_ sender: Any) {
        
        if kullaniciAdiText.text != "" && parolaText.text != "" {
           
            let user = PFUser()
            user.username = kullaniciAdiText.text!
            user.password = parolaText.text!
            
            user.signUpInBackground { (success, error) in
                if error != nil {
                    self.hataMesajiGoster(title: "Hata", message: error?.localizedDescription ?? "Hata")
                } else {
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
            }
            
        } else {
            hataMesajiGoster(title: "Hata!", message: "Kullancı Adı ve Parola girmelisiniz")
        }
        
    }
    func hataMesajiGoster(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(OKButton)
        self.present(alert, animated: true, completion: nil)
    }

    }



