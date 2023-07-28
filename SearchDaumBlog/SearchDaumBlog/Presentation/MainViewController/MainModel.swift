//
//  MainModel.swift
//  SearchDaumBlog
//
//  Created by 한소희 on 2023/07/28.
//

import RxSwift
import Foundation


struct MainModel {
    let network = SearchBlogNetwork()
    
    func searchBlog(_ query: String) -> Single<Result<DKBlog, SearchNetworkError>> {
        return network.searchBlog(query: query)
    }
    
    func getBlogValue(_ result: Result<DKBlog, SearchNetworkError>) -> DKBlog? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func getBlogError(_ result: Result<DKBlog, SearchNetworkError>) -> String? {
           guard case .failure(let error) = result else {
               return nil
           }
           return error.localizedDescription
    }
    
    func getBlogListCellData(_ value: DKBlog) -> [BlogListCellData] {
        return value.documents
            .map {
                let thumnailURL = URL(string: $0.thumnail ?? "")
                return BlogListCellData(
                    thumbnailURL: thumnailURL,
                    name: $0.name,
                    title: $0.title,
                    datetime: $0.datetime
                )
            }
    }
    
    func sort(by type: MainViewController.AlertAction, of data: [BlogListCellData]) -> [BlogListCellData] {
        switch type {
        case .title:
            return data.sorted { $0.title ?? "" < $1.title ?? "" }
            
        case .datetime:
            return data.sorted { $0.datetime ?? Date() > $1.datetime ?? Date() }
            
        default:
            return data
        }
    }
}
