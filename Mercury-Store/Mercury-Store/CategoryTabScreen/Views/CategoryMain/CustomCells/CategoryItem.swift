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
    var item:CustomCollection?
    var itemID:Int?
    var cellClickAction:( (_ item:Int)->() )?
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
    public func config(item:CustomCollection){
        self.item = item
        ImageDownloaderHelper.imageDownloadHelper(image, item.image?.src ?? "")
        title.text = item.title
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        containerViewForCategoriesCollectionViewCell.addGestureRecognizer(tap)
    }
    public func config(name:String , itemId:Int){
        title.text = name
        image.image = UIImage(named: name)
        self.itemID = itemId
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        containerViewForCategoriesCollectionViewCell.addGestureRecognizer(tap)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        guard let cellClickAction = cellClickAction else {
            return
        }
        if let item = self.item {
            cellClickAction(item.id)
        }else{
            cellClickAction(itemID!)
        }
        
    }
    private func setupCell() {
        containerViewForCategoriesCollectionViewCell.applyShadow(cornerRadius: 12)
    }
}
