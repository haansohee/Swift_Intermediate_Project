//
//  Protocol.swift
//  Brewery
//
//  Created by 한소희 on 2023/05/29.
//

import UIKit

protocol IdentifierProtocol: AnyObject {
    static var identifier: String { get }
}

extension UITableViewCell: IdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
