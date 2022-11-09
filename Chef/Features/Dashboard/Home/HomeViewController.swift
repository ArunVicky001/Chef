//
//  HomeViewController.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 29/05/22.
//

import UIKit
import SkeletonView

class HomeViewController: UIViewController {

    var viewModel: HomeViewModel!
    @IBOutlet weak var areaNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var resturantCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var navigateToMenuListClosure: ((DataEntity) -> Void)!
    
    convenience init(viewModel: HomeViewModel) {
        self.init(nibName: "HomeViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInterface()
        self.setupBindings()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        fetchLocationAddress()
        viewModel.delegate = self
        resturantCollectionView.isSkeletonable = true
        resturantCollectionView.prepareSkeleton { (_) in
            self.resturantCollectionView.showAnimatedSkeleton()
        }
        viewModel.fetchResturantList()
    }
    
    func setupInterface() {
        viewModel.getUserLocation()
        resturantCollectionView.delegate = self
        resturantCollectionView.dataSource = self
        resturantCollectionView.registerCell(cellType: RestaurantCell.self)
        searchBar.backgroundImage = UIImage()
    }
    
    func setupBindings() {
        viewModel.reloadSubjectsData += PropertyObserver(uniqueTarget: self, callback: { [weak self] response in
            guard let self = self else { return }
            print("Response : \(self.viewModel.restaurantsResponse)")
            print("Response Data Count : \(self.viewModel.restaurantsResponse.count)")
            self.resturantCollectionView.hideSkeleton(reloadDataAfter: false)
            self.resturantCollectionView.reloadData()
        })
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = viewModel.restaurantsResponse[indexPath.row]
        self.navigateToMenuListClosure(model)
    }
}

extension HomeViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.restaurantsResponse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cellType: RestaurantCell.self, indexPath: indexPath)
        let model = viewModel.restaurantsResponse[indexPath.row]
        cell.setup(with: model)
        return cell
    }
            
}

//MARK: - UICollectionViewDelegateFlowLayout Methods
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        return CGSize(width: width, height: RestaurantCell.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 20, height: 0)
    }
    
}

//MARK: - SkeletonView
extension HomeViewController: SkeletonCollectionViewDataSource {
    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return RestaurantCell.id
    }
    
}

extension HomeViewController: HomePageViewModelDelegate {
    
    func showLocationString(areaName: String, locationString: String) {
        self.areaNameLabel.text = areaName
        self.addressLabel.text = locationString
    }
    
}

