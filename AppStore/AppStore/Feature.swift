//
//  Feature.swift
//  AppStore
//
//  Created by 한소희 on 2023/06/22.
//

import Foundation

struct Feature: Decodable {
    let type: String
    let appName: String
    let description: String
    let imageURL: String
}
