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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(wellnessButton)
        wellnessButton.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func wellnessButtonClick(sender: UIButton) {
        let vc = CVWellness.getViewController(true)
        navigationController?.pushViewController(vc, animated: true)
    }
}
