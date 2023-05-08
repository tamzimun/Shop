//
//  DetailsPresenter.swift
//  Shop
//
//  Created by tamzimun on 11.11.2022.
//

import Foundation

final class DetailsPresenter: DetailsViewOutput, DetailsInteractorOutput, DetailsModuleInput {

    weak var view: DetailsViewInput!
    var interactor: DetailsInteractorInput!
    var router: DetailsRouterInput!
    
    private var goods: Goods!
    
    func configure(with goods: Goods) {
        self.goods = goods
    }
    
    func didloadview() {
        view.handleObtainedDetails(goods)
    }
}
