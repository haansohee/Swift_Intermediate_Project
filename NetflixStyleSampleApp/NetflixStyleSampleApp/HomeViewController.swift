//
//  HomeViewController.swift
//  NetflixStyleSampleApp
//
//  Created by 한소희 on 2023/05/27.
//

import UIKit
import SwiftUI

class HomeViewController: UICollectionViewController {
    
    var contents: [Content] = []
    var mainItem: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation 설정
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.hidesBarsOnSwipe = true
        
        // 버튼 추가
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "netflix_icon"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: nil, action: nil)
    
        // Data 가져오기
        contents = getContents()
        mainItem = contents.first?.contentItem.randomElement()
        
        
        // CollectionView Item(Cell) 설정
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.identifier)
        collectionView.register(ContentCollectionViewRankCell.self, forCellWithReuseIdentifier: ContentCollectionViewRankCell.identifier)
        collectionView.register(ContentCollectionViewMainCell.self, forCellWithReuseIdentifier: ContentCollectionViewMainCell.identifier)
        collectionView.register(ContentCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ContentCollectionViewHeader.identifier)
        
        collectionView.collectionViewLayout = layout()
        
        collectionView.backgroundColor = .black
        
    }
    
    func getContents() -> [Content] {
        guard let path = Bundle.main.path(forResource: "Content", ofType: "plist"),
              let data = FileManager.default.contents(atPath: path),
              let list = try? PropertyListDecoder().decode([Content].self, from: data) else { return [] }
        
        return list
    }
    
    // 각각의 섹션 타입에 대한 UICollectionViewLayout 생성
    private func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            
            switch self.contents[sectionNumber].sectionType {
            case .basic:
                return self.createBasicTypeSection()
                
            case .large:
                return self.createLargeTypeSection()
                
            case .rank:
                return self.createRankTypeSection()
                
            case .main:
                return self.createMainTypeSection()
                
            default:
                return nil
            }
        }
    }
    
    private func createBasicTypeSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)

        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    // 큰 화면 Section Layout 설정
    private func createLargeTypeSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)  // 그룹 사이즈 다르게 할 거니까 Item 사이즈는 basic과 똑같이
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(400))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        return section
        
        // createBaisc과 같ㅈ;만!!!!.. 그룹의 크기와 설정만 다르게 한 것..ㅎ
    }
    
    // 순위(Rank) 표시 Layout 설정
    private func createRankTypeSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalWidth(0.9))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        return section
        
    }
    
    // Main Section에 대한 layout
    private func createMainTypeSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(450))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        
        return section
    }
    
    // Section Header 레이아웃 설정
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        // section header 사이즈 만들어주기
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        
        // 위의 사이즈를 갖는 Section Header의 Layout 만들어주기
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return sectionHeader
    }
}

// UICollectionView DataSource, Delegate
extension HomeViewController {
    // 섹션 당 보여질 셀 개수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         
        switch section {
        case 0:
            return 1
            
        default:
            return contents[section].contentItem.count
        }
        
        
    }
    
    // CollectionView Cell 설정
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch contents[indexPath.section].sectionType {
        case .basic, .large:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.identifier, for: indexPath) as?
                    ContentCollectionViewCell else { return UICollectionViewCell() }
            
            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image
            return cell
            
        case .rank:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewRankCell.identifier, for: indexPath) as? ContentCollectionViewRankCell else { return UICollectionViewCell() }
            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image
            cell.rankLabel.text = String(describing: indexPath.row + 1)
            return cell
            
        case .main:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewMainCell.identifier, for: indexPath) as? ContentCollectionViewMainCell else { return UICollectionViewCell() }
            cell.imageView.image = mainItem?.image
            cell.descriptionLabel.text = mainItem?.description
            
            return cell
                    
            
//        default:
//            return UICollectionViewCell()
        }
    }
    
    // HeaderView 설정
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ContentCollectionViewHeader.identifier, for: indexPath) as? ContentCollectionViewHeader else { fatalError("Cloud not dequeue Header") }
            headerView.sectionNameLabel.text = contents[indexPath.section].sectionName
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
    // Section 개수 설정
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return contents.count
    }
    
    // 셀 선택
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionName = contents[indexPath.section].sectionName
        print("(TEST) : \(sectionName) 섹션의 \(indexPath.row + 1)번째 CONTENT!!!!~~~~~")
    }
}

// SwiftUI를 활용한 미리 보기
//struct HomeViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        Container().edgesIgnoringSafeArea(.all)
//
//    }
//
//
//    struct Container: UIViewControllerRepresentable {
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        }
//
//        func makeUIViewController(context: Context) -> some UIViewController {
//            let layout = UICollectionViewLayout()
//            let homeViewController = HomeViewController(collectionViewLayout: layout)
//
//            return UINavigationController(rootViewController: homeViewController)
//        }
//
//        typealias UIViewContollerType = UIViewController
//    }
//}
