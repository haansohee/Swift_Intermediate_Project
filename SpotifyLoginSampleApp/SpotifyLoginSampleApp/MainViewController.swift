//
//  MainViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 한소희 on 2023/04/05.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 메인뷰에 진입을 했는데(로그인한 상황) 뒤로 갈 수 있는 navigate bar가 보인다등가.. 뒤로 갈 수 있는 스와이프가 있다등가..하면 어색하니까 막아주장..
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        // 해당 버튼을 누르면 RootViewController로 이동
        self.navigationController?.popToRootViewController(animated: true)
    }
}
