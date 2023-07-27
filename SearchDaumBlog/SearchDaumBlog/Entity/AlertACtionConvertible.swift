//
//  AlertACtionConvertible.swift
//  SearchDaumBlog
//
//  Created by 한소희 on 2023/07/26.
//

import UIKit

protocol AlertACtionConvertible {
    var title: String { get }
    var style: UIAlertAction.Style { get }
}
