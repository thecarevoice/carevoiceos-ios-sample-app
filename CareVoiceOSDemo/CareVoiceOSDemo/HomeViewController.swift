//
//  HomeViewController.swift
//  CareVoiceOSDemo
//
//  Created by way on 2025/9/28.
//

import UIKit
import CVWellness

class HomeViewController: ViewController {
    
    lazy var wellnessButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("WellnessHub", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(wellnessButtonClick(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var openOS3Button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Open OS3 App", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(openOS3CLick(sender:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(wellnessButton)
        wellnessButton.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(openOS3Button)
        openOS3Button.snp.makeConstraints { make in
            make.top.equalTo(wellnessButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func wellnessButtonClick(sender: UIButton) {
        let vc = CVWellness.getViewController(true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openOS3CLick(sender: UIButton) {
        let code_verifier = PKCEManager.shared.generateCodeVerifier()
        let code_challenge = PKCEManager.shared.generateCodeChallenge(from: code_verifier) ?? ""
        let state = PKCEManager.shared.generateState()
        let cvUserUniqueId = ProfileManager.shared.authRes?.cvUserUniqueId ?? ""
        
        let params = PKCEGenerateParam(redirectUri: "com.carevoiceos",
                                      cvUserUniqueId: cvUserUniqueId,
                                      codeChallenge: code_challenge,
                                      codeChallengeMethod: "S256",
                                      state: state)
        PKCEGenerateRequest.generateDeepLink(params: params) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.handleData(code_verifier: code_verifier, res: success)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func handleData(code_verifier: String, res: PKCEGenerateRes) {
        guard let deepLink = res.data?.deepLink, let authorizationCode = parseCode(urlString: deepLink) else {
            return
        }
        
        let urlString = "com.carevoiceos://login?code=\(authorizationCode)&code_verifier=\(code_verifier)"
        guard let url = URL(string: urlString) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func parseCode(urlString: String) -> String? {
        if let url = URL(string: urlString),
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems {
            let code = queryItems.first(where: { $0.name == "code" })?.value
            return code
        } else {
            return nil
        }
    }
}
