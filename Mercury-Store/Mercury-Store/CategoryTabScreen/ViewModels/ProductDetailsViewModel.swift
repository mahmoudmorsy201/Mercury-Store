//
//  ProductDetailViewModel.swift
//  Mercury-Store
//
//  Created by mac hub on 03/06/2022.
//

import Foundation

protocol ProductsDetailViewModelType: AnyObject{
  //TODO: get the data from coordinator
}

final class ProductsDetailViewModel: ProductsDetailViewModelType {
    weak var productDetailsNavigationFlow: ProductDetailsNavigationFlow?
    
    init(with productDetailsNavigationFlow: ProductDetailsNavigationFlow) {
        
    }
}

extension ProductsDetailViewModel {
    
}



