//
//  Constants.swift
//  Mercury-Store
//
//  Created by mac hub on 22/05/2022.
//

import Foundation

struct Constants {
    
    struct Paths {
        struct Products {
            public static let productList = "/products.json"
        }
        struct Brands {
            public static let brandsList = "/smart_collections.json"
        }
        struct Categories {
            public static let mainCategoryList = "/custom_collections.json"
        }
        struct Customers {
            public static let customer = "/customers.json"
            public static let customerSearch = "/customers/search.json"
        }
        struct Orders {
            public static let ordersList = "draft_orders.json"
        }
    }
    
        
    
    struct Keys {
        public static let apiKey = "54e7ce1d28a9d3b395830ea17be70ae1"
        public static let password = "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"
        public static let storeName = "mad-ism2022"
        public static let apiVersion = "2022-04"
    }
}



