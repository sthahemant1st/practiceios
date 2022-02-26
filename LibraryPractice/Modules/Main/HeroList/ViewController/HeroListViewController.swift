//
//  HeroListViewController.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 16/02/2022.
//

import UIKit

class HeroListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    weak var coordinator: MainCoordinator!
    @IBOutlet weak var tableView: UITableView!
    
    let data = ["Hemant Shrestha", "Prachan Ghale"]
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "HeroTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableHero()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disableHero()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HeroTableViewCell
        cell.heroImageView.image = UIImage(named: "hero")
        cell.titleView.text = data[indexPath.row]
        cell.heroImageView.heroID = AppConstants.HeroConstants.image
        cell.titleView.heroID = AppConstants.HeroConstants.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: HeroTwoViewController.identifier) as! HeroTwoViewController
        vc.titleText = data[indexPath.row]
        showHero(vc)
    }
    
}
