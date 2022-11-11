//
//  DetailsViewController.swift
//  Shop
//
//  Created by Aida on 11.11.2022.
//

import UIKit
import Kingfisher

protocol DetailsViewInput: AnyObject {
    func handleObtainedDetails(_ details: Goods)
}

protocol DetailsViewOutput {
    func didloadview()
}

class DetailsViewController: UIViewController {
    
    var output: DetailsViewOutput?
    
    private var searchLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Search"
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.didloadview()
        view.backgroundColor = .red
        makeConstraints()
    }
    
    private func makeConstraints() {
        view.addSubview(searchLabel)
        searchLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-27)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
    }
}

extension DetailsViewController: DetailsViewInput {
    func handleObtainedDetails(_ details: Goods) {
        self.searchLabel.text = details.title
    }
}
