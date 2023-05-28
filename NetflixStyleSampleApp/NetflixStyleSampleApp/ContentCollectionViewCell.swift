//
//  ContentCollectionViewCell.swift
//  NetflixStyleSampleApp
//
//  Created by 한소희 on 2023/05/27.
//

import UIKit
import SnapKit

class ContentCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    static var identifier = reuseIdentifier
    
    override func layoutSubviews() {
        super.layoutSubviews() 
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleToFill
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
