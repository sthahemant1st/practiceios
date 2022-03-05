//
//  BottomSheetPracticeViewController.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 05/03/2022.
//

import UIKit
import FloatingPanel

class BottomSheetPracticeViewController: UIViewController, FloatingPanelControllerDelegate {
    var emptyFPC: FloatingPanelController!
    var lottieFPC: FloatingPanelController!
    var testFPC: FloatingPanelController!
    
    var shown = true

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bottom Sheet Practice"
        setupViews()
    }
    private func setupViews() {
        configureLottieFpc()
        configurEmptyFPC()
        configureTestFpc()
    }
    
    private func configureLottieFpc() {
        lottieFPC = FloatingPanelController()
        lottieFPC.layout = LottieFloatingPanelLayout()
        let lottieVC = ViewRepo.Main.getLottieViewController()
        lottieFPC.set(contentViewController: lottieVC)
        
        lottieFPC.addPanel(toParent: self)
        lottieFPC.hide()
    }
    
    private func configurEmptyFPC() {
        emptyFPC = FloatingPanelController()
        let emptyTableVC = ViewRepo.Main.getEmptyTableViewConroller()
        emptyFPC.set(contentViewController: emptyTableVC)
        emptyFPC.track(scrollView: emptyTableVC.tableView)
        
        emptyFPC.addPanel(toParent: self)
        emptyFPC.hide()
    }
    
    
    
    private func configureTestFpc() {
        testFPC = FloatingPanelController()
        testFPC.layout = TestFloatingPanelLayout()
        let testVC = TestFloatingPanelViewController.loadFromNib()
        testFPC.set(contentViewController: testVC)
        testFPC.addPanel(toParent: self)
        testFPC.hide()
    }
    

    @IBAction func buttonClicked(_ sender: Any) {
        hideAllFPC()
    }
    @IBAction func showLottie(_ sender: Any) {
        hideAllFPC()
        lottieFPC.show(animated: true, completion: nil)
    }
    
    @IBAction func showEmpty(_ sender: Any) {
        hideAllFPC()
        emptyFPC.show(animated: true, completion: nil)
    }
    
    @IBAction func showTest(_ sender: Any) {
        hideAllFPC()
        testFPC.show(animated: true, completion: nil)
    }
    
    func hideAllFPC() {
        lottieFPC.hide(animated: true, completion: nil)
        emptyFPC.hide(animated: true, completion: nil)
        testFPC.hide(animated: true, completion: nil)
    }
}

extension UIViewController {
    class func loadFromNib<T: UIViewController>() -> T {
         return T(nibName: String(describing: self), bundle: nil)
    }
}

class LottieFloatingPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0.4, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
}

class TestFloatingPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .tip
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .half: FloatingPanelLayoutAnchor(absoluteInset: 300, edge: .bottom, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 100, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
}

