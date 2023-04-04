//
//  LoginViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 한소희 on 2023/04/05.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    override func viewDidLoad() {
        // 로그인 버튼 세 가지 다 동일한 형태의 테두리 ui를 줄 것임
        [emailLoginButton, googleLoginButton, appleLoginButton].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // LoginViewController는 첫 화면이므로 네비게이션 바가 필요 없지용. 숨기자!
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func googleLoginButtonTapped(_ sender: UIButton) {
        // Firebase 인증
    }
    
    @IBAction func appleLoginButtonTapped(_ sender: UIButton) {
        // Firebase 인증
    }
    
}
