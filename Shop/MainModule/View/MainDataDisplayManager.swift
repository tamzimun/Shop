//
//  MainDataDisplayManager.swift
//  Shop
//
//  Created by Aida on 11.11.2022.
//

import UIKit

final class MainDataDisplayManager: NSObject {
    var categories: [GoodsCategoryEntity] = []
    var goods: GoodsEntity = {
        GoodsEntity.init(products: [Goods.init(id: 1, title: "", description: "", price: 1, discountPercentage: 1, rating: 1, stock: 1, brand: "", category: "", thumbnail: "", images: ["",""])])
    }()
    
    var onCategoryDidSelect: ((String) -> Void)?
}

extension MainDataDisplayManager: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCategoryCollectionViewCell", for: indexPath) as! MainCategoryCollectionViewCell
        cell.configure(with: categories[indexPath.row].category)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onCategoryDidSelect?(categories[indexPath.row].category)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: categories[indexPath.row].category.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]).width + 10, height: 32)
    }
}

extension MainDataDisplayManager: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goods.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        cell.configure(with: goods.products[indexPath.row])
        return cell
    }
}

