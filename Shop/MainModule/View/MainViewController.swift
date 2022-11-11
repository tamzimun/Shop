//
//  MainViewController.swift
//  Shop
//
//  Created by Aida on 11.11.2022.
//

import UIKit
import HGPlaceholders

enum Constants {
    static let bannerAndCategoryCollectionViewHeight: CGFloat = 260.0
}

protocol MainViewInput: AnyObject {
    func handleObtainedBanners(_ banners: [BannerEntity])
    func handleObtainedGoodsCategories(_ categories: [GoodsCategoryEntity])
    func handleObtainedGoods(_ goods: [Goods])
    func handleObtainedFilteredGoods(_ goodsId: Int)
}

protocol MainViewOutput {
    func didLoadView()
    func didSelectCategoryCell(with category: String)
}


class MainViewController: UIViewController {
    var output: MainViewOutput?
    var mainDataDisplayManager: MainDataDisplayManager?
    var bannersDataDisplayManager: BannerDataDisplayManager?
    
    private let shopLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Shop"
        label.font = UIFont(name:"Hoefler Text", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.bounces = false
        return view
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bannersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(BannersCollectionViewCell.self, forCellWithReuseIdentifier: "BannersCollectionViewCell")
        collection.showsHorizontalScrollIndicator = false
        collection.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collection.backgroundColor = .clear
        return collection
    }()
    
    private let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(MainCategoryCollectionViewCell.self, forCellWithReuseIdentifier: "MainCategoryCollectionViewCell")
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return collection
    }()
    
    private let menuTableView: TableView = {
        let table = TableView()
        table.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .clear
        table.layer.cornerRadius = 20
        table.isScrollEnabled = false
        table.bounces = false
        table.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableCollectionViews()
        makeConstraints()
        output?.didLoadView()
    }
    
    private func setUpTableCollectionViews() {
        categoriesCollectionView.delegate = mainDataDisplayManager
        categoriesCollectionView.dataSource = mainDataDisplayManager
        bannersCollectionView.delegate = bannersDataDisplayManager
        bannersCollectionView.dataSource = bannersDataDisplayManager
        menuTableView.delegate = mainDataDisplayManager
        menuTableView.dataSource = mainDataDisplayManager
        menuTableView.showLoadingPlaceholder()
        scrollView.delegate = self
        
        mainDataDisplayManager?.onCategoryDidSelect = { [ weak self] category in
            self?.output?.didSelectCategoryCell(with: category)
        }
    }

    private func makeConstraints() {
        view.backgroundColor = #colorLiteral(red: 0.9511644244, green: 0.9611129165, blue: 0.9738450646, alpha: 1)
        let guide = view.safeAreaLayoutGuide
        let tableViewHeight = guide.layoutFrame.size.height - Constants.bannerAndCategoryCollectionViewHeight
        
        view.addSubview(shopLabel)
        shopLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(16)
        }

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.centerY.equalTo(scrollView.snp.centerY).priority(.low)
            make.height.equalTo(scrollView.snp.height).priority(.low)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.top.equalTo(shopLabel.snp.bottom)
            make.left.right.bottom.equalTo(scrollView.contentLayoutGuide)
        }
        
        scrollView.addSubview(bannersCollectionView)
        bannersCollectionView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.contentInset.top).offset(24)
            make.left.equalTo(scrollView.contentInset.left)
            make.right.equalTo(scrollView.contentInset.right)
            make.height.equalTo(112)
            make.width.equalTo(300)
        }

        scrollView.addSubview(categoriesCollectionView)
        categoriesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(bannersCollectionView.snp.bottom).offset(24)
            make.left.equalTo(scrollView.contentInset.left)
            make.right.equalTo(bannersCollectionView.snp.right)
            make.height.equalTo(32)
        }

        scrollView.addSubview(menuTableView)
        menuTableView.snp.makeConstraints { make in
            make.top.equalTo(categoriesCollectionView.snp.bottom).offset(24)
            make.right.equalTo(bannersCollectionView.snp.right)
            make.left.bottom.equalTo(scrollView.contentInset)
            make.height.equalTo(tableViewHeight)
        }
    }
}

extension MainViewController: MainViewInput {
    func handleObtainedBanners(_ banners: [BannerEntity]) {
        bannersDataDisplayManager?.banners = banners
        bannersCollectionView.reloadData()
    }
    
    func handleObtainedGoodsCategories(_ categories: [GoodsCategoryEntity]) {
        mainDataDisplayManager?.categories = categories
        categoriesCollectionView.reloadData()
        
        // selects first item of collection view, when categories are loaded
        let indexPath:IndexPath = IndexPath(row: 0, section: 0)
        categoriesCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
    }
    
    func handleObtainedGoods(_ goods: [Goods]) {
        mainDataDisplayManager?.goods = goods
        menuTableView.reloadData()
    }
    
    func handleObtainedFilteredGoods(_ goodsId: Int) {
        if goodsId > 0 {
            let indexPath = NSIndexPath(row: goodsId - 1, section: 0)
            menuTableView.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
        }
    }
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if (scrollView.contentOffset.y < 20){
            menuTableView.isScrollEnabled = false
            menuTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        bannersCollectionView.transform = CGAffineTransform(translationX: 0, y: max(0, scrollView.contentOffset.y - bannersCollectionView.bounds.maxY - 30))
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            checkHasScrolledToBottom()
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        checkHasScrolledToBottom()
    }

    func checkHasScrolledToBottom() {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottomEdge >= scrollView.contentSize.height {
            menuTableView.isScrollEnabled = true
            menuTableView.layer.maskedCorners = []
        }
    }
}
