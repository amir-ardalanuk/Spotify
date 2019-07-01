//
//  SearchItemCell.swift
//  Spotify-Sample
//
//  Created by Amir Ardalan on 7/1/19.
//  Copyright © 2019 Amir Ardalani. All rights reserved.
//

import UIKit

class SearchItemCell: UITableViewCell,ReusableView {

    @IBOutlet weak var imgContent: UIImageView!
    @IBOutlet weak var lblDescribtion: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
