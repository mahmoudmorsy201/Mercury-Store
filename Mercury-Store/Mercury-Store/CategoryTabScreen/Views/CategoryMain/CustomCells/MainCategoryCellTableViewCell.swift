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
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        //cellContainerView.addGestureRecognizer(tap)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        guard let cellClickAction = cellClickAction else {
            return
        }
       // cellContainerView.backgroundColor = .blue
       // cellClickAction(self.item!)
    }
    private func setupCell() {
        cellContainerView.applyShadow(cornerRadius: 12)
    }
}
