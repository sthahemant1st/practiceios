//
//  DistinctSectionGridViewController.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 02/03/2022.
//

import UIKit

class DistinctSectionGridViewController: UIViewController {
    
    enum SectionKind: Int, CaseIterable {
        case list, grid3, grid5
        
        var columnCount: Int {
            switch self {
            case .list:
                return 1
            case .grid3:
                return 3
            case .grid5:
                return 5
            }
        }
    }
    
    var dataSource: UICollectionViewDiffableDataSource<SectionKind, Int>! = nil
    var collectionView: UICollectionView! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Distinct Sections"
        configureHierarchy()
        configureDataSource()
    }

}

extension DistinctSectionGridViewController {
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            guard let sectionLayoutKind = SectionKind(rawValue: sectionIndex) else { return nil }
            let columnCount = sectionLayoutKind.columnCount
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            
            let groupHeight = columnCount == 1 ?
                NSCollectionLayoutDimension.absolute(44) :
            NSCollectionLayoutDimension.fractionalWidth(CGFloat(1)/CGFloat(columnCount))
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitem: item,
                                                           count: columnCount)
            group.interItemSpacing = .fixed(10)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
            return section
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 10
        layout.configuration = config
        return layout
    }
    
    private func configureDataSource() {
        
        let listRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Int> {
            cell, indexPath, itemIdentifier in
            var config = cell.defaultContentConfiguration()
            config.text = itemIdentifier.stringValue
            cell.contentConfiguration = config
        }
        
        let gridRegistration = UICollectionView.CellRegistration<UICollectionViewCell, Int> {
            cell, indexPath, itemIdentifier in
            cell.backgroundColor = .blue
        }
        
        dataSource = UICollectionViewDiffableDataSource<SectionKind, Int>(collectionView: collectionView) {
            collectionView, indexPath, itemIdentifier -> UICollectionViewCell in
            
            return SectionKind(rawValue: indexPath.section) == .list ?
            collectionView.dequeueConfiguredReusableCell(using: listRegistration,
                                                         for: indexPath,
                                                         item: itemIdentifier):
            collectionView.dequeueConfiguredReusableCell(using: gridRegistration,
                                                         for: indexPath,
                                                         item: itemIdentifier)
            
        }
        
        //initial data
        let itemsPerSection = 8
        var snapshot = NSDiffableDataSourceSnapshot<SectionKind, Int>()
//        snapshot.appendSections(SectionKind.allCases)
        SectionKind.allCases.forEach {
            snapshot.appendSections([$0])
            let itemOffset = $0.rawValue * itemsPerSection
            let itemUpperbound = itemOffset + itemsPerSection
            snapshot.appendItems(Array(itemOffset..<itemUpperbound))
        }
        self.dataSource.apply(snapshot)
    }
}
