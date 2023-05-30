//
//  FirebaseLoginViewController.swift
//  domeLogin
//
//  Created by 林祔利 on 2023/5/26.
//

import UIKit
import Firebase

class FirebaseLoginViewController: UIViewController {

    @IBOutlet weak var sucessLabel: UILabel!
    
    var user:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        
        if let displayName = Auth.auth().currentUser?.displayName {
            sucessLabel.text = "歡迎 \(displayName) 登入成功"
        } else {
            sucessLabel.text = "登入成功"
        }        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func layout(_ sender: Any) {
        do {
           try Auth.auth().signOut()
            sucessAlert(title: "確定登出嗎？", message: "") {
                print("登出成功")
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        } catch {
           print(error)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
