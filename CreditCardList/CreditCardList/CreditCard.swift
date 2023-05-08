//
//  CreditCard.swift
//  CreditCardList
//
//  Created by 한소희 on 2023/05/05.
//

import Foundation

struct CreditCard: Codable {
    let id: Int
    let rank: Int
    let name: String
    let cardImageURL: String
    let promotionDetail: PromotionDetail
    let isSelected: Bool?
}

struct PromotionDetail: Codable {
    let companyName: String
    let amount: Int
    let period: String
    let benefitDetail: String
    let benefitDate: String
    let benefitCondition: String
    let condition: String
}
