//
//  SearchBarViewModel.swift
//  SearchDaumBlog
//
//  Created by 한소희 on 2023/07/28.
//

import RxSwift
import RxCocoa

struct SearchBarViewModel {
    let queryText = PublishRelay<String?>()
    let shouldLoadResult: Observable<String>
    let searchButtonTapped = PublishRelay<Void>()
    
    init() {
        self.shouldLoadResult = searchButtonTapped
            .withLatestFrom(queryText) { $1 ?? "" }
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
    }
}
