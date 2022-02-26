//
//  CAPracticeViewController.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 25/02/2022.
//

import UIKit

class CAPracticeViewController: UIViewController {
    weak var coordinator: MainCoordinator!
    
    var redView: UIView!
    let height: CGFloat = 140
    let width: CGFloat = 140
    var midx: CGFloat!
    var midy: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        midx = view.frame.midX
        midy = view.frame.midY
        configureRedView()
    }
    
    private func configureRedView() {
        redView = UIView(frame: CGRect(x: 0, y: midy - height / 2, width: 140, height: 140))
        redView.backgroundColor = .systemRed
        view.addSubview(redView)
    }

    // MARK: Actions
    @IBAction func onTransletClick(_ sender: Any) {
        translateView()
    }
    
    @IBAction func onResetForTranslateClick(_ sender: Any) {
        resetForTranslate()
    }
    
    @IBAction func onResetForScaleClick(_ sender: Any) {
        resetForScale()
    }
    
    @IBAction func onScaleClick(_ sender: Any) {
        scaleView()
    }
    
    @IBAction func onRotateClick(_ sender: Any) {
        rotateView()
    }
    
    @IBAction func onShakeClick(_ sender: Any) {
        shakeView()
    }
    
    // MARK: Functions
    private func resetForTranslate() {
        redView.layer.position = CGPoint(x: 70 , y: midy)
        resetScale()
    }
    
    private func translateView() {
        let animation = CABasicAnimation()
        animation.keyPath = "position.x"
        animation.fromValue = width/2
        animation.toValue = 300
        animation.duration = 1
        
        redView.layer.add(animation, forKey: nil)
        redView.layer.position = CGPoint(x: 300, y: midy)
    }
    
    private func resetForScale() {
        redView.layer.position = CGPoint(x: midx, y: midy)
        resetScale()
    }
    
    private func resetScale() {
        redView.layer.transform = CATransform3DMakeScale(1, 1, 1)
    }
    
    private func scaleView() {
        let animation = CABasicAnimation()
        animation.keyPath = "transform.scale"
        animation.fromValue = 1
        animation.toValue = 2
        animation.duration = 1
//        animation.autoreverses = true
//        animation.repeatCount = 2
//        animation.isRemovedOnCompletion = false
        animation.preferredFrameRateRange = CAFrameRateRange(minimum: 5, maximum: 10, __preferred: 8)
//        animation.fillMode = .both
        
        redView.layer.add(animation, forKey: "scale")
//        redView.layer.transform = CATransform3DMakeScale(2, 2, 1)
    }
    
    private func rotateView() {
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.z"
        animation.fromValue = 0
        animation.toValue = CGFloat.pi
        animation.duration = 1
        
        redView.layer.add(animation, forKey: "rotate")
    }
    
    private func shakeView() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [midx, midx + 10, midx - 10, midx + 10, midx]
        animation.keyTimes = [0, 0.16, 0.5, 0.86, 1]
        animation.duration = 0.5
        
//        animation.isAdditive = true
        redView.layer.add(animation, forKey: "shake")
    }
}
