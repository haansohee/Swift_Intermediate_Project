//
//  ContentCollectionViewMainCell.swift
//  NetflixStyleSampleApp
//
//  Created by 한소희 on 2023/05/28.
//

import UIKit

class ContentCollectionViewMainCell: UICollectionViewCell {
    static var identifier = reuseIdentifier
    
    let baseStackView = UIStackView()
    let menuStackView = UIStackView()
    
    let tvButton = UIButton()
    let movieButton = UIButton()
    let categoryButton = UIButton()
    
    let imageView = UIImageView()
    let descriptionLabel = UILabel()
    let contentStackView = UIStackView()
    
    let plusButton = UIButton()
    let playButton = UIButton()
    let infoButton = UIButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [baseStackView, menuStackView].forEach {
            contentView.addSubview($0)
        }
        
        // baseStackView
        baseStackView.axis = .vertical
        baseStackView.alignment = .center
        baseStackView.distribution = .fillProportionally
        baseStackView.spacing = 5
        
        [imageView, descriptionLabel, contentStackView].forEach {
            baseStackView.addArrangedSubview($0)
        }
        
        baseStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // imageView
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints {
            $0.width.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }
        
        // descriptionLabel
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.textColor = .white
        descriptionLabel.sizeToFit()
        
        // content StackView
        contentStackView.axis = .horizontal
        contentStackView.alignment = .center
        contentStackView.distribution = .equalCentering
        contentStackView.spacing = 20
        
        // plus / info Button
        [plusButton, infoButton].forEach {
//            contentStackView.addArrangedSubview($0)
            $0.titleLabel?.font = .systemFont(ofSize: 13)
            $0.setTitleColor(.white, for: .normal)
            $0.imageView?.tintColor = .white
            $0.adjustVerticalLayout(5)
        }
        
        plusButton.setTitle("내가 찜한 콘텐츠", for: .normal)
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
        infoButton.setTitle("정보", for: .normal)
        infoButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        
//        contentStackView.addArrangedSubview(playButton)
        playButton.setTitle("▶️ 재생", for: .normal)
        playButton.setTitleColor(.black, for: .normal)
        playButton.backgroundColor = .white
        playButton.layer.cornerRadius = 3
        playButton.snp.makeConstraints {
            $0.width.equalTo(90)
            $0.height.equalTo(30)
        }
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        
        [plusButton, playButton, infoButton].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        contentStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(60)
        }
        
        // menuStackView
        menuStackView.axis = .horizontal
        menuStackView.alignment = .center
        menuStackView.distribution = .equalSpacing
        menuStackView.spacing = 20
        
        menuStackView.snp.makeConstraints {
            $0.top.equalTo(baseStackView)  // $0.top.equalTo(baseStackView.snp.top) 과 동일한 역할을 함
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        [tvButton, movieButton, categoryButton].forEach {
            menuStackView.addArrangedSubview($0)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 1
            $0.layer.shadowRadius = 3
        }
        
        tvButton.setTitle("TV 프로그램", for: .normal)
        movieButton.setTitle("영화", for: .normal)
        categoryButton.setTitle("카테고리 🔻", for: .normal)
        
        tvButton.addTarget(self, action: #selector(tvButtonTapped), for: .touchUpInside)
        movieButton.addTarget(self, action: #selector(movieButtonTapped), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
    }
    
    @objc func tvButtonTapped(sender: UIButton!) {
        print("(TEST) Click tvButton ")
    }
    
    @objc func movieButtonTapped(sender: UIButton!) {
        print("(TEST) Click movieButton ")
    }
    
    @objc func categoryButtonTapped(sender: UIButton!) {
        print("(TEST) Click categoryButton ")
    }
    
    @objc func plusButtonTapped(sender: UIButton!) {
        print("(TEST) Click plusButton ")
    }
    
    @objc func infoButtonTapped(sender: UIButton!) {
        print("(TEST) Click infoButton ")
    }
    
    @objc func playButtonTapped(sender: UIButton!) {
        print("(TEST) Click playButton ")
    }
}
