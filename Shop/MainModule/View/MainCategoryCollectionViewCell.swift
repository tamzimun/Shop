//
//  MainCategoryCollectionViewCell.swift
//  Shop
//
//  Created by tamzimun on 11.11.2022.
//

import UIKit

class MainCategoryCollectionViewCell: UICollectionViewCell {
    override var isSelected: Bool {
        didSet {
            containerView.layer.backgroundColor = isSelected ? #colorLiteral(red: 0.9975156188, green: 0.7590948939, blue: 0.06972434372, alpha: 1) : #colorLiteral(red: 0.9511644244, green: 0.9611129165, blue: 0.9738450646, alpha: 1)
            categorylabel.textColor = isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.9820694327, green: 0.6771157384, blue: 0.1838825345, alpha: 1)
            categorylabel.font = isSelected ? UIFont.systemFont(ofSize: 13, weight: .semibold) : UIFont.systemFont(ofSize: 13)
        }
    }
    
    private let containerView: UIView = {
        let container = UIView()
        container.layer.borderWidth = 1
        container.layer.borderColor = #colorLiteral(red: 0.9975156188, green: 0.7590948939, blue: 0.06972434372, alpha: 1)
        container.layer.cornerRadius = 16
        return container
    }()
    
    private let categorylabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.9820694327, green: 0.6771157384, blue: 0.1838825345, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    func configure(with category: String) {
        layer.masksToBounds = true
        categorylabel.text = category
    }
    
    func setUpViews(){
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView)
        }

        containerView.addSubview(categorylabel)
        categorylabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(8)
            make.left.equalTo(containerView.snp.left).offset(10)
            make.right.equalTo(containerView.snp.right).offset(-10)
            make.bottom.equalTo(containerView.snp.bottom).offset(-8)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

