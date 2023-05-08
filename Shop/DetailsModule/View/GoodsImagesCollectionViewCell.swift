//
//  GoodsImagesCollectionViewCell.swift
//  Shop
//
//  Created by tamzimun on 11.11.2022.
//

import UIKit

class GoodsImagesCollectionViewCell: UICollectionViewCell {
    private let goodsImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    func configure(with goodsImage: String) {
        let url = URL(string: goodsImage)
        goodsImageView.kf.setImage(with: url)
    }
    
    func setUpViews(){
        contentView.addSubview(goodsImageView)
        goodsImageView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
