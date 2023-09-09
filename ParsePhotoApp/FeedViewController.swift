//
//  FeedViewController.swift
//  ParsePhotoApp
//
//  Created by Hasan Hazırbulan on 19.08.2023.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var postDizisi = [Post]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.delegate = self
        tableView.dataSource = self
        
        verileriAl()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(verileriAl), name: NSNotification.Name(rawValue: "yeniPost"), object: nil)
    }
    
    @objc func verileriAl() {
        
        let query = PFQuery(className: "Post")
        query.addDescendingOrder("createdAt")
        
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.hataMesaji(title: "Hata", message: error?.localizedDescription ?? "Hata")
            } else {
                if objects!.count > 0 {
                    self.postDizisi.removeAll(keepingCapacity: false)
                    
                    for object in objects! {
                        if let kullaniciIsmi = object.object(forKey: "postsahibi") as? String {
                            if let kullaniciYorum = object.object(forKey: "postyorum") as? String {
                                if let kullaniciGorsel = object.object(forKey: "postgorsel") as? PFFileObject {
                                    let post = Post(kullaniciAdi: kullaniciIsmi, kullaniciyorumu: kullaniciYorum, kullaniciGorsel: kullaniciGorsel)
                                    self.postDizisi.append(post)
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    func hataMesaji(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDizisi.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        
        cell.usernameLabel.text = postDizisi[indexPath.row].kullaniciAdi
        cell.kullsniciYorumLabel.text = postDizisi[indexPath.row].kullaniciyorumu
        postDizisi[indexPath.row].kullaniciGorsel.getDataInBackground { (data, error) in
            if error == nil {
                if let data = data {
                    cell.postImageView.image = UIImage(data: data)
                }
            }
                
        }
        
        
        return cell
    }
   

}
