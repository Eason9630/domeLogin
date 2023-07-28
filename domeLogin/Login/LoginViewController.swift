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
import SnapKit

class LoginViewController: UIViewController {

//    @IBOutlet weak var passwordTextField: UITextField!
//    @IBOutlet weak var emailAccountTextField: UITextField!
    let emailAccountTextField = UITextField()
    let passwordTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 設置視圖背景為圖片
        let backgroundImage = UIImage(named: "pic")
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = backgroundImage
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
        
       
        //帳號
        let Account = UILabel()
        Account.text = "帳號："
        Account.font = UIFont.systemFont(ofSize: 20)
        Account.textColor = .black
        view.addSubview(Account)
        Account.translatesAutoresizingMaskIntoConstraints = false
        
        Account.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(40)
            make.left.equalToSuperview().inset(30)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        //密碼
        let Password = UILabel()
        Password.text = "密碼："
        Password.font = UIFont.systemFont(ofSize: 20)
        Password.textColor = .black
        view.addSubview(Password)
        Password.translatesAutoresizingMaskIntoConstraints = false
        Password.snp.makeConstraints { make in
            make.top.equalTo(Account.snp_bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        //輸入帳號
        emailAccountTextField.backgroundColor = UIColor.white
        emailAccountTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailAccountTextField)
        emailAccountTextField.snp.makeConstraints { make in
            make.top.equalTo(Account.snp_top)
            make.left.equalTo(Account.snp_right).offset(10)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        //輸入密碼
        passwordTextField.backgroundColor = UIColor.white
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(Password.snp_top)
            make.left.equalTo(Password.snp_right).offset(10)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        
        //登入 Button
        let LoginButton = UIButton()
        LoginButton.setTitle("登入", for: .normal)
        LoginButton.addTarget(self, action: #selector(goLogin), for: .touchUpInside)
        
        LoginButton.backgroundColor = UIColor.orange
        LoginButton.setTitleColor(.white, for: .normal)
        LoginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        LoginButton.layer.cornerRadius = 8.0
        
        LoginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(LoginButton)
        
        LoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        LoginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 80).isActive = true
        LoginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        LoginButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        LoginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //註冊 Button
        let registerButton = UIButton()
        registerButton.setTitle("註冊", for: .normal)
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        registerButton.backgroundColor = UIColor.orange
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        registerButton.layer.cornerRadius = 8.0
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(registerButton)
        
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: LoginButton.bottomAnchor, constant: 30).isActive = true
        registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //Facebook 登入
        let faceBookButton = UIButton()
        faceBookButton.setTitle("FaceBook", for: .normal)
        faceBookButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        faceBookButton.backgroundColor = UIColor.systemBlue
        faceBookButton.setTitleColor(.white, for: .normal)
        faceBookButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        faceBookButton.layer.cornerRadius = 8.0
        faceBookButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(faceBookButton)
        
        faceBookButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        faceBookButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 30).isActive = true
        faceBookButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        faceBookButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        faceBookButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //Google 登入
        let googleButton = UIButton()
        googleButton.setTitle("Google", for: .normal)
        googleButton.addTarget(self, action: #selector(googleLogin), for: .touchUpInside)
        
        googleButton.backgroundColor = UIColor.white
        googleButton.setTitleColor(.black, for: .normal)
        googleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        googleButton.layer.cornerRadius = 8.0
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(googleButton)
        
        googleButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.leading.equalTo(view.snp_leading).offset(30)
            make.top.equalTo(faceBookButton.snp_bottom).offset(30)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        
        
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
    
    @objc func register() {
        let controller = FirebaseRegisterViewController()
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
    
    @objc func login(_ sender: Any) {
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
    

    
    

    @objc func goLogin(_ sender: Any) {
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
    
    @objc func googleLogin(_ sender: Any) {
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
