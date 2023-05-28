//
//  ContentCollectionViewHeader.swift
//  NetflixStyleSampleApp
//
//  Created by 한소희 on 2023/05/27.
//

import UIKit

class ContentCollectionViewHeader: UICollectionReusableView {
    let sectionNameLabel = UILabel()
//    static var identifier = reuseIdentifier
    static var identifier: String {
        return String(describing: self)
    }
     
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sectionNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        sectionNameLabel.textColor = .white
        sectionNameLabel.sizeToFit()
        
        addSubview(sectionNameLabel)
        
        sectionNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.bottom.leading.equalToSuperview().offset(10)
        }
    }
}
