//
//  CardListViewController.swift
//  CreditCardList
//
//  Created by 한소희 on 2023/05/05.
//

import UIKit
import Kingfisher
import FirebaseDatabase
import FirebaseFirestoreSwift
import FirebaseFirestore

class CardListViewController: UITableViewController {
//    var ref: DatabaseReference!  // firebase realtime database
    var creditCardList: [CreditCard] = []
    var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UITableView Cell Register
        let nibName = UINib(nibName: "CardListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CardListCell")
        
        // 실시간 데이터 베이스 읽기
        
        //        ref = Database.database().reference()
        
        //        ref.observe(.value) { snapshot  in
        //            guard let value = snapshot.value as? [String: [String: Any]] else { return }
        //
        //            do {
        //                let jsonData = try JSONSerialization.data(withJSONObject: value)
        //                let cardData = try JSONDecoder().decode([String: CreditCard].self, from: jsonData)
        //                let cardList = Array(cardData.values)
        //                self.creditCardList = cardList.sorted { $0.rank < $1.rank }
        //
        //                // tableView reload
        //                // main thread의 해당 액션을 넣어주는 거라고 이해하자
        //                DispatchQueue.main.async {
        //                    self.tableView.reloadData()
        //                }
        //            } catch let error {
        //                print("Error JSON 파싱 과정에서 에러나썽 : \(error)")
        //            }
        //        }
        
        // firestore 읽기
        db.collection("CreditCardList").addSnapshotListener { snapshot, error in
            guard let document = snapshot?.documents else {
                print("error Firestore fetching document \(String(describing: error))")
                return
            }
            
            self.creditCardList = documents.compactMap { doc -> CreditCard? in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: doc.data(), options: [])
                    let creditCard = try JSONDecoder().decode(CreditCard.self, from: jsonData)
                    return creditCard
                } catch let error {
                    print("error json파싱 : \(error)")
                    return nil
                }
            }.sorted { $0.rank < $1.rank }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCardList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardListCell", for: indexPath) as? CardListCell else {return UITableViewCell()}
        
        cell.rankLabel.text = "\(creditCardList[indexPath.row].rank)위"
        cell.promotionLabel.text = "\(creditCardList[indexPath.row].promotionDetail.amount) 만원 증정"
        cell.cardNameLabel.text = "\(creditCardList[indexPath.row].name)"
        
        let imageURL = URL(string: creditCardList[indexPath.row].cardImageURL)
        cell.cardImageView.kf.setImage(with: imageURL)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 상세화면 전달
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailViewController = storyboard.instantiateViewController(identifier: "CardDetailViewController") as? CardDetailViewController else { return }
        
        detailViewController.promotionDetail = creditCardList[indexPath.row].promotionDetail
        self.show(detailViewController, sender: nil)
        
        // 실시간 데이터베이스 쓰기
        // Option1
//        let cardID = creditCardList[indexPath.row].id
//        ref.child("Item\(cardID)/isSelected").setValue(true)
        
        // Option2
//        ref.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value) {
//            [weak self] snapshot in
//            guard let self = self,
//                  let value = snapshot.value as? [String: [String: Any]],
//                  let key = value.keys.first else {return}
//
//            self.ref.child("\(key)/isSelected").setValue(true)
//        }
        
        // Firestore 쓰기
        // (1) 경로를 알고 있을 때
        let cardID = creditCardList[indexPath.row].id
        db.collection("CreditCardList").document("card\(cardID)").updateData(["isSelectd": true])
        
        // (2) 경로를 모르고 있을 때
        db.collection("CreditCardList").whereField("id", isEqualTo: cardID).getDocuments { snapshot, _ in
            guard let document = snapshot?.documents.first else {
                print("error Firestore fetching documnet")
                return
            }
            document.reference.updateData(["isSelected": true])
            
            
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // 실시간 데이터베이스 삭제
            // option1
//            let cardID = creditCardList[indexPath.row].id
//            ref.child("Item\(cardID)").removeValue()
            
            // option2
//            ref.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value) {
//                [weak self] snapshot in
//                guard let self = self,
//                      let value = snapshot.value as? [String: [String: Any]],
//                      let key = value.keys.first else { return }
//
//                self.ref.child(key).removeValue()
//            }
            
            // Firestore 삭제
            // (1) 경로 알 때
            let cardID = creditCardList[indexPath.row].id
            db.collection("CreditCardList").document("card\(cardID)").delete()
            
            // (2) 경로 모를 때
            db.collection("CreditCardList").whereField("id", isEqualTo: cardID).getDocuments { snapshot, _ in
                guard let document = snapshot?.documents.first else {
                    print("Error")
                    return
                }
                
                document.reference.delete()
            }
        }
    }
}
