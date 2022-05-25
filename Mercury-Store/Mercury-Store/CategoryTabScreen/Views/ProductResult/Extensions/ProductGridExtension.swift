//
//  ProductGridExtension.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 23/05/2022.
//

import Foundation
import UIKit
extension ProductResultViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell
            .identifier , for: indexPath) as! ProductCell
        return cell
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: 250)
    }
    
    
}
