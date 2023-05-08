//
//  GoodsImagesDataDisplayManager.swift
//  Shop
//
//  Created by tamzimun on 11.11.2022.
//

import UIKit

final class GoodsImagesDataDisplayManager: NSObject {
    var goods: Goods!
}

extension GoodsImagesDataDisplayManager: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goods.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodsImagesCollectionViewCell", for: indexPath) as! GoodsImagesCollectionViewCell
        cell.configure(with: goods.images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 350)
    }
}
