//
//  LoginViewController.swift
//  CareVoiceOSDemo
//
//  Created by way on 2025/9/28.
//

import UIKit
import SnapKit
import SVProgressHUD

class LoginViewController: ViewController {
    
    lazy var emailField: UITextField = {
        let view = UITextField()
        view.placeholder = "Email"
        view.backgroundColor = UIColor.systemGray6
        view.layer.cornerRadius = 10
        view.keyboardType = .emailAddress
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        view.leftViewMode = .always
        return view
    }()
    
    lazy var psdField: UITextField = {
        let view = UITextField()
        view.placeholder = "Password"
        view.backgroundColor = UIColor.systemGray6
        view.layer.cornerRadius = 10
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        view.leftViewMode = .always
        view.isSecureTextEntry = true // 设置为密码类型
        return view
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(loginClick(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var signupButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Signup", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(signupClick(sender:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(emailField)
        view.addSubview(psdField)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.left.equalTo(35)
            make.right.equalTo(-35)
            make.height.equalTo(48)
        }
        
        psdField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(20)
            make.left.equalTo(35)
            make.right.equalTo(-35)
            make.height.equalTo(48)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(psdField.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func loginClick(sender: UIButton) {
        guard let email = emailField.text, let password = psdField.text else { return }
        SVProgressHUD.show()
        AuthService.login(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    ProfileManager.shared.authRes = response.data?.sdk
                    self?.loginSuccess()
                }
            case .failure(let error):
                SVProgressHUD.dismiss()
                print("login failed: \(error)")
            }
        }
    }
    
    @objc func signupClick(sender: UIButton) {
        let vc = SignupViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func loginSuccess() {
        AuthService.initSDK { [weak self] success in
            SVProgressHUD.dismiss()
            self?.setupHome()
        }
    }
    
    func setupHome() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.navigateToHome()
        }
    }
}
