//
//  FirebaseRegisterViewController.swift
//  domeLogin
//
//  Created by 林祔利 on 2023/5/26.
//

import UIKit
import FirebaseAuth

class FirebaseRegisterViewController: UIViewController {

    @IBOutlet weak var anginPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailAccountTextField: UITextField!
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
    @IBAction func register(_ sender: Any) {
        if emailAccountTextField.text == "" {
            failAlert(title: "錯誤", message: "信箱不得為空")
        }
        
            
        if let email = emailAccountTextField.text,
           let password = passwordTextField.text,
           let name = nameTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                        
                 guard let user = result?.user,
                       error == nil else {
                     print(error?.localizedDescription)
                     return
                 }
                let profileChangeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                                    profileChangeRequest?.displayName = name
                                    profileChangeRequest?.commitChanges(completion: { error in
                                        guard error == nil else {
                                            print(error?.localizedDescription)
                                            return
                                        }
                                    })
                print(user.email, user.uid,user.displayName)
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
}
