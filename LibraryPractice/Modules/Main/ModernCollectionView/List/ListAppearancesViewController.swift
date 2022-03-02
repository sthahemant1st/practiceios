//
//  ListAppearancesViewController.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 02/03/2022.
//

import UIKit

class ListAppearancesViewController: UIViewController {
    
    private struct Item: Hashable {
        let title: String?
        private let identifier = UUID()
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, Item>!
    private var collectionView: UICollectionView!

    var appearance = UICollectionLayoutListConfiguration.Appearance.plain
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List Appearences"
        configureCollectionView()
        configureDataSource()
        updateBarButtonItem()
    }
    
    @objc
    private func changeListAppearance() {
        switch appearance {
        case .plain:
            appearance = .sidebarPlain
        case .sidebarPlain:
            appearance = .sidebar
        case .sidebar:
            appearance = .grouped
        case .grouped:
            appearance = .insetGrouped
        case .insetGrouped:
            appearance = .plain
        default:
            break
        }
//        let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first
        dataSource.apply(dataSource.snapshot(), animatingDifferences: true)
//        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
        updateBarButtonItem()
    }
    
    private func updateBarButtonItem() {
        var title: String? = nil
        switch appearance {
        case .plain: title = "Plain"
        case .sidebarPlain: title = "Sidebar Plain"
        case .sidebar: title = "Sidebar"
        case .grouped: title = "Grouped"
        case .insetGrouped: title = "Inset Grouped"
        default: break
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(changeListAppearance))
    }

}

extension ListAppearancesViewController {
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.delegate = self
//        collectionView.
        view.addSubview(collectionView)
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [unowned self] (section, layoutEnviroment) in
            var listConfig = UICollectionLayoutListConfiguration(appearance: self.appearance)
            listConfig.headerMode = .firstItemInSection
            return NSCollectionLayoutSection.list(using: listConfig, layoutEnvironment: layoutEnviroment)
        }
        
    }
    
    private func configureDataSource() {
        
        let headerRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> {
            cell, indexPath, itemIdentifier in
            var cellConfig = cell.defaultContentConfiguration()
            cellConfig.text = itemIdentifier.title
            cell.contentConfiguration = cellConfig
            
            cell.accessories = [ .outlineDisclosure() ]
        }
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> {
            cell, indexPath, itemIdentifier in
            
            var config = cell.defaultContentConfiguration()
            config.text = itemIdentifier.title
            cell.contentConfiguration = config
            
            cell.accessories = [ .disclosureIndicator() ]
        }
        
        
        dataSource = UICollectionViewDiffableDataSource<Int, Item>(collectionView: collectionView) {
            (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell in
            if indexPath.item == 0 {
                return collectionView.dequeueConfiguredReusableCell(using: headerRegistration, for: indexPath, item: itemIdentifier)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            }
        }
        
        //initial Data:
        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
        let sections = Array(1...5)
        
        snapshot.appendSections(sections)
        dataSource.apply(snapshot, animatingDifferences: false)
        
        for section in sections {
            var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
            let headerItem = Item(title: "Section \(section)")
            sectionSnapshot.append([headerItem], to: nil)
            let items = Array(0...2).map { value in
                Item(title: "Item \(value)")
            }
            
            sectionSnapshot.append(items, to: headerItem)
            sectionSnapshot.expand([headerItem])
            dataSource.apply(sectionSnapshot, to: section)
        }
        
    }
}

extension ListAppearancesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print(indexPath.item.stringValue)
    }
}
