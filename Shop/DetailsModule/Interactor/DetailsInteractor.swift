//
//  DetailsInteractor.swift
//  Shop
//
//  Created by tamzimun on 11.11.2022.
//

import Foundation

protocol DetailsInteractorInput {
}

protocol DetailsInteractorOutput: AnyObject {
}

final class DetailsInteractor: DetailsInteractorInput {
    weak var output: DetailsInteractorOutput!
    private var network: Networkable
    
    required init(network: Networkable) {
        self.network = network
    }
}
