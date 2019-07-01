//
//  GradientView.swift
//  retailer
//
//  Created by Amir Ardalan on 9/3/18.
//  Copyright © 2018 golrang. All rights reserved.
//

import UIKit
class GradientView : CustomView , GradientAnimatable {
    func setAnimation(colors: [UIColor]) {
        
    }
    
   
    
    
    var gradientLayer: CAGradientLayer?
    
    @IBInspectable
    var startColor: UIColor = .red
    
    @IBInspectable
    var endColor: UIColor = .blue
   
   override func config(){
        super.config()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer?.frame = self.bounds
        
    }
    
    func setGradientLayer(_ colors: [UIColor]) {
        gradientLayer = self.setGradiant(withColors: colors )
    }
    
    func setCustomGradient(colors : [UIColor]){
        //self.colors = colors
        if gradientLayer != nil {
            gradientLayer?.removeFromSuperlayer()
        }
        setGradientLayer(colors)
        self.layoutIfNeeded()
    }
}
class FooterGradientView : GradientView {
    
    override func config(){
        super.config()
        setCustomGradient(colors: [#colorLiteral(red: 1, green: 0, blue: 0.02368752472, alpha: 1),.black])
    }
    
    override func setGradientLayer(_ colors: [UIColor]) {
         gradientLayer = self.setFooterGradiant(withColors: colors)
    }

}
