//
//  ReuseableProtocl.swift
//  NetflixStyleSampleApp
//
//  Created by 한소희 on 2023/05/27.
//

import UIKit

protocol ReuseableProtocol: AnyObject {
    static var reuseIdentifier: String { get }
}

extension UICollectionViewCell: ReuseableProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
