//
//  MainAssembly.swift
//  Shop
//
//  Created by Aida on 11.11.2022.
//

import UIKit

final class MainAssembly {
    func assemle() -> UIViewController {
        let menuDataDisplayManager = MainDataDisplayManager()
        let bannerDataDisplayManager = BannerDataDisplayManager()
        let viewController = MainViewController()
        let presenter = MainPresenter()
        let network: Networkable = NetworkManager.shared
        let interactor = MainInteractor(network: network)
        let router = MainRouter()
        
        viewController.menuDataDisplayManager = menuDataDisplayManager
        viewController.bannersDataDisplayManager = bannerDataDisplayManager
        viewController.output = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        return viewController
    }
}
