//
//  ViewController.swift
//  Notice
//
//  Created by 한소희 on 2023/05/11.
//

import UIKit
import FirebaseRemoteConfig
import FirebaseAnalytics

class ViewController: UIViewController {
    
    var remoteConfig: RemoteConfig?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        remoteConfig = RemoteConfig.remoteConfig()
        
        let setting = RemoteConfigSettings()
        setting.minimumFetchInterval = 0  // 테스트를 위해서 새로운 값을 페치하는 interval을 최소화해서 최대한 자주 원격 구성에 있는 데이터들을 가져오게 할라고
        remoteConfig?.configSettings = setting
        
        remoteConfig?.setDefaults(fromPlist: "RemoteConfigDefaults")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getNotice()
    }
}

// Remote Config
extension ViewController {
    func getNotice() {
        guard let remoteConfig = remoteConfig else { return }
        
        remoteConfig.fetch {[weak self] status, _ in
            if status == .success {
                remoteConfig.activate(completion: nil)
            } else {
                print("(ERROR) Config Not Fetched")
            }
            
            guard let self = self else { return }
            
            if !self.isNoticeHidden(remoteConfig) { // 보여질 때만
                let noticeViewController = NoticeViewController(nibName: "NoticeViewController", bundle: nil)
                
                noticeViewController.modalPresentationStyle = .custom
                noticeViewController.modalTransitionStyle = .crossDissolve
                
                let title = (remoteConfig["title"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                let detail = (remoteConfig["detail"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                let date = (remoteConfig["date"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                
                noticeViewController.noticeContents = (title: title, detail: detail, date: date)
                self.present(noticeViewController, animated: true, completion: nil)
            } else {
                self.showEventAlert()
            }
            
        }
    }
    
    func isNoticeHidden(_ remoteConfig: RemoteConfig) -> Bool {
        return remoteConfig["isHidden"].boolValue
    }
}

// A/B  Testing
extension ViewController {
    func showEventAlert() {
        guard let remoteConfig = remoteConfig else { return }
        
        remoteConfig.fetch { [weak self] status, _ in
            if status == .success {
                remoteConfig.activate(completion: nil)
            } else {
                print("(ERROR Config not Fetched")
            }
            
            let message = remoteConfig["message"].stringValue ?? ""
            
            let confirmAction = UIAlertAction(title: "확인하기", style: .default) {_ in
                // 이벤트 로딩
                Analytics.logEvent("promotion_alert", parameters: nil)  // 컨펌액션(버튼)이 눌려질 때마다 Firebase가 이벤트를 기억하게 됨
            }
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            let alertController = UIAlertController(title: "깜짝이벤트", message: message, preferredStyle: .alert)
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            self?.present(alertController, animated: true, completion: nil)
        }
    }
}
