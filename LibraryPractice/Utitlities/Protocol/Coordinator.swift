//
//  Coordinator.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 17/02/2022.
//

import Foundation
import UIKit

///Learn coordinator in tabBar
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController { get set }
    init(navigationController nc: UINavigationController)
    func start()
}
