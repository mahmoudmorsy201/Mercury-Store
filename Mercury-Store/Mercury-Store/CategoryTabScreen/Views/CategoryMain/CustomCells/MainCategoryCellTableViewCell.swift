//
//  MainCategoryCellTableViewCell.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 01/06/2022.
//

import UIKit

class MainCategoryCellTableViewCell: UITableViewCell {
    static let identifier = "MainCategoryCellTableViewCell"
    @IBOutlet weak var cellContainerView: UIView!
    @IBOutlet weak var categoryItem: UILabel!
    var item:CustomCollection?
    var cellClickAction:( (_ item:CustomCollection)->() )?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    public func config(item:CustomCollection){
        self.item = item
        categoryItem.text = item.title
    }
    
    private func setupCell() {
        cellContainerView.applyShadow(cornerRadius: 12)
    }
}
