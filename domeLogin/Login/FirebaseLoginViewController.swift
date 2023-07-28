//
//  FirebaseLoginViewController.swift
//  domeLogin
//
//  Created by 林祔利 on 2023/5/26.
//

import UIKit
import Firebase
import SnapKit

class FirebaseLoginViewController: UIViewController {

    let sucessLabel = UILabel()
    let layoutButton = UIButton()
    
    var user:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 設置視圖背景為圖片
        let backgroundImage = UIImage(named: "pic")
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = backgroundImage
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
        
        sucessLabel.font = UIFont.systemFont(ofSize: 20)
        sucessLabel.textAlignment = .left
        sucessLabel.textColor = .black
        view.addSubview(sucessLabel)
        sucessLabel.translatesAutoresizingMaskIntoConstraints = false
        sucessLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.leading.equalTo(view.snp_leading).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }

        layoutButton.setTitle("登出", for: .normal)
        layoutButton.addTarget(self, action: #selector(layout), for: .touchUpInside)
        
        layoutButton.backgroundColor = UIColor.white
        layoutButton.setTitleColor(.black, for: .normal)
        layoutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        layoutButton.layer.cornerRadius = 8.0
        layoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(layoutButton)
        
        layoutButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.leading.equalTo(view.snp_leading).offset(30)
            make.top.equalTo(sucessLabel.snp_bottom).offset(100)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        
        if let displayName = Auth.auth().currentUser?.displayName {
            sucessLabel.text = "歡迎 \(displayName) 登入成功"
        } else {
            sucessLabel.text = "登入成功"
        }        // Do any additional setup after loading the view.
        
    }
    
    @objc func layout(_ sender: Any) {
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
