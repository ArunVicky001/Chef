//
//  UICollectionView+Extensions.swift
//  SchoolOS


import Foundation
import UIKit

public extension UICollectionView {
    
    func registerCell(cellType: UICollectionViewCell.Type) {
        
        let bundle = Bundle(for: cellType)
        self.register(UINib(nibName: cellType.id, bundle: bundle), forCellWithReuseIdentifier: cellType.id)
    }
    
    func registerSupplementaryView(classType:UICollectionReusableView.Type, kind:String) {
        let bundle = Bundle(for: classType)
        let className =  String(describing: classType)
        self.register(UINib(nibName: className, bundle: bundle), forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }
    
    func dequeue<T:UICollectionViewCell>(cellType:T.Type, indexPath:IndexPath) -> T {
        self.layer.shouldRasterize = true;
        self.layer.rasterizationScale = UIScreen.main.scale
        return self.dequeueReusableCell(withReuseIdentifier: cellType.id, for: indexPath) as! T
    }
    
    
    func dequeueSupplementary<T:UICollectionReusableView>(reusableType:T.Type, kind:String, indexPath:IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reusableType.id, for: indexPath) as! T
    }
}

public extension UICollectionReusableView {
    
    class var id: String {
        return String(describing: self.classForCoder())
    }
}

public extension UITableViewCell {
    class func id() -> String {
        var className = NSStringFromClass(self)
        
        if let range = className.range(of:".") {
            className = String(className[range.upperBound...])
        } else {
            print(className)
//           Logger.log.debug("Found a mangled class name? \(className)")
        }
        
        return className
    }
}
