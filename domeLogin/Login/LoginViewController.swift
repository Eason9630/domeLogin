//
//  LoginViewController.swift
//  domeLogin
//
//  Created by 林祔利 on 2023/5/23.
//

import UIKit
import FacebookLogin
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailAccountTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let accessToken = AccessToken.current,
           !accessToken.isExpired {
            print("\(accessToken.userID) login")
        } else {
            print("not login")
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 在這裡設置 emailAccountTextField 的文字為空白
        emailAccountTextField.text = ""
        passwordTextField.text = ""
    }
    
    
    @IBAction func login(_ sender: Any) {
        let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile], viewController: self) { result in
            if case LoginResult.success(granted: _, declined: _, token: let token) = result {
                print("fb login ok")
                
                let credential =  FacebookAuthProvider.credential(withAccessToken: token!.tokenString)
                Auth.auth().signIn(with: credential) { [weak self] result, error in
                    guard let self else { return }
                    guard error == nil else {
                        print(error?.localizedDescription)
                        return
                    }
                    if let user = result?.user {
                       
                        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "\(FirebaseLoginViewController.self)") as? FirebaseLoginViewController else {return}
                        controller.user = user
                        
                        self.navigationController?.pushViewController(controller, animated: true)
                    }
                    print("login ok")
                }
                
            } else {
                print("login fail")
            }
        }
    }
    

    
    

    @IBAction func goLogin(_ sender: Any) {
        if emailAccountTextField.text == "" || passwordTextField.text == "" {
            failAlert(title: "錯誤", message: "帳號或密碼不能為空")
            return
        }
        if let emailAccount = emailAccountTextField.text,
           let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: emailAccount, password: password) { result, error in
                 guard error == nil else {
                    print(error?.localizedDescription)
                    self.failAlert(title: "錯誤", message: "帳號或密碼錯誤")
                    return
                 }
                if let user = result?.user{
                    guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "\(FirebaseLoginViewController.self)") as? FirebaseLoginViewController else {return}
                    controller.user = user
                    self.navigationController?.pushViewController(controller, animated: true)
                }
               print("success")
            }
        }
    }
    
    @IBAction func googleLogin(_ sender: Any) {
        //透過 guard let 取得clientID
        //指派 config 取得上面的clientID
        //透過GIDSignIn嘗試授權跳出頁面協助登入
        //登入成功跳轉頁面
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            if let user = user ,
               let idToken = user.authentication.idToken {
                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.authentication.accessToken)
                Auth.auth().signIn(with: credential) { result, error in
                    if let user = result?.user{
                        guard let controller = storyboard?.instantiateViewController(withIdentifier: "\(FirebaseLoginViewController.self)") as? FirebaseLoginViewController else {return}
                        controller.user = user
                        navigationController?.pushViewController(controller, animated: true)
                    }
                  
                }
                
            }

            
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
