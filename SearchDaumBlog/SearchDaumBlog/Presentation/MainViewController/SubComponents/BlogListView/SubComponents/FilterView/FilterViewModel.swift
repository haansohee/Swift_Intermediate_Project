//
//  FilterViewModel.swift
//  SearchDaumBlog
//
//  Created by 한소희 on 2023/07/28.
//

import RxSwift
import RxCocoa

struct FilterViewModel {
    let sortButtonTapped = PublishRelay<Void>()
}
