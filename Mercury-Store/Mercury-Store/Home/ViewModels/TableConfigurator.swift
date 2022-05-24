//
//  TableConfigurator.swift
//  Mercury-Store
//
//  Created by mac hub on 17/05/2022.
//


import UIKit
import RxDataSources

//protocol ReusabelView: AnyObject {
//    static var reuserIdentifier: String { get }
//}
//
//extension ReusabelView where Self: UIView {
//    static var reuserIdentifier: String {
//        return String(describing: self)
//    }
//}
//
//extension UITableViewCell: ReusabelView {}
//
//extension UITableViewHeaderFooterView: ReusabelView {}
//
//protocol NibLoadableView {
//    static var nibName: String { get }
//}
//
//extension NibLoadableView {
//    static var nibName: String {
//        return String(describing: self)
//    }
//}
//
//
//protocol ConfigurableView {
//    associatedtype Item
//    func configure(_ value: Item)
//}

protocol ReuseIdentifiable {
    static func reuseIdentifier() -> String
}

extension ReuseIdentifiable {
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifiable {}
extension UICollectionViewCell: ReuseIdentifiable {}




