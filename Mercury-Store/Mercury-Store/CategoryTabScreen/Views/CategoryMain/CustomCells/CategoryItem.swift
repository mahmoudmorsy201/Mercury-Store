//
//  CategoryItem.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 20/05/2022.
//

import UIKit
class CategoryItem: UICollectionViewCell {
    static let identifier = "CategoryItem"
    
    @IBOutlet weak var containerViewForCategoriesCollectionViewCell: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    public func config(name:String , itemId:Int){
        title.text = name
        title.textColor = ColorsPalette.labelColors
        containerViewForCategoriesCollectionViewCell.backgroundColor = ColorsPalette.darkBlue
        image.image = UIImage(named: name)
    }
    private func setupCell() {
        containerViewForCategoriesCollectionViewCell.applyShadow(cornerRadius: 8)
    }
}
