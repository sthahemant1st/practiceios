//
//  OrthogonalSectionBehaviourViewController.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 02/03/2022.
//

import UIKit

class OrthogonalSectionBehaviourViewController: UIViewController {
    
    enum SectionKind: Int, CaseIterable {
        case continuous, continuousGroupLeadindBoundary, paging, groupPaging, groupPagingCentered, none
        func orthogonalScrollingBehavior() -> UICollectionLayoutSectionOrthogonalScrollingBehavior {
            switch self {
            case .continuous:
                return .continuous
            case .continuousGroupLeadindBoundary:
                return .continuousGroupLeadingBoundary
            case .paging:
                return .paging
            case .groupPaging:
                return .groupPaging
            case .groupPagingCentered:
                return .groupPagingCentered
            case .none:
                return .none
            }
        }
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Int>! = nil
    var collectionView: UICollectionView! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
    }

}

extension OrthogonalSectionBehaviourViewController {
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        
    }
    
    private func createLayout() -> UICollectionViewLayout{
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20

        let layout = UICollectionViewCompositionalLayout(sectionProvider: {
            sectionIndex, layoutEnviroment in
            guard let sectionKind = SectionKind(rawValue: sectionIndex) else {
                fatalError()
            }

            let leadingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                                         heightDimension: .fractionalHeight(1.0))
            let leadingItem = NSCollectionLayoutItem(layoutSize: leadingItemSize)
//            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)

            let trailingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                          heightDimension: .fractionalHeight(0.3))
            let trailingItem = NSCollectionLayoutItem(layoutSize: trailingItemSize)

            let trailingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                                           heightDimension: .fractionalHeight(1.0))
            let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: trailingGroupSize,
                                                                 subitem: trailingItem,
                                                                 count: 2)
//            trailingGroup.interItemSpacing = .fixed(10)

            let orthogonallyScrolls = sectionKind.orthogonalScrollingBehavior()
            let containerGroupFractionalWidth = orthogonallyScrolls != .none ? CGFloat(0.85) : CGFloat(1.0)
            let containerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(containerGroupFractionalWidth),
                                                            heightDimension: .fractionalHeight(0.4))
            let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: containerGroupSize,
                                                                    subitems: [leadingItem, trailingGroup])

            let section = NSCollectionLayoutSection(group: containerGroup)
            section.orthogonalScrollingBehavior = orthogonallyScrolls
//            section.interGroupSpacing = 10
//            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)

            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1.0),
                                                    heightDimension: .estimated(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)

            section.boundarySupplementaryItems = [sectionHeader]
            return section

        }, configuration: config)
        return layout

//        let layout = UICollectionViewCompositionalLayout(sectionProvider: {
//            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
//            guard let sectionKind = SectionKind(rawValue: sectionIndex) else { fatalError("unknown section kind") }
//
//            let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1.0)))
////            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//
//            let trailingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3)))
////            trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//            let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0)),
//                                                                 subitem: trailingItem,
//                                                                 count: 2)
//
//            let orthogonallyScrolls = sectionKind.orthogonalScrollingBehavior() != .none
//            let containerGroupFractionalWidth = orthogonallyScrolls ? CGFloat(0.85) : CGFloat(1.0)
//            let containerGroup = NSCollectionLayoutGroup.horizontal(
//                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(containerGroupFractionalWidth),
//                                                  heightDimension: .fractionalHeight(0.4)),
//                subitems: [leadingItem, trailingGroup])
//            let section = NSCollectionLayoutSection(group: containerGroup)
//            section.orthogonalScrollingBehavior = sectionKind.orthogonalScrollingBehavior()
//
//            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
//                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                  heightDimension: .estimated(44)),
//                elementKind: UICollectionView.elementKindSectionHeader,
//                alignment: .top)
//            section.boundarySupplementaryItems = [sectionHeader]
//            return section
//
//        }, configuration: config)
//        return layout
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<TextCell, Int> { (cell, indexPath, identifier) in
            // Populate the cell with our item description.
            cell.label.text = "\(indexPath.section), \(indexPath.item)"
            cell.contentView.backgroundColor = .blue
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.borderWidth = 1
            cell.contentView.layer.cornerRadius = 8
            cell.label.textAlignment = .center
            cell.label.font = UIFont.preferredFont(forTextStyle: .title1)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            // Return the cell.
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration
        <UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader) {
            (supplementaryView, string, indexPath) in
            let sectionKind = SectionKind(rawValue: indexPath.section)!
            var config = supplementaryView.defaultContentConfiguration()
            config.text = String(describing: sectionKind)
            supplementaryView.contentConfiguration = config
//            supplementaryView.label.text = "." + String(describing: sectionKind)
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }
        
        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        var identifierOffset = 0
        let itemsPerSection = 50
        SectionKind.allCases.forEach {
            snapshot.appendSections([$0.rawValue])
            let maxIdentifier = identifierOffset + itemsPerSection
            snapshot.appendItems(Array(identifierOffset..<maxIdentifier))
            identifierOffset += itemsPerSection
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
    
