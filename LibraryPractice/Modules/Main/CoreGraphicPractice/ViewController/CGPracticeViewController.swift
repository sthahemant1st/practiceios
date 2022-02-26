//
//  CGPracticeViewController.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 25/02/2022.
//

import UIKit

class CGPracticeViewController: UIViewController {
    weak var coordinator: MainCoordinator!
    
    let myView = MyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        myView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(myView)
        
        NSLayoutConstraint.activate([
            myView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            myView.widthAnchor.constraint(equalToConstant:  400),
            myView.heightAnchor.constraint(equalToConstant: 400)
        ])
        
        myView.backgroundColor = .systemTeal
        
        print(UIScreen.main.bounds.size)
    }

}

class MyView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(code:) not implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let rect1 = CGRect(x: 0, y: 0, width: 200, height: 200).insetBy(dx: 10, dy: 10)
        
        context.addRect(rect1)
        context.setFillColor(UIColor.systemRed.cgColor)
        context.setStrokeColor(UIColor.systemGreen.cgColor)
        context.setLineWidth(20)
        
        context.drawPath(using: .stroke)
        context.fill(rect1)
        
        let rect2 = CGRect(x: 275, y: 275, width: 125, height: 125).insetBy(dx: 10, dy: 10)
        
        context.setFillColor(UIColor.systemYellow.cgColor)
        context.setStrokeColor(UIColor.systemBlue.cgColor)
        context.setLineWidth(10)
        context.addEllipse(in: rect2)
        context.drawPath(using: .fillStroke)
    }
}
