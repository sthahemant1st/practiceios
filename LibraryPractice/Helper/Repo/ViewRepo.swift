//
//  ViewRepo.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 17/02/2022.
//

import Foundation

struct ViewRepo {
    struct Main {
        static func getMainViewController() -> MainViewController {
            let mainVC = Storyboard.main.viewController(MainViewController.self)
            return mainVC
        }
        
        static func getEmptyTableViewConroller() -> EmptyTableViewController {
            let emptyTableVC = Storyboard.main.viewController(EmptyTableViewController.self)
            return emptyTableVC
        }
        
        static func getLottieViewController() -> LottieViewController {
            let lottieVC = Storyboard.main.viewController(LottieViewController.self)
            return lottieVC
        }
        
        static func getHeroOneViewController() -> HeroOneViewController {
            let heroOneVC = Storyboard.main.viewController(HeroOneViewController.self)
            return heroOneVC
        }
        
        static func getHeroListViewController() -> HeroListViewController {
            let heroListVC = Storyboard.main.viewController(HeroListViewController.self)
            return heroListVC
        }
        
        static func getHeroTwotViewController() -> HeroTwoViewController {
            let heroTwoVC = Storyboard.main.viewController(HeroTwoViewController.self)
            return heroTwoVC
        }
        
        static func getBiometricPracticeViewController() -> BiometricPracticeViewController {
            let vc = Storyboard.main.viewController(BiometricPracticeViewController.self)
            return vc
        }
        
        static func getBiometricSuccessViewController() -> BiometricSuccessViewController {
            let vc = Storyboard.main.viewController(BiometricSuccessViewController.self)
            return vc
        }
    }
    
    struct Note {
        static func getNotebookListViewController() -> NotebookListViewController {
            let notebookVC = Storyboard.note.viewController(NotebookListViewController.self)
            return notebookVC
        }
        
        static func getNoteListViewController() -> NoteListViewController {
            let noteListVC = Storyboard.note.viewController(NoteListViewController.self)
            return noteListVC
        }
        
        static func getNoteDetailsViewController() -> NoteDetailsViewController {
            let noteDetailsVC = Storyboard.note.viewController(NoteDetailsViewController.self)
            return noteDetailsVC
        }
    }
}
