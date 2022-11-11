//
//  MainPresenter.swift
//  Shop
//
//  Created by Aida on 11.11.2022.
//

import Foundation

final class MainPresenter: MainViewOutput, MainInteractorOutput {
    
    weak var view: MainViewInput!
    var interactor: MainInteractorInput!
    var router: MainRouterInput!
    
    private var banners: [BannerEntity] = [
        BannerEntity.init(bannerImage: "banner1.png"),
        BannerEntity.init(bannerImage: "banner2.png"),
        BannerEntity.init(bannerImage: "banner3.png")
    ]
    
    private var categories: [GoodsCategoryEntity] = [
        GoodsCategoryEntity.init(category: "Smartphones"),
        GoodsCategoryEntity.init(category: "Laptops"),
        GoodsCategoryEntity.init(category: "Fragrances"),
        GoodsCategoryEntity.init(category: "Skincare"),
        GoodsCategoryEntity.init(category: "Groceries"),
        GoodsCategoryEntity.init(category: "Home-decoration")
    ]
    
    private var goods: GoodsEntity = {
        GoodsEntity.init(products: [Goods.init(id: 1, title: "", description: "", price: 1, discountPercentage: 1, rating: 1, stock: 1, brand: "", category: "", thumbnail: "", images: ["",""])])
    }()
    
    func didLoadView() {
        interactor.obtainGoods()
        view.handleObtainedBanners(banners)
        view.handleObtainedGoodsCategories(categories)
        view.handleObtainedGoods(goods)
    }
    
    func didSelectCategoryCell(with category: String) {
        interactor.ontainFilteredGoods(with: goods, category: category)
    }
    
    func didLoadGoods(_ goods: GoodsEntity) {
        self.goods = goods
        view.handleObtainedGoods(goods)
    }
    
    func didFilteredGoods(_ goodsId: Int) {
        view.handleObtainedFilteredGoods(goodsId)
    }

}
