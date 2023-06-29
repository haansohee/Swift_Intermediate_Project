//
//  UploadViewController.swift
//  InstagramApp
//
//  Created by 한소희 on 2023/06/28.
//

import UIKit
import SnapKit

final class UploadViewController: UIViewController {
    private let uploadImage: UIImage
    
    private let imageView = UIImageView()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 15.0)
        textView.text = "글을 입력하세요."
        textView.textColor = .secondaryLabel
        textView.delegate = self
        
        return textView
    }()
    
    init(uploadImage: UIImage) {
        self.uploadImage = uploadImage
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        setupNaivigationItem()
        setupLayout()
        imageView.image = uploadImage
    }
}

extension UploadViewController {
    private func setupNaivigationItem(){
        navigationItem.title = "새 게시물"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapLeftButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "공유",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapRightButton))
    }
    
    @objc private func didTapLeftButton() {
        dismiss(animated: true)
    }
    
    @objc private func didTapRightButton() {
        // TODO: 저장하기
        dismiss(animated: true)
    }
    
    private func setupLayout() {
        [imageView, textView].forEach { view.addSubview($0) }
        
        let imageViewInset: CGFloat = 16.0
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(imageViewInset)
            $0.leading.equalToSuperview().inset(imageViewInset)
            $0.width.equalTo(100.0)
            $0.height.equalTo(imageView.snp.width)
        }
        
        textView.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(imageViewInset)
            $0.trailing.equalToSuperview().inset(imageViewInset)
            $0.top.equalTo(imageView.snp.top)
            $0.bottom.equalTo(imageView.snp.bottom)
        }
    }
}

extension UploadViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .secondaryLabel else { return }
        
        textView.text = nil
        textView.textColor = .label
        
    }
}

