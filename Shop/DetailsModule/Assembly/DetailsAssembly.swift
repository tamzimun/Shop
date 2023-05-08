//
//  DetailsAssembly.swift
//  Shop
//
//  Created by tamzimun on 11.11.2022.
//

import UIKit

protocol DetailsModuleInput {
    func configure(with goods: Goods)
}

typealias DetailsModuleConfiguration = (DetailsModuleInput) -> Void

final class DetailsAssembly {
    
    func assemble(_ configuration: DetailsModuleConfiguration? = nil) -> DetailsViewController {
        let goodsImagesdataDisplayManager = GoodsImagesDataDisplayManager()
        let viewController = DetailsViewController()
        let presenter = DetailsPresenter()
        let network: Networkable = NetworkManager.shared
        let interactor = DetailsInteractor(network: network)
        let router = DetailsRouter()
        
        configuration?(presenter)
        viewController.output = presenter
        viewController.goodsImagesdataDisplayManager = goodsImagesdataDisplayManager
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        
        return viewController
    }
}
