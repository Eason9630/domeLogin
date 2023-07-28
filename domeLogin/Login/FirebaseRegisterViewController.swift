//
//  FirebaseRegisterViewController.swift
//  domeLogin
//
//  Created by 林祔利 on 2023/5/26.
//

import UIKit
import FirebaseAuth
import SnapKit

class FirebaseRegisterViewController: UIViewController {
    
    let anginPasswordTextField = UITextField()
    let passwordTextField = UITextField()
    let nameTextField = UITextField()
    let emailAccountTextField = UITextField()
    
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
        let AccountLabel = UILabel()
        AccountLabel.text = "帳號："
        AccountLabel.font = UIFont.systemFont(ofSize: 20)
        AccountLabel.textColor = .black
        view.addSubview(AccountLabel)
        AccountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        AccountLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.leading.equalTo(view.snp_leading).offset(30)
            make.width.equalTo(130)
            make.height.equalTo(30)
        }
        //輸入帳號
        emailAccountTextField.backgroundColor = UIColor.white
        emailAccountTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailAccountTextField)
        emailAccountTextField.snp.makeConstraints { make in
            make.top.equalTo(AccountLabel.snp_top)
            make.left.equalTo(AccountLabel.snp_right).offset(10)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        
        //密碼
        let passwordLabel = UILabel()
        passwordLabel.text = "密碼："
        passwordLabel.font = UIFont.systemFont(ofSize: 20)
        passwordLabel.textColor = .black
        view.addSubview(passwordLabel)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(AccountLabel.snp_bottom).offset(30)
            make.leading.equalTo(view.snp_leading).offset(30)
            make.width.equalTo(130)
            make.height.equalTo(30)
        }
        
        //輸入密碼
        passwordTextField.backgroundColor = UIColor.white
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp_top)
            make.left.equalTo(passwordLabel.snp_right).offset(10)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        
        //再密碼
        let againPasswordLabel = UILabel()
        againPasswordLabel.text = "確認密碼："
        againPasswordLabel.font = UIFont.systemFont(ofSize: 20)
        againPasswordLabel.textColor = .black
        view.addSubview(againPasswordLabel)
        againPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        againPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp_bottom).offset(30)
            make.leading.equalTo(view.snp_leading).offset(30)
            make.width.equalTo(130)
            make.height.equalTo(30)
        }
        //再輸入密碼
        anginPasswordTextField.backgroundColor = UIColor.white
        anginPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(anginPasswordTextField)
        anginPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(againPasswordLabel.snp_top)
            make.left.equalTo(againPasswordLabel.snp_right).offset(10)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        
        //姓名
        let nameLabel = UILabel()
        nameLabel.text = "暱稱："
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        nameLabel.textColor = .black
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(againPasswordLabel.snp_bottom).offset(30)
            make.leading.equalTo(view.snp_leading).offset(30)
            make.width.equalTo(130)
            make.height.equalTo(30)
        }
        //輸入姓名
        nameTextField.backgroundColor = UIColor.white
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp_top)
            make.left.equalTo(nameLabel.snp_right).offset(10)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        //註冊按鈕
        let registerButton = UIButton()
        registerButton.setTitle("註冊", for: .normal)
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        registerButton.backgroundColor = UIColor.systemBlue
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        registerButton.layer.cornerRadius = 8.0
        view.addSubview(registerButton)
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp_bottom).offset(70)
            make.leading.equalTo(view.snp_leading).offset(55)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
        //取消按鈕
        let cancelButton = UIButton()
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        cancelButton.backgroundColor = UIColor.systemBlue
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cancelButton.layer.cornerRadius = 8.0
        view.addSubview(cancelButton)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp_bottom).offset(70)
            make.leading.equalTo(registerButton.snp_leading).offset(200)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
        
        let remind = UILabel()
        remind.frame = CGRect(x: 30, y: 490, width: 300, height: 20)
        remind.text = "提醒："
        remind.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(remind)
        
        let remindOne = UILabel()
        remindOne.text = "1.信箱請輸入正確格式。"
        remindOne.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(remindOne)
        remindOne.snp.makeConstraints { make in
            make.top.equalTo(remind.snp_bottom).offset(20)
            make.leading.equalTo(view.snp_leading).offset(30)
            make.width.equalTo(remind.snp_width)
            make.height.equalTo(remind.snp_height)
        }
        
        let remindTwo = UILabel()
        remindTwo.text = "2.密碼最少8位數。"
        remindTwo.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(remindTwo)
        remindTwo.snp.makeConstraints { make in
            make.top.equalTo(remindOne.snp_bottom).offset(20)
            make.leading.equalTo(view.snp_leading).offset(30)
            make.width.equalTo(remindOne.snp_width)
            make.height.equalTo(remindOne.snp_height)
        }
        
        let remindThree = UILabel()
        remindThree.text = "3.密碼需要大小寫英文數字混合。"
        remindThree.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(remindThree)
        remindThree.snp.makeConstraints { make in
            make.top.equalTo(remindTwo.snp_bottom).offset(20)
            make.leading.equalTo(view.snp_leading).offset(30)
            make.width.equalTo(remindTwo.snp_width)
            make.height.equalTo(remindTwo.snp_height)
        }
        
        
        
    }
    
    @objc func cancel(){
        navigationController?.popViewController(animated: true)
    }
    


    @objc func register(_ sender: Any) {
        if emailAccountTextField.text == "" {
            failAlert(title: "錯誤", message: "信箱不得為空")
        }
        if passwordTextField.text == "" {
            failAlert(title: "錯誤", message: "密碼不得為空")
        }
        if  anginPasswordTextField.text != passwordTextField.text {
            failAlert(title: "錯誤", message: "兩次密碼不正確")
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
                    self.sucessAlert(title: "註冊", message: "完成") {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
}
