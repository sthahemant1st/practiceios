//
//  LottieViewController.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 16/02/2022.
//

import UIKit
import Lottie

class LottieViewController: UIViewController {

    weak var coordinator: MainCoordinator!
    @IBOutlet weak var lottieView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lottie"
        
        lottieView.animation = Animation.named("lottieA")
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .loop
        lottieView.play(completion: nil)
    }

}
