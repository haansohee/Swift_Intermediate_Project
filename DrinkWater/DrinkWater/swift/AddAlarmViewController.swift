//
//  AddAlarmViewController.swift
//  DrinkWater
//
//  Created by 한소희 on 2023/03/31.
//

import UIKit

class AddAlarmViewController: UIViewController {
    // save버튼에는 dismiss뿐만 아니라 해당 화면에서 사용자들이 선택한 시간을 부모 뷰에 전달을 해 주어야 리스트에 표현이 될 것임. 저장 버튼을 누르면 선택한 시간이 부모뷰에 전달될 수 있도록.. 클로저를 사용해 보자
    var pickedDate: ((_ date: Date) -> Void)?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func dismissButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        pickedDate?(datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
    
}

