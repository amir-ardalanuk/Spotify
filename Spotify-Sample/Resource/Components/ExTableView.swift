//
//  UITableView.swift
//  OKala
//
//  Created by Amir on 12/10/17.
//  Copyright © 2017 Amir. All rights reserved.
//

import Foundation
import UIKit

extension UITableView
{

    func register<T: UITableViewCell>(_ type: T.Type) where T: ReusableView
    {
        let nib = UINib(nibName: T.reuseIdentifier, bundle: nil)

        self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func reloadData(completion: @escaping ()->())
    {

        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }

    func performUpdate(_ update: ()->Void, completion: (()->Void)?) {

        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)

        beginUpdates()
        update()
        endUpdates()

        CATransaction.commit()
    }

    func loading(state : Bool , defaultFooter : UIView? = nil) {
        if state {
            let loadingVw = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
            loadingVw.startAnimating()
            self.tableFooterView = loadingVw
        }else {
            self.tableFooterView = defaultFooter
        }
        
    }
    
    func reloadDataWithCheckEmpty(){
        self.reloadData {
            if let section = self.dataSource?.numberOfSections?(in: self) , section  > 0 {
                if section > 1 {
                    self.tableFooterView = nil
                }else {
                    if (self.dataSource?.tableView(self, numberOfRowsInSection: 0)) ?? 0 > 0 {
                        self.tableFooterView = nil
                    }else {
//                        let vw = EmptyView()
//                        self.tableFooterView = vw
                    }
                }
            }else{
                if (self.dataSource?.tableView(self, numberOfRowsInSection: 0)) ?? 0 > 0 {
                    self.tableFooterView = nil
                }else {
//                    let vw = EmptyView()
//                    self.tableFooterView = vw
                }
            }
        }
    }
 
    func snapshotRows(at indexPaths: Set<IndexPath>) -> UIImage?
    {
        guard !indexPaths.isEmpty else { return nil }
        var rect = self.rectForRow(at: indexPaths.first!)
        for indexPath in indexPaths
        {
            let cellRect = self.rectForRow(at: indexPath)
            rect = rect.union(cellRect)
        }

        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        for indexPath in indexPaths
        {
            let cell = self.cellForRow(at: indexPath)
            cell?.layer.bounds.origin.y = self.rectForRow(at: indexPath).origin.y - rect.minY
            cell?.layer.render(in: context)
            cell?.layer.bounds.origin.y = 0
        }

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

}

extension UITableView {

    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where  T:ReusableView {
        let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
        return cell
    }

}
