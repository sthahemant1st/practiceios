//
//  SimpleListViewController.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 02/03/2022.
//

import UIKit

class SimpleListViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List"
        configureCollectionView()
        configureDataSource()
    }

}

extension SimpleListViewController {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .grouped)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}

extension SimpleListViewController {
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Int> {
            cell, indexPath, itemIdentifier in
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.text = itemIdentifier.stringValue
            cell.contentConfiguration = contentConfig
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) {
            (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        //Initial Data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0...30), toSection: nil)
        dataSource.apply(snapshot)
    }
    
}

extension SimpleListViewController: UICollectionViewDelegate {
    
}
