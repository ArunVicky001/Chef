//
//  ViewCartViewController.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 10/06/22.
//

import UIKit
import SkeletonView

class ViewCartViewController: UIViewController {

    @IBOutlet weak var cartListCollectionView: UICollectionView!
    @IBOutlet weak var payNowButton: UIButton!
    
    var navigateBackClosure: VoidClosure!
    var viewModel: ViewCartViewModel!
    var paymentClosure: VoidClosure!
    private var headerViewHeight: CGFloat = 125
    
    convenience init(viewModel: ViewCartViewModel) {
        self.init(nibName: "ViewCartViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInterface()
        self.setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewLoad()
        cartListCollectionView.isSkeletonable = true
        cartListCollectionView.prepareSkeleton { (_) in
            self.cartListCollectionView.showAnimatedSkeleton()
        }
    }
    
    func setupInterface() {
        cartListCollectionView.delegate = self
        cartListCollectionView.dataSource = self
        cartListCollectionView.registerCell(cellType: ViewCartCell.self)
        payNowButton.layer.cornerRadius = 10
    }
    
    func setupBindings() {
        viewModel.reloadSubjectsData += PropertyObserver(uniqueTarget: self, callback: { [weak self] response in
            guard let self = self else { return }
            self.cartListCollectionView.hideSkeleton(reloadDataAfter: false)
            self.cartListCollectionView.reloadData()
        })
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.navigateBackClosure()
    }
    
    @IBAction func paymentButtonAction(_ sender: Any) {
        self.paymentClosure()
    }
    
}

extension ViewCartViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension ViewCartViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cartListResponse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cellType: ViewCartCell.self, indexPath: indexPath)
        cell.imageView.tag = indexPath.row
        let model = viewModel.cartListResponse[indexPath.row]
        cell.setup(with: model)        
        return cell
    }
            
}


//MARK: - UICollectionViewDelegateFlowLayout Methods
extension ViewCartViewController: UICollectionViewDelegateFlowLayout {
    
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
extension ViewCartViewController: SkeletonCollectionViewDataSource {
    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return ViewCartCell.id
    }
    
}

