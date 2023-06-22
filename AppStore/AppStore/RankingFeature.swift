//
//  RankingFeature.swift
//  AppStore
//
//  Created by 한소희 on 2023/06/22.
//

import Foundation

struct RankingFeature: Decodable {
    let title: String
    let description: String
    let isInPurchaseApp: Bool
}
