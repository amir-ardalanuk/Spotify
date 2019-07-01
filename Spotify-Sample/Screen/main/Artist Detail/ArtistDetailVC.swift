//
//  ArtistDetailVC.swift
//  Spotify-Sample
//
//  Created by Amir Ardalan on 7/1/19.
//  Copyright © 2019 Amir Ardalani. All rights reserved.
//

import UIKit

class ArtistDetailVC: UIViewController {

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var vwShare: CustomView!
    @IBOutlet weak var vwDismiss: CustomView!
    @IBOutlet weak var lblHistory: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblIntroduce: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgThumb: UIImageView!
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var vwCoverImage: FooterGradientView!{
        didSet{
             vwCoverImage.setCustomGradient(colors: [.clear,.black])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 

}
