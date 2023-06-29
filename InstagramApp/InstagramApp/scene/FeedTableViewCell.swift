//
//  FeedTableViewCell.swift
//  InstagramApp
//
//  Created by 한소희 on 2023/06/26.
//

import UIKit
import SnapKit

final class FeedTableViewCell: UITableViewCell {
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tertiaryLabel
        
        return imageView
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(systemName: "heart")
        
        return button
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton()
        button.setImage(systemName: "message")
        
        return button
    }()
    
    private lazy var directMessageButton: UIButton = {
        let button = UIButton()
        button.setImage(systemName: "paperplane")
        
        return button
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(systemName: "bookmark")
        
        return button
    }()
    
    private lazy var currentLikedCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 13.0, weight: .semibold)
        label.text = "강준식 님 외 32명이 좋아합니다."
        
        return label
    }()
    
    private lazy var contentsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 13.0, weight: .medium)
        label.numberOfLines = 5
        label.text = "하늘이 갈라지고 노을이 비춰 들어오면, 저 멀리 배 한 척 다가와 살포시 뱃고동 읊조린다. 세상은 수평선 너머로 끊겼으며 나는 지금 양마른 나뭇가지에 기댄 채다. 아마 언젠가 아버지가 탄 배도 돌아오겠지 아니, 돌아올 일 없겠지. 애초에 돌아오지 않는 편이 더 마음 편할 길이다. 저 멀리 뱃고동 읊조리면 나는 오늘도 끊어진 세상을 바라본다."
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 11.0, weight: .medium)
        label.text = "1일 전"
        
        return label
    }()
    
    func setup() {
        [
            postImageView,
            likeButton,
            commentButton,
            directMessageButton,
            bookmarkButton,
            currentLikedCountLabel,
            contentsLabel,
            dateLabel
        ].forEach { addSubview($0) }
        
        postImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(postImageView.snp.width)
        }
        
        let buttonWidth: CGFloat = 24.0
        let buttonInset: CGFloat = 16.0
        
        likeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(buttonInset)
            $0.top.equalTo(postImageView.snp.bottom).offset(buttonInset)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }
        
        commentButton.snp.makeConstraints {
            $0.leading.equalTo(likeButton.snp.trailing).offset(12.0)
            $0.top.equalTo(likeButton.snp.top)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }
        
        directMessageButton.snp.makeConstraints {
            $0.leading.equalTo(commentButton.snp.trailing).offset(12.0)
            $0.top.equalTo(likeButton.snp.top)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(buttonInset)
            $0.top.equalTo(likeButton.snp.top)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }
        
        currentLikedCountLabel.snp.makeConstraints {
            $0.leading.equalTo(likeButton.snp.leading)
            $0.trailing.equalTo(bookmarkButton.snp.trailing)
            $0.top.equalTo(likeButton.snp.bottom).offset(14.0)
        }
        
        contentsLabel.snp.makeConstraints {
            $0.leading.equalTo(likeButton.snp.leading)
            $0.trailing.equalTo(bookmarkButton.snp.trailing)
            $0.top.equalTo(currentLikedCountLabel.snp.bottom).offset(8.0)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(likeButton.snp.leading)
            $0.trailing.equalTo(bookmarkButton.snp.trailing)
            $0.top.equalTo(contentsLabel.snp.bottom).offset(8.0)
            $0.bottom.equalToSuperview().inset(16.0)
        }
    }
    
}
