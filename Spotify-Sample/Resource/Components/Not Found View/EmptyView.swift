//
//  EmptyView.swift
//  SafeTeam
//
//  Created by Amir Ardalan on 2/16/19.
//  Copyright © 2019 amir ardaalan. All rights reserved.
//

import UIKit

class EmptyView: UIView , Connectable {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commit()
    }

}
