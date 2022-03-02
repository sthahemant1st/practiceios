//
//  CustomCellListViewController.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 02/03/2022.
//

import UIKit

class CustomCellListViewController: UIViewController {
    
    private enum Section: Hashable {
        case main
    }

    struct Category: Hashable {
        let icon: UIImage?
        let name: String?
        
        static let music = Category(icon: UIImage(systemName: "music.mic"), name: "Music")
        static let transportation = Category(icon: UIImage(systemName: "car"), name: "Transportation")
        static let weather = Category(icon: UIImage(systemName: "cloud.rain"), name: "Weather")
    }

    struct Item: Hashable {
        let category: Category
        let image: UIImage?
        let title: String?
        let description: String?
        init(category: Category, imageName: String? = nil, title: String? = nil, description: String? = nil) {
            self.category = category
            if let systemName = imageName {
                self.image = UIImage(systemName: systemName)
            } else {
                self.image = nil
            }
            self.title = title
            self.description = description
        }
        private let identifier = UUID()
        
        static let all = [
            Item(category: .music, imageName: "headphones", title: "Headphones",
                 description: "A portable pair of earphones that are used to listen to music and other forms of audio."),
            Item(category: .music, imageName: "hifispeaker.fill", title: "Loudspeaker",
                 description: "A device used to reproduce sound by converting electrical impulses into audio waves."),
            Item(category: .transportation, imageName: "airplane", title: "Plane",
                 description: "A commercial airliner used for long distance travel."),
            Item(category: .transportation, imageName: "tram.fill", title: "Tram",
                 description: "A rob."),
            Item(category: .transportation, imageName: "car.fill", title: "Car",
                 description: "A personal vehicle with four wheels that is able to carry a small number of A personal vehicle with four wheels that is able to carry a small number of people."),
            Item(category: .weather, imageName: "hurricane", title: "Hurricane",
                 description: "A tropical cyclone in the Caribbean with violent wind."),
            Item(category: .weather, imageName: "tornado", title: "Tornado",
                 description: "A destructive vortex of swirling violent winds that advances beneath a large storm system."),
            Item(category: .weather, imageName: "tropicalstorm", title: "Tropical Storm",
                 description: "A localized, intense low-pressure system, forming over tropical oceans."),
            Item(category: .weather, imageName: "snow", title: "Snow",
                 description: "Atmospheric water vapor frozen into ice crystals falling in light flakes.")
        ]
    }

    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List with Custom Cell"
        configureCollectionView()
        configureDataSource()

    }

}

extension CustomCellListViewController {
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: getCollectionViewLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        collectionView.allowsSelection = false
        
        let bundle = Bundle(for: CustomCollectionViewCell.self)
        let nib = UINib(nibName: CustomCollectionViewCell.reuseIdentifier, bundle: bundle)
        collectionView.register(nib, forCellWithReuseIdentifier: CustomCollectionViewCell.reuseIdentifier)
    }
    
    private func getCollectionViewLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    private func configureDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) {
            collectionView, indexPath, itemIdentifier -> UICollectionViewCell in
            
            let cell: CustomCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
            cell.configure(with: itemIdentifier)
            return cell
        }
        
        //initial snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Item.all)
        dataSource.apply(snapshot)
        
    }
}
