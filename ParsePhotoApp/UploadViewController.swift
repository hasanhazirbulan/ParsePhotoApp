//
//  UploadViewController.swift
//  ParsePhotoApp
//
//  Created by Hasan Hazırbulan on 19.08.2023.
//

import UIKit
import Parse

class UploadViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var yorumTextField: UITextField!
    @IBOutlet weak var paylasButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let keyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(klavyeyiSakla))
        view.addGestureRecognizer(keyboardRecognizer)
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        paylasButton.isEnabled = false
    }
    @objc func klavyeyiSakla() {
        view.endEditing(true)
    }
    @objc func gorselSec() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        paylasButton.isEnabled = true
    }
    
    @IBAction func paylasButtonClicked(_ sender: Any) {
        paylasButton.isEnabled = false
        
        let post = PFObject(className: "Post")
        
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        if let data = data {
            if PFUser.current() != nil {
                let parseImage = PFFileObject(name: "image.jpg", data: data)
               
                post["postgorsel"] = parseImage
                post["postyorum"] = yorumTextField.text!
                post["postsahibi"] = PFUser.current()!.username!
                
                
                post.saveInBackground { (success, error) in
                    if error != nil {
                        let alert = UIAlertController(title: "Hata", message: error?.localizedDescription ?? "Hata", preferredStyle: .alert)
                        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(okButton)
                        
                        self.present(alert, animated: true)
                    } else {
                        
                        self.yorumTextField.text = ""
                        self.imageView.image = UIImage(named: "gorselsec")
                        self.tabBarController?.selectedIndex = 0
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "yeniPost"), object: nil)
                        
                        
                    }
                }
            }
        }
    }
    

}
