//
//  ManuListViewController.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 04/06/22.
//

import UIKit
import SkeletonView

class MenuListViewController: UIViewController {

    @IBOutlet weak var headerView: ModuleHeaderView!
    @IBOutlet weak var menuListCollectionView: UICollectionView!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var bgCartView: UILabel!
    @IBOutlet weak var cartCountLabel: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var viewModel: MenuListViewModel!
    var navigateBackClosure: VoidClosure!
    var checkoutClosure: VoidClosure!
    private var headerViewHeight: CGFloat = 125    
    
    convenience init(viewModel: MenuListViewModel) {
        self.init(nibName: "MenuListViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInterface()
        self.setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewLoad()
        menuListCollectionView.isSkeletonable = true
        menuListCollectionView.prepareSkeleton { (_) in
            self.menuListCollectionView.showAnimatedSkeleton()
        }
    }
    
    func setupInterface() {
        menuListCollectionView.delegate = self
        menuListCollectionView.dataSource = self
        menuListCollectionView.registerCell(cellType: MenuListCell.self)
        headerView.setup(with: viewModel.headerViewModel)
        print("Selected Restaurant \(viewModel.restaurantData)")
        cartView.layer.cornerRadius = 10
        checkoutButton.layer.cornerRadius = 10
    }
    
    func setupBindings() {
        viewModel.reloadSubjectsData += PropertyObserver(uniqueTarget: self, callback: { [weak self] response in
            guard let self = self else { return }
            self.menuListCollectionView.hideSkeleton(reloadDataAfter: false)
            self.menuListCollectionView.reloadData()
        })
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigateBackClosure()
    }
    
    @IBAction func checkoutAction(_ sender: Any) {
        self.checkoutClosure()
    }
    
}

extension MenuListViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if( scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height + scrollView.contentInset.top )
        {
            return
        }
        
        let currentOffset = scrollView.contentOffset.y
        if currentOffset <= 0 {
            headerViewHeightConstraint.constant = headerViewHeight - currentOffset
            title = " "
            headerView.alpha =  1
            headerView.titleLabel.alpha = 1
            headerView.descriptionLabel.alpha = 1
        } else if currentOffset <= headerViewHeight {
            let alpha = 1 - currentOffset/(headerViewHeight/2)
            headerViewHeightConstraint.constant = headerViewHeight - currentOffset
            headerView.alpha =  alpha
            headerView.titleLabel.alpha = alpha
            headerView.descriptionLabel.alpha = alpha
            self.title = headerView.titleLabel.alpha <= 0.2 ? "Menu" : " "
            headerView.layoutIfNeeded()
//            self.navigationController?.navigationBar.shadowImage = UIImage()
        } else {
            headerViewHeightConstraint.constant = 0
            self.title = "Menu"
            self.navigationController?.navigationBar.shadowImage = nil
        }
    }
}


extension MenuListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension MenuListViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.menuListResponse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cellType: MenuListCell.self, indexPath: indexPath)
        cell.imageView.tag = indexPath.row
        let model = viewModel.menuListResponse[indexPath.row]
        cell.setup(with: model)
        cell.quandityClosure = { [weak self] (quandity, index) in
            self?.viewModel.totalCartCount.remove(at: index)
            self?.viewModel.totalCartCount.insert(quandity, at: index)
            guard let totalCart = self?.viewModel.totalCartCount.reduce(0, +) else { return }
            if totalCart > 0 {
                self?.bottomConstraint.constant = 170
                self?.cartView.isHidden = false
                self?.cartCountLabel.text = "You have \(totalCart) in shopping cart, check out now"
            } else {
                self?.bottomConstraint.constant = 0
                self?.cartView.isHidden = true
            }
        }
        return cell
    }
            
}

//MARK: - UICollectionViewDelegateFlowLayout Methods
extension MenuListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        return CGSize(width: width, height: MenuListCell.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
}

//MARK: - SkeletonView
extension MenuListViewController: SkeletonCollectionViewDataSource {
    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return MenuListCell.id
    }
    
}

