//
//  EnterEmailViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 한소희 on 2023/04/05.
//

import UIKit

class EnterEmailViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        nextButton.layer.cornerRadius = 30
        
        // 이메일과 비밀번호를 작성하지 않았다면 nextButton은 비활성화 상태. (화면 첫 진입 시)
        nextButton.isEnabled = false
        
        // firebase 인증에 전달할 텍스트 값들을 받으려면 emailTextField와 passwordTextField에 입력된 텍스트 값 자체를 받아와야 함. 그럴라면 텍스트필드 델리게이트가 필요..
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // 처음 화면에 들어섰을 때 바로 이메일 텍스트필드에 커서가 자동적으로 위치하도록
        emailTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // LoginViewController에서 Navigation Bar를 Hidden으로 설정해 줬으니까 다시 보이게끔..
        navigationController?.navigationBar.backgroundColor = .white
    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
    }
}

extension EnterEmailViewController: UITextFieldDelegate {
    // 이메일/비밀번호 입력이 끝나고서 리턴 버튼을 눌렀을 때 키패드 내려가게끔 하는 델리게이트
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    // 이메일과 비밀번호에 입력한 값이 있는지 확인하고, "다음" 버튼을 다시 활성화해 주는 델리게이트
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        
        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
