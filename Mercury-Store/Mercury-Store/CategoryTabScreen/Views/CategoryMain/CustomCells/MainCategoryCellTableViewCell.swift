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
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        designSelected(selected: selected)
    }
    
    func designSelected(selected:Bool){
        if selected {
            self.categoryItem.textColor = .white
            self.cellContainerView.backgroundColor = UIColor(hexString: "#ed05f5")
        }
        else{
            categoryItem.textColor = .black
            self.cellContainerView.backgroundColor = .white
        }
    }
    
    public func config(item:CustomCollection, index:Int){
        if index == 0{
            designSelected(selected: true)
        }
        self.item = item
        categoryItem.text = item.title
    }
}
