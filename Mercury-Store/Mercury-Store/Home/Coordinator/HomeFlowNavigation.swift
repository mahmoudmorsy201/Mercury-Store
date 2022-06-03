//
//  HomeFlowNavigation.swift
//  Mercury-Store
//
//  Created by mac hub on 03/06/2022.
//

import Foundation

protocol HomeFlowNavigation: AnyObject {
    func goToCategoriesTab(with itemName: String)
    func goToBrandDetails(with brandItem: SmartCollection)
}
