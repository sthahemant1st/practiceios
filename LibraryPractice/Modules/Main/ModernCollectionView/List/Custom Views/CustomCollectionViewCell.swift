//
//  CustomCollectionViewCell.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 02/03/2022.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "CustomCollectionViewCell"

    @IBOutlet weak var containerView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitileLabel: UILabel!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("init(frame: CGRect)")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        print("awakeFromNib")
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("coder: NSCoder")
    }
    
    func configure(with item: CustomCellListViewController.Item) {
        imageView.image = item.image
        titleLabel.text = item.title
        subTitileLabel.text = item.description
        categoryTitleLabel.text = item.category.name
        categoryImageView.image = item.category.icon
    }
    

}
