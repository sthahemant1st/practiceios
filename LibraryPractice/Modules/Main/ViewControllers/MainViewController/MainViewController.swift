//
//  MainViewController.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 16/02/2022.
//

import UIKit

class MainViewController: UIViewController {
    
     weak var coordinator: MainCoordinator?
    
    private let mainItems = [
        MainItem(imageName: "empty",
                 title: "Empty Table View",
                 identifier: EmptyTableViewController.identifier),
        MainItem(imageName: "lottie",
                 title: "Lottie View",
                 identifier: LottieViewController.identifier),
        MainItem(imageName: "hero",
                 title: "Hero View",
                 identifier: HeroOneViewController.identifier),
        MainItem(imageName: "heroList",
                 title: "Hero List View",
                 identifier: HeroListViewController.identifier),
        MainItem(imageName: "note",
                 title: "Notes",
                 identifier: NotebookListViewController.identifier),
        MainItem(imageName: "biometric",
                 title: "Biometric Authentication",
                 identifier: BiometricPracticeViewController.identifier)
    ]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Practice Project"
        
        initCollectionView()
    }
    
    private func initCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.itemSize = CGSize(width: (self.view.frame.width - 8 * 3) / 2,
                                 height: (self.view.frame.width - 8 * 3) / 2 + 37 )
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        collectionView.collectionViewLayout = layout
        
        collectionView.register(UINib(nibName: MainCollectionViewCell.identifier, bundle: nil),
                                forCellWithReuseIdentifier: MainCollectionViewCell.identifier)

        collectionView.dataSource = self
        collectionView.delegate = self
        
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = mainItems[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier,
                                                      for: indexPath) as! MainCollectionViewCell
        cell.mainItem = item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = mainItems[indexPath.row]
        
        switch item.identifier {
        case EmptyTableViewController.identifier:
            coordinator?.showEmptyTableView()
        case LottieViewController.identifier:
            coordinator?.showLottieView()
        case HeroOneViewController.identifier:
            coordinator?.showHeroView()
        case HeroListViewController.identifier:
            coordinator?.showHeroListVC()
        case NotebookListViewController.identifier:
            coordinator?.showNoteVc()
        case BiometricPracticeViewController.identifier:
            coordinator?.showBiometricView()
        default:
            print("identifier not handled")
        }
    }
    
}

