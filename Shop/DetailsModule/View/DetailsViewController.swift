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
    var goodsImagesdataDisplayManager: GoodsImagesDataDisplayManager?
    
    private let goodsImagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(GoodsImagesCollectionViewCell.self, forCellWithReuseIdentifier: "GoodsImagesCollectionViewCell")
        collection.showsHorizontalScrollIndicator = false
        collection.contentInset = .zero
        collection.backgroundColor = .clear
        return collection
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var brandLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemGray2
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let discountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 15
        label.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.systemGray2
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.9820694327, green: 0.6771157384, blue: 0.1763326824, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 7
        label.layer.borderColor = #colorLiteral(red: 0.9820694327, green: 0.6771157384, blue: 0.1763326824, alpha: 1)
        label.layer.borderWidth = 0.8
        label.textAlignment = .center
        return label
    }()
    
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    var buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Buy", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.1741578579, green: 0.7215134501, blue: 0.3188108206, alpha: 1)
        button.layer.cornerRadius = 25
        button.titleLabel?.textColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.didloadview()
        makeConstraints()
        configureCollectionViews()
    }
    
    private func configureCollectionViews() {
        goodsImagesCollectionView.delegate = goodsImagesdataDisplayManager
        goodsImagesCollectionView.dataSource = goodsImagesdataDisplayManager
    }
    
    private func makeConstraints() {
        view.backgroundColor = .white
        let screenWidth = UIScreen.main.bounds.width
        
        view.addSubview(goodsImagesCollectionView)
        goodsImagesCollectionView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(screenWidth)
            make.height.equalTo(350)
        }

        view.addSubview(discountLabel)
        discountLabel.snp.makeConstraints { make in
            make.left.equalTo(goodsImagesCollectionView.snp.left).offset(16)
            make.top.equalTo(goodsImagesCollectionView.snp.top).offset(16)
            make.height.equalTo(32)
            make.width.equalTo(67)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(goodsImagesCollectionView.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(16)
        }

        view.addSubview(rateLabel)
        rateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
        view.addSubview(brandLabel)
        brandLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.equalTo(titleLabel)
        }
        
        view.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(brandLabel.snp.bottom).offset(20)
            make.left.equalTo(titleLabel)
            make.height.equalTo(35)
            make.width.equalTo(90)
        }
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(20)
            make.left.equalTo(titleLabel)
            make.right.equalTo(rateLabel)
        }
        
        view.addSubview(buyButton)
        buyButton.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.right.equalTo(rateLabel)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(50)
        }
    }
}

extension DetailsViewController: DetailsViewInput {
    func handleObtainedDetails(_ details: Goods) {
        self.title = details.title
        self.titleLabel.text = details.title
        self.brandLabel.text = "Brand: \(details.brand)"
        self.discountLabel.text = " -\(details.discountPercentage)% "
        self.descriptionLabel.text = "Description: \n\n\(details.description)"
        self.priceLabel.text = "\(details.price) tg"
        self.rateLabel.text = "★ \(details.rating)"
        
        if details.rating < 3 {
            rateLabel.textColor = .systemGray2
        } else if details.rating < 4.5 {
            rateLabel.textColor = .systemOrange
        } else {
            rateLabel.textColor = .systemGreen
        }
        goodsImagesdataDisplayManager?.goods = details
        goodsImagesCollectionView.reloadData()
    }
}
