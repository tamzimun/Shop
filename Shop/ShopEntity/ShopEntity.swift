//
//  ShopEntity.swift
//  Shop
//
//  Created by Aida on 11.11.2022.
//

import Foundation

struct Goods: Codable {
    var id: Int
    var title: String
    var description: String
    var price: Int
    var discountPercentage: Float
    var rating: Float
    var stock: Int
    var brand: String
    var category: String
    var thumbnail: String
    var images: [String]
}

struct GoodsEntity: Codable {
    var products: [Goods]
}
