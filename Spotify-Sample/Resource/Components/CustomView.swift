//
//
//  Created by Amir on 5/4/17.
//  Copyright © 2017 Amir. All rights reserved.
//

import UIKit

class CustomView: UIView  , Dashable , Shadowable{
    
    var dashLayer: CAShapeLayer?
    
    
    var tempOffset = CGSize()
     @IBInspectable var borderWidth: CGFloat = 0{
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var hasShadow: Bool = false {
        didSet {
            self.config()
        }
    }
    
    @IBInspectable var borderColor: UIColor! = UIColor.clear {
        didSet {
            config()
        }
    }
    
    
    @IBInspectable var radius: CGFloat = 0 {
        didSet {
            config()
        }
    }
    
    var tap : (()->Void)?{
        didSet{
            initaili()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let dash = self.dashLayer {
            self.layer.addSublayer(dash)
        }
    }
    
    func config() {
        
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        if hasShadow {
            self.dropShadow()
        }
         self.setCorner(radius: self.radius)
    }
   
    func initaili(){
        if let _ = self.tap {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.clickOn))
            self.addGestureRecognizer(tap)
        }
    }
    @objc func clickOn(){
        if let clicki = self.tap {
            clicki()
        }
    }
    
    func setCorner(radius : CGFloat){
        self.layer.cornerRadius = radius
    }
    
    fileprivate func touchUp() {}
    
   
}
