//
//  BannerDataDisplayManager.swift
//  Shop
//
//  Created by tamzimun on 11.11.2022.
//

import UIKit

final class BannerDataDisplayManager: NSObject {
    var banners: [BannerEntity] = []
}

extension BannerDataDisplayManager: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannersCollectionViewCell", for: indexPath) as! BannersCollectionViewCell
        cell.configure(with: banners[indexPath.row].bannerImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 112)
    }
}
