//
//  UICollectionView.swift
//  OKala
//
//  Created by Amir on 12/10/17.
//  Copyright © 2017 Amir All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {

    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: ReusableView, T:ReusableView {
        print(T.reuseIdentifier)
        let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
        return cell
    }

    func reloadData(completion: @escaping ()->())
    {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
    
    func deselectAllItems(animated: Bool = false) {
        for indexPath in self.indexPathsForSelectedItems ?? [] {
            self.deselectItem(at: indexPath, animated: animated)
        }
    }
    
    func deselectItems(indexPaths :[IndexPath],animated: Bool = false) {
        for indexPath in indexPaths ?? [] {
            self.deselectItem(at: indexPath, animated: animated)
        }
    }
}

extension UICollectionView {

    func register<T: UICollectionViewCell>(_ type: T.Type) where T: NibLoadable, T: ReusableView {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
}
