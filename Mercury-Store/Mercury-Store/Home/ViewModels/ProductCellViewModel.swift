//
//  ProductCellViewModel.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 07/06/2022.
//

import Foundation
protocol ProductCellViewModelType{
    func toggleFavourite(product:SavedProductItem)->Bool
    func getFavouriteState(productID:Int)->Bool
}
class ProductCellViewModel:ProductCellViewModelType{
    func toggleFavourite(product:SavedProductItem)->Bool{
        return CoreDataModel.coreDataInstatnce.toggleFavourite(product: product)
    }
    func getFavouriteState(productID:Int)->Bool{
        return CoreDataModel.coreDataInstatnce.isProductFavourite(id: productID)
    }
}
