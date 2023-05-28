@_private(sourceFile: "HomeViewController.swift") import NetflixStyleSampleApp
import SwiftUI
import SwiftUI
import UIKit

extension HomeViewController_Previews.Container {
typealias Container = HomeViewController_Previews.Container
typealias UIViewContollerType = HomeViewController_Previews.Container.UIViewContollerType
private var previews: some View { return HomeViewController_Previews.previews }
private static var previews: some View { return HomeViewController_Previews.previews }

    @_dynamicReplacement(for: updateUIViewController(_:context:)) private func __preview__updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        #sourceLocation(file: "/Users/hansohee/Xcode/Intermediate_Project/NetflixStyleSampleApp/NetflixStyleSampleApp/HomeViewController.swift", line: 160)

#sourceLocation()
    }
}

extension HomeViewController_Previews {
    @_dynamicReplacement(for: previews) private static var __preview__previews: some View {
        #sourceLocation(file: "/Users/hansohee/Xcode/Intermediate_Project/NetflixStyleSampleApp/NetflixStyleSampleApp/HomeViewController.swift", line: 153)
        Container().edgesIgnoringSafeArea(.all)

    
#sourceLocation()
    }
}

extension HomeViewController {
    @_dynamicReplacement(for: collectionView(_:didSelectItemAt:)) private func __preview__collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        #sourceLocation(file: "/Users/hansohee/Xcode/Intermediate_Project/NetflixStyleSampleApp/NetflixStyleSampleApp/HomeViewController.swift", line: 145)
        let sectionName = contents[indexPath.section].sectionName
        print("(TEST) : \(sectionName) 섹션의 \(indexPath.row + __designTimeInteger("#2815.[3].[4].[1].arg[0].value.[3].value.arg[0].value.[0]", fallback: 1))번째 CONTENT!!!!~~~~~")
    
#sourceLocation()
    }
}

extension HomeViewController {
    @_dynamicReplacement(for: numberOfSections(in:)) private func __preview__numberOfSections(in collectionView: UICollectionView) -> Int {
        #sourceLocation(file: "/Users/hansohee/Xcode/Intermediate_Project/NetflixStyleSampleApp/NetflixStyleSampleApp/HomeViewController.swift", line: 140)
        return contents.count
    
#sourceLocation()
    }
}

extension HomeViewController {
    @_dynamicReplacement(for: collectionView(_:viewForSupplementaryElementOfKind:at:)) private func __preview__collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        #sourceLocation(file: "/Users/hansohee/Xcode/Intermediate_Project/NetflixStyleSampleApp/NetflixStyleSampleApp/HomeViewController.swift", line: 129)
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ContentCollectionViewHeader.identifier, for: indexPath) as? ContentCollectionViewHeader else { fatalError("Cloud not dequeue Header") }
            headerView.sectionNameLabel.text = contents[indexPath.section].sectionName
            return headerView
        } else {
            return UICollectionReusableView()
        }
    
#sourceLocation()
    }
}

extension HomeViewController {
    @_dynamicReplacement(for: collectionView(_:cellForItemAt:)) private func __preview__collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        #sourceLocation(file: "/Users/hansohee/Xcode/Intermediate_Project/NetflixStyleSampleApp/NetflixStyleSampleApp/HomeViewController.swift", line: 114)
        switch contents[indexPath.section].sectionType {
        case .basic, .large:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.identifier, for: indexPath) as?
                    ContentCollectionViewCell else { return UICollectionViewCell() }
            
            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image
            return cell
            
        default:
            return UICollectionViewCell()
        }
    
#sourceLocation()
    }
}

extension HomeViewController {
    @_dynamicReplacement(for: collectionView(_:numberOfItemsInSection:)) private func __preview__collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        #sourceLocation(file: "/Users/hansohee/Xcode/Intermediate_Project/NetflixStyleSampleApp/NetflixStyleSampleApp/HomeViewController.swift", line: 100)
        if contents[section].sectionType == .basic {
            switch section {
            case 0:
                return __designTimeInteger("#2815.[3].[0].[0].[0].[0].[0].[0]", fallback: 1)
                
            default:
                return contents[section].contentItem.count
            }
        }
        return __designTimeInteger("#2815.[3].[0].[1]", fallback: 0)
    
#sourceLocation()
    }
}

extension HomeViewController {
    @_dynamicReplacement(for: createSectionHeader()) private func __preview__createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        #sourceLocation(file: "/Users/hansohee/Xcode/Intermediate_Project/NetflixStyleSampleApp/NetflixStyleSampleApp/HomeViewController.swift", line: 86)
        // section header 사이즈 만들어주기
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(__designTimeInteger("#2815.[2].[5].[0].value.arg[0].value.arg[0].value", fallback: 1)), heightDimension: .absolute(__designTimeInteger("#2815.[2].[5].[0].value.arg[1].value.arg[0].value", fallback: 30)))
        
        // 위의 사이즈를 갖는 Section Header의 Layout 만들어주기
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return sectionHeader
    
#sourceLocation()
    }
}

extension HomeViewController {
    @_dynamicReplacement(for: createBasicTypeSection()) private func __preview__createBasicTypeSection() -> NSCollectionLayoutSection {
        #sourceLocation(file: "/Users/hansohee/Xcode/Intermediate_Project/NetflixStyleSampleApp/NetflixStyleSampleApp/HomeViewController.swift", line: 64)
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(__designTimeFloat("#2815.[2].[4].[0].value.arg[0].value.arg[0].value", fallback: 0.3)), heightDimension: .fractionalHeight(__designTimeFloat("#2815.[2].[4].[0].value.arg[1].value.arg[0].value", fallback: 0.75)))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: __designTimeInteger("#2815.[2].[4].[2].[0]", fallback: 10), leading: __designTimeInteger("#2815.[2].[4].[2].[1]", fallback: 5), bottom: __designTimeInteger("#2815.[2].[4].[2].[2]", fallback: 0), trailing: __designTimeInteger("#2815.[2].[4].[2].[3]", fallback: 5))
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(__designTimeFloat("#2815.[2].[4].[3].value.arg[0].value.arg[0].value", fallback: 0.9)), heightDimension: .estimated(__designTimeInteger("#2815.[2].[4].[3].value.arg[1].value.arg[0].value", fallback: 200)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: __designTimeInteger("#2815.[2].[4].[4].value.arg[2].value", fallback: 3))

        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: __designTimeInteger("#2815.[2].[4].[7].[0]", fallback: 0), leading: __designTimeInteger("#2815.[2].[4].[7].[1]", fallback: 5), bottom: __designTimeInteger("#2815.[2].[4].[7].[2]", fallback: 0), trailing: __designTimeInteger("#2815.[2].[4].[7].[3]", fallback: 5))
        
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    
#sourceLocation()
    }
}

extension HomeViewController {
    @_dynamicReplacement(for: layout()) private func __preview__layout() -> UICollectionViewLayout {
        #sourceLocation(file: "/Users/hansohee/Xcode/Intermediate_Project/NetflixStyleSampleApp/NetflixStyleSampleApp/HomeViewController.swift", line: 50)
        return UICollectionViewCompositionalLayout { [weak self] sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            
            switch self.contents[sectionNumber].sectionType {
            case .basic:
                return self.createBasicTypeSection()
                
            default:
                return nil
            }
        }
    
#sourceLocation()
    }
}

extension HomeViewController {
    @_dynamicReplacement(for: getContents()) private func __preview__getContents() -> [Content] {
        #sourceLocation(file: "/Users/hansohee/Xcode/Intermediate_Project/NetflixStyleSampleApp/NetflixStyleSampleApp/HomeViewController.swift", line: 41)
        guard let path = Bundle.main.path(forResource: "Content", ofType: "plist"),
              let data = FileManager.default.contents(atPath: path),
              let list = try? PropertyListDecoder().decode([Content].self, from: data) else { return [] }
        
        return list
    
#sourceLocation()
    }
}

extension HomeViewController {
    @_dynamicReplacement(for: viewDidLoad()) private func __preview__viewDidLoad() {
        #sourceLocation(file: "/Users/hansohee/Xcode/Intermediate_Project/NetflixStyleSampleApp/NetflixStyleSampleApp/HomeViewController.swift", line: 16)
        super.viewDidLoad()
        
        // Navigation 설정
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.hidesBarsOnSwipe = true
        
        // 버튼 추가
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(imageLiteralResourceName: __designTimeString("#2815.[2].[1].[5].[0]", fallback: "netflix_icon")), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: __designTimeString("#2815.[2].[1].[6].[0]", fallback: "person.crop.circle")), style: .plain, target: nil, action: nil)
    
        // Data 가져오기
        contents = getContents()
        
        
        // CollectionView Item(Cell) 설정
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.identifier)
        collectionView.register(ContentCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ContentCollectionViewHeader.identifier)
        collectionView.collectionViewLayout = layout()
        
        
    
#sourceLocation()
    }
}

import class NetflixStyleSampleApp.HomeViewController
import struct NetflixStyleSampleApp.HomeViewController_Previews

