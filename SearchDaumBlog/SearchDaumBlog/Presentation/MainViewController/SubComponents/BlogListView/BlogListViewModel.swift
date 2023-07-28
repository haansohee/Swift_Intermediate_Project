//
//  BlogListViewModel.swift
//  SearchDaumBlog
//
//  Created by 한소희 on 2023/07/28.
//

import RxSwift
import RxCocoa

struct BlogListViewModel {
    let filterViewModel = FilterViewModel()
    
    let blogCellData = PublishSubject<[BlogListCellData]>()
    let cellData: Driver<[BlogListCellData]>
    
    init() {
        self.cellData = blogCellData
            .asDriver(onErrorJustReturn: [])
    }
}
