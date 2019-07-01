//
//  ReusableView.swift
//  OKala
//
//  Created by Amir on 12/10/17.
//  Copyright © 2017 Amir All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView {}

extension ReusableView where Self: UIView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
