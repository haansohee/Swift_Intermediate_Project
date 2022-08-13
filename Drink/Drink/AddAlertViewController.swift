//
//  AddAlertViewController.swift
//  Drink
//
//  Created by 한소희 on 2022/08/13.
//

import UIKit

class AddAlertViewController: UIViewController {
    
    var pickedDate: ((_ date: Date) -> Void)?

    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

   
    }

    @IBAction func dimissButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        // 해당 화면에서 우리가 선택한 데이터피커에 있는 시간을 부모 뷰에게 전달. 그래야 리스트에 표시될 것임
        // 선택한 시간이 부모 뷰에 전달되게 구현
        pickedDate?(datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
}
