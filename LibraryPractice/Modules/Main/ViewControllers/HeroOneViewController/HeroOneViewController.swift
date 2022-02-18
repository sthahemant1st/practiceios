//
//  HeroOneViewController.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 16/02/2022.
//

import UIKit
import Hero

class HeroOneViewController: UIViewController {
    weak var coordinator: MainCoordinator!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "hero")
        imageView.heroID = AppConstants.HeroConstants.image
        titleLabel.heroID = AppConstants.HeroConstants.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableHero()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disableHero()
    }

    @IBAction func onImageClick(_ sender: Any) {
        
        let vc = self.storyboard!.instantiateViewController(withIdentifier: HeroTwoViewController.identifier) as! HeroTwoViewController
//        self.navigationController!.pushViewController(vc, animated: true)
        showHero(vc)
    }
}
