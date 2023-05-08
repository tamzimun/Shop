//
//  MainInteractor.swift
//  Shop
//
//  Created by tamzimun on 11.11.2022.
//

import Foundation

protocol MainInteractorInput {
    func obtainGoods()
    func ontainFilteredGoods(with goods: [Goods], category: String)
}

protocol MainInteractorOutput: AnyObject {
    func didLoadGoods(_ goods: GoodsEntity)
    func didFilteredGoods(_ goodsId: Int)
}

final class MainInteractor: MainInteractorInput {
    weak var output: MainInteractorOutput!
    private var network: Networkable
    
    required init(network: Networkable) {
        self.network = network
    }

    func obtainGoods() {
        network.fetchData(path: "/products") { [weak self] (result : Result <GoodsEntity, APINetworkError>) in
            switch result {
            case .success(let goods):
                self?.output.didLoadGoods(goods)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func ontainFilteredGoods(with goods: [Goods], category: String) {
        var goodsId: Int = 0
        for item in goods {
            if item.category.lowercased() == category.lowercased() {
                goodsId = item.id
                break
            }
        }
        output.didFilteredGoods(goodsId)
    }
}
