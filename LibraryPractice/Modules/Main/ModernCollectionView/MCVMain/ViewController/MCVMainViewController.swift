//
//  MCVMainViewController.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 28/02/2022.
//

import UIKit

fileprivate enum Section {
    case main
}

fileprivate class OutlineItem: Hashable {
    
    let title: String
    let subItems: [OutlineItem]
    let outlineViewController: UIViewController.Type?
    
    init(
        title: String,
        subItems: [OutlineItem]  = [],
        outlineViewController: UIViewController.Type? = nil
    ) {
        self.title = title
        self.subItems = subItems
        self.outlineViewController = outlineViewController
    }
    
    static func == (lhs: OutlineItem, rhs: OutlineItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    private let identifier = UUID()
}

class MCVMainViewController: UIViewController {
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, OutlineItem>!
    private var collectionView: UICollectionView!
    
    private var menuItems: [OutlineItem] {
        return [
            OutlineItem(title: "Compositional Layout", subItems: [
                OutlineItem(title: "Getting Started", subItems: [
                    OutlineItem(title: "Grid",
                                outlineViewController: MCVMainViewController.self),
                    OutlineItem(title: "Inset Items Grid",
                                outlineViewController: MCVMainViewController.self),
                    OutlineItem(title: "Two Column Grid",
                                outlineViewController: MCVMainViewController.self),
                    OutlineItem(title: "Distinct Section",
                                outlineViewController: MCVMainViewController.self)
                ]),
                OutlineItem(title: "Advance Layout", subItems: [
                    OutlineItem(title: "Pinned Section Headers",
                                outlineViewController: MCVMainViewController.self),
                    OutlineItem(title: "Section Background Decoration",
                                outlineViewController: MCVMainViewController.self),
                    OutlineItem(title: "Orthogonal Section Behaviours",
                                outlineViewController: MCVMainViewController.self)
                ])
            ]),
            OutlineItem(title: "List", subItems: [
                OutlineItem(title: "Simple List",
                            outlineViewController: SimpleListViewController.self),
                OutlineItem(title: "Reoderable List",
                            outlineViewController: ReoderableListViewController.self),
                OutlineItem(title: "List Appearances",
                            outlineViewController: ListAppearancesViewController.self),
                OutlineItem(title: "List with custom cell",
                            outlineViewController: CustomCellListViewController.self)
                
            ]),
            OutlineItem(title: "Diffable Data Source", subItems: [
                OutlineItem(title: "Mountain Search",
                            outlineViewController: MCVMainViewController.self)
            ]),
            OutlineItem(title: "Cell Configuretion", subItems: [
                OutlineItem(title: "Custom Configuration",
                            outlineViewController: MCVMainViewController.self)
            ])
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Modern Collection View"
        configureCollectionView()
        configureDataSource()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds,
                                              collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
    }

    private func configureDataSource() {
        let containerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, OutlineItem> { (cell, indexPath, menuItem) in
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = menuItem.title
            contentConfiguration.textProperties.font = .preferredFont(forTextStyle: .headline)
            cell.contentConfiguration = contentConfiguration

            let disclosureOptions = UICellAccessory.OutlineDisclosureOptions(style: .header)
            cell.accessories = [ .outlineDisclosure(displayed: .always,
                                                    options: disclosureOptions,
                                                    actionHandler: nil)]
            cell.backgroundConfiguration = .clear()

        }

        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, OutlineItem> {
            cell, indexPath, menuItem in
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = menuItem.title
            cell.contentConfiguration = contentConfiguration
            cell.backgroundConfiguration = .clear()
        }

        dataSource = UICollectionViewDiffableDataSource<Section, OutlineItem>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: OutlineItem) -> UICollectionViewCell? in
            // Return the cell.
            if item.subItems.isEmpty {
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: containerCellRegistration, for: indexPath, item: item)
            }
        }

        let snapshot = initialSnapshot()
        dataSource.apply(snapshot, to: .main)
        
    }
    
    private func initialSnapshot() -> NSDiffableDataSourceSectionSnapshot<OutlineItem> {
        var snapshot = NSDiffableDataSourceSectionSnapshot<OutlineItem>()
        
        func addItems(_ menuItems: [OutlineItem], to parent: OutlineItem?) {
            snapshot.append(menuItems, to: parent)
            for menuItem in menuItems where !menuItem.subItems.isEmpty {
                addItems(menuItem.subItems, to: menuItem)
            }
        }
        
        addItems(menuItems, to: nil)
        return snapshot
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        let layout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        return layout
    }

}

extension MCVMainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let menuItem = self.dataSource.itemIdentifier(for: indexPath) else { return }

        collectionView.deselectItem(at: indexPath, animated: true)

        if let viewController = menuItem.outlineViewController {
            navigationController?.pushViewController(viewController.init(), animated: true)
        }
    }
}
