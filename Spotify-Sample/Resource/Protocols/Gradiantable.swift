//
//  Gradiantable.swift
//  Tarabar
//
//  Created by Amir Ardalan on 4/21/18.
//  Copyright © 2018 Golrang. All rights reserved.
//

import Foundation
import UIKit
protocol Gradiantable {
    func setGradiant(withColors colors : [UIColor])->CAGradientLayer
}
protocol GradientAnimatable : Gradiantable {
      func setAnimation(colors : [UIColor])
}
extension Gradiantable where Self : UIView {
   
    func setGradiant(withColors colors : [UIColor])->CAGradientLayer{
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        layer.colors = colors.map{$0.cgColor}
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.locations = [ 0 , 1]
        layer.endPoint = CGPoint(x : 0.5,y: 1.0)
        
        self.layer.insertSublayer(layer, at: 0)
        return layer

    }
    
    func setFooterGradiant(withColors colors : [UIColor])->CAGradientLayer{
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        layer.colors = colors.map{$0.cgColor}.reversed()
        layer.startPoint = CGPoint(x: 0.5, y: 1.0)
        layer.endPoint = CGPoint(x : 0.5,y: 0.5)
        //layer.locations = [ 0 , 1]
        
        
       self.layer.insertSublayer(layer, at: 0)
        return layer
        
    }
}
