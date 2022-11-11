//
//  MainTableViewCell.swift
//  Shop
//
//  Created by Aida on 11.11.2022.
//

import UIKit
import SnapKit
import Kingfisher

class MainTableViewCell: UITableViewCell {
    private let foodImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 25
        image.layer.masksToBounds = true
        return image
    }()

    private let discountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 10
        label.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    private let foodNamelabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.layer.cornerRadius = 5
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.systemGray2
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = #colorLiteral(red: 0.9820694327, green: 0.6771157384, blue: 0.1763326824, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 5
        label.layer.borderColor = #colorLiteral(red: 0.9820694327, green: 0.6771157384, blue: 0.1763326824, alpha: 1)
        label.layer.borderWidth = 0.5
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
     }

    // MARK: - Setup Constraints
    func configure(with goods: Goods) {
        let url = URL(string: goods.thumbnail)
        foodImageView.kf.setImage(with: url)
        discountLabel.text = "-\(goods.discountPercentage)%"
        foodNamelabel.text = goods.title
        descriptionLabel.text = goods.description
        priceLabel.text = "\(goods.price) tg"
    }
    
    func setupViews(){
//        selectionStyle = .none
        
        contentView.addSubview(foodImageView)
        foodImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(16)
            make.height.equalTo(133)
            make.width.equalTo(133)
        }
        
        contentView.addSubview(discountLabel)
        discountLabel.snp.makeConstraints { make in
            make.top.equalTo(foodImageView.snp.top).offset(7)
            make.right.equalTo(foodImageView.snp.right).offset(-7)
            make.height.equalTo(30)
            make.width.equalTo(55)
        }
        
        contentView.addSubview(foodNamelabel)
        foodNamelabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(24)
            make.left.equalTo(foodImageView.snp.right).offset(32)
            make.right.equalTo(contentView).offset(-24)
        }

        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(foodNamelabel.snp.bottom).offset(8)
            make.left.equalTo(foodNamelabel.snp.left)
            make.right.equalTo(foodNamelabel.snp.right)
        }

        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.right.equalTo(foodNamelabel.snp.right)
            make.bottom.equalTo(contentView).offset(-24)
            make.height.equalTo(32)
            make.width.equalTo(87)
        }
    }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
}
