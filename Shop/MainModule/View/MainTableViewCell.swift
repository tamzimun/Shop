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
    private let goodsImageView: UIImageView = {
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
        label.layer.cornerRadius = 7
        label.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    private let goodsNamelabel: UILabel = {
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
        label.layer.cornerRadius = 7
        label.layer.borderColor = #colorLiteral(red: 0.9820694327, green: 0.6771157384, blue: 0.1763326824, alpha: 1)
        label.layer.borderWidth = 0.5
        label.textAlignment = .center
        return label
    }()
    
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
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
        goodsImageView.kf.setImage(with: url)
        discountLabel.text = "-\(goods.discountPercentage)%"
        goodsNamelabel.text =  goods.title
        descriptionLabel.text = goods.description
        priceLabel.text = "\(goods.price) tg"
        rateLabel.text = "★ \(goods.rating)"
        
        if goods.rating < 3 {
            rateLabel.textColor = .systemGray2
        } else if goods.rating < 4.5 {
            rateLabel.textColor = .systemOrange
        } else {
            rateLabel.textColor = .systemGreen
        }
    }
    
    func setupViews(){
        selectionStyle = .none
        
        contentView.addSubview(goodsImageView)
        goodsImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(16)
            make.height.equalTo(133)
            make.width.equalTo(133)
        }
        
        contentView.addSubview(discountLabel)
        discountLabel.snp.makeConstraints { make in
            make.top.equalTo(goodsImageView.snp.top).offset(7)
            make.right.equalTo(goodsImageView.snp.right).offset(-7)
            make.height.equalTo(30)
            make.width.equalTo(55)
        }
        
        contentView.addSubview(goodsNamelabel)
        goodsNamelabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(24)
            make.left.equalTo(goodsImageView.snp.right).offset(32)
        }

        contentView.addSubview(rateLabel)
        rateLabel.snp.makeConstraints { make in
            make.top.equalTo(goodsNamelabel.snp.top)
            make.left.equalTo(goodsNamelabel.snp.right).offset(8)
            make.right.equalTo(contentView).offset(-24)
            make.width.equalTo(50)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(goodsNamelabel.snp.bottom).offset(8)
            make.left.equalTo(goodsNamelabel.snp.left)
            make.right.equalTo(rateLabel.snp.right)
        }

        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.right.equalTo(rateLabel.snp.right)
            make.bottom.equalTo(contentView).offset(-24)
            make.height.equalTo(32)
            make.width.equalTo(87)
        }
    }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
}
