//
//  MainCollectionViewCell.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 17/02/2022.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textlabel: UILabel!
    
    var mainItem: MainItem! {
        didSet {
            imageView.image = UIImage(named: mainItem.imageName)
            textlabel.text = mainItem.title
        }
    }

}
