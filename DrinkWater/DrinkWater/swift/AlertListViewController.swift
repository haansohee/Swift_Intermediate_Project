//
//  AlertListViewController.swift
//  DrinkWater
//
//  Created by 한소희 on 2023/03/31.
//

import UIKit

class AlertListViewController: UITableViewController {
    var alerts: [Alert] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 만들어진 셀을 테이블 뷰에 레지스터 하기
        // (1) nibName 만들기
        let nibName = UINib(nibName: "AlertListCell", bundle: nil)
        // (2) tableView에 레지스터
        tableView.register(nibName, forCellReuseIdentifier: "AlertListCell")
        // 리스트에 표현되는 (3) alert 객체 만들기 -> Alert.swift
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        alerts = alertList()
    }
    
    @IBAction func addAlertButtonAction(_ sender: UIBarButtonItem) {
        guard let addAlertViewController = storyboard?.instantiateViewController(withIdentifier: "AddAlarmViewController") as? AddAlarmViewController else {return}
        addAlertViewController.pickedDate = {
            [weak self] date in
            guard let self = self else {return}
            
            var alertList = self.alertList()
            let newAlert = Alert(date: date, isOn: true)
            
            alertList.append(newAlert)
            alertList.sort {$0.date < $1.date}
            
            self.alerts = alertList
            UserDefaults.standard.set(try?PropertyListEncoder().encode(self.alerts), forKey: "alerts")
            self.tableView.reloadData()
        }
        
        self.present(addAlertViewController, animated: true, completion: nil)
    }
    
    func alertList() -> [Alert] {
        guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data, let alerts = try? PropertyListDecoder().decode([Alert].self, from: data) else {return []}
        return alerts
    }
}

// UITableView Datasource, Delegate
extension AlertListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alerts.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "물 마실 시간🚰"
            
        default :
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlertListCell", for: indexPath) as? AlertListCell else {return UITableViewCell()}
        
        cell.alertSwtich.isOn = alerts[indexPath.row].isOn
        cell.timeLabel.text = alerts[indexPath.row].time
        cell.meridiemLabel.text = alerts[indexPath.row].meridiem
        
        cell.alertSwtich.tag = indexPath.row
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.alerts.remove(at: indexPath.row)
            UserDefaults.standard.set(try?PropertyListEncoder().encode(self.alerts), forKey: "alerts")
            self.tableView.reloadData()
        return
        default:
            break
        }
    }
}
