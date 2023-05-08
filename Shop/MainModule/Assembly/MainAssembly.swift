//
//  MainAssembly.swift
//  Shop
//
//  Created by tamzimun on 11.11.2022.
//

import UIKit

final class MainAssembly {
    func assemle() -> UIViewController {
        let mainDataDisplayManager = MainDataDisplayManager()
        let bannerDataDisplayManager = BannerDataDisplayManager()
        let viewController = MainViewController()
        let presenter = MainPresenter()
        let network: Networkable = NetworkManager.shared
        let interactor = MainInteractor(network: network)
        let router = MainRouter()
        
        viewController.mainDataDisplayManager = mainDataDisplayManager
        viewController.bannersDataDisplayManager = bannerDataDisplayManager
        viewController.output = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.viewController = viewController
        return viewController
    }
}
