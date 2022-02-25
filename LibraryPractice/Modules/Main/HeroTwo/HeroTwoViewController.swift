//
//  HeroTwoViewController.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 16/02/2022.
//

import UIKit
import Hero

class HeroTwoViewController: UIViewController, UIGestureRecognizerDelegate {
    
    weak var coordinator: MainCoordinator!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    var titleText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "hero")
        titleLabel.text = titleText
        imageView.heroID = AppConstants.HeroConstants.image
        titleLabel.heroID = AppConstants.HeroConstants.title
        detailsLabel.heroModifiers = [ .translate(x: -view.frame.width + 16, y: view.frame.height / 2, z: 0)]

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableHero()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        navigationController?.popViewController(animated: true)
        return false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disableHero()
    }

    @IBAction func onImageViewSwipeDown(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
