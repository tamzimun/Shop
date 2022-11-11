//
//  MainRouter.swift
//  Shop
//
//  Created by Aida on 11.11.2022.
//

import UIKit

protocol MainRouterInput {
    func openDetailsModule(with goods: Goods)
}

final class MainRouter: MainRouterInput {
    weak var viewController: UIViewController?
    
    func openDetailsModule(with goods: Goods) {
        let viewController = DetailsAssembly().assemble() { (input) in
            input.configure(with: goods)
        }
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
