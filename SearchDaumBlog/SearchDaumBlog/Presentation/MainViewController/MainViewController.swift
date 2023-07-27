//
//  MainViewController.swift
//  SearchDaumBlog
//
//  Created by 한소희 on 2023/07/25.
//

import RxSwift
import RxCocoa
import UIKit

class MainViewController: UIViewController {
    let disposeBag = DisposeBag()

    let searchBar = SearchBar()
    let listView = BlogListView()
    
    let alertActionTapped = PublishRelay<AlertAction>()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        let blogResult = searchBar.shouldLoadResult
            .flatMapLatest { query in
                SearchBlogNetwork().searchBlog(query: query)
            }
            .share()
        
        let blogValue = blogResult
            .compactMap { data -> DKBlog? in
                guard case .success(let value) = data else {
                    return nil
                }
                return value
            }
        
        let blogError = blogResult
            .compactMap { data -> String? in
                guard case .failure(let error) = data else {
                    return nil
                }
                return error.localizedDescription
            }
        
        // 네트워크를 통해 가져온 값을 cellData로 변환
        let cellData = blogValue
            .map { blog -> [BlogListCellData] in
                return blog.documents
                    .map { doc in
                        let thumnailURL = URL(string: doc.thumnail ?? "")
                        return BlogListCellData(
                            thumbnailURL: thumnailURL,
                            name: doc.name,
                            title: doc.title,
                            datetime: doc.datetime
                        )
                    }
            }

        
        // FilterView를 선택했을 때 나오는 AlertSheet를 선택했을 때 type
        let sortedType = alertActionTapped
            .filter {
                switch $0 {
                case .title, .datetime:
                    return true
                default:
                    return false
                }
            }
            .startWith(.title)
        
        // cellData를 MainViewController에서 BlogListView로
        // 가장 최신의 값을 묶어서 전달해 주기
        Observable.combineLatest(
            sortedType,
            cellData
        ) { type, data -> [BlogListCellData] in
            switch type {
            case .title:
                return data.sorted { $0.title ?? "" < $1.title ?? "" }
                
            case .datetime:
                return data.sorted { $0.datetime ?? Date() > $1.datetime ?? Date() }
                
            default:
                return data
            }
        }
        .bind(to: listView.cellData)
        .disposed(by: disposeBag)
        
        let alertSheetForSorting = listView.headerView.sortButtonTapped
            .map { _ -> Alert in
                return (title: nil, message: nil, actions: [.title, .datetime, .cancle], style: .actionSheet
                )
            }
        
        let alertForErrorMessage = blogError
            .map { message -> Alert in
                return (
                    title: "앗!",
                    message: "예상치 못한 오류가 발생했습니다. 잠시후 다시 시도해 주세요. \(message)",
                    actions: [.confirm],
                    style: .alert
                )
            }

        
        Observable
            .merge(
                alertSheetForSorting,
                alertForErrorMessage
            )
            .asSignal(onErrorSignalWith: .empty())
            .flatMapLatest { alert -> Signal<AlertAction> in
                let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: alert.style)
                return self.presentAlertController(alertController, actions: alert.actions)
            }
            .emit(to: alertActionTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        title = "다음 블로그 검색"
        view.backgroundColor = .white
    }
    
    private func layout() {
        [
            searchBar,
            listView
        ].forEach {
            view.addSubview($0)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        listView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// Alert
extension MainViewController {
    typealias Alert = (title: String?, message: String?, actions: [AlertAction], style: UIAlertController.Style
    )
    
    enum AlertAction: AlertACtionConvertible {
        case title, datetime, cancle
        case confirm
        
        var title: String {
            switch self {
            case .title:
                return "Title"
                
            case .datetime:
                return "Datetime"
                
            case .cancle:
                return "취소"
                
            case .confirm:
                return "확인"
            }
        }
        
        var style: UIAlertAction.Style {
            switch self {
            case .title, .datetime:
                return .default
                
            case .cancle, .confirm:
                return .cancel
            }
        }
    }
    
    func presentAlertController<Action: AlertACtionConvertible>(_ alertController: UIAlertController, actions: [Action]) -> Signal<Action> {
        if actions.isEmpty { return .empty() }
        
        return Observable
            .create { [weak self] observer in
                guard let self = self else { return Disposables.create() }
                for action in actions {
                    alertController.addAction(
                        UIAlertAction(
                            title: action.title,
                            style: action.style,
                            handler: {_ in
                                observer.onNext(action)
                                observer.onCompleted()
                            }
                        )
                    )
                }
                self.present(alertController, animated: true)
                
                return Disposables.create {
                    alertController.dismiss(animated: true, completion: nil)
                }
            }
            .asSignal(onErrorSignalWith: .empty())
    }
}
