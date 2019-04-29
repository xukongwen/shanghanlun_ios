//
//  grid_box.swift
//  shanghanlun
//
//  Created by xuhua on 2019/1/25.
//  Copyright © 2019 xuhua. All rights reserved.
//

import Foundation
import UIKit

class YinYangWord: UIViewController {
    
    let shapeLayer = CAShapeLayer()
    let shapeLayer1 = CAShapeLayer()
    let shapeLayer2 = CAShapeLayer()
    let shapeLayer3 = CAShapeLayer()
    let shapeLayer4 = CAShapeLayer()
    let shapeLayer5 = CAShapeLayer()
    let shapeLayer6 = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        let cc1 = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        let cc2 = UIColor(red: 56.0/255.0, green: 56.0/255.0, blue: 56.0/255.0, alpha: 1.0)
        let cc3 = UIColor(red: 87.0/255.0, green: 87.0/255.0, blue: 87.0/255.0, alpha: 1.0)
        let cc4 = UIColor(red: 112.0/255.0, green: 112.0/255.0, blue: 112.0/255.0, alpha: 1.0)
        let cc5 = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0)
        let cc6 = UIColor(red: 194.0/255.0, green: 194.0/255.0, blue: 194.0/255.0, alpha: 1.0)
        
        let backgroundbox = UIView()
        
        backgroundbox.frame = view.frame
        backgroundbox.backgroundColor = .white
        
        view.addSubview(backgroundbox)
        
        let center = view.center
                // 用数学画圆线，但没填充等
        let n = 10
        
        
        let circularPath1 = UIBezierPath(arcCenter: center, radius: 120, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        let circularPath2 = UIBezierPath(arcCenter: center, radius: CGFloat(120 - n), startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        let circularPath3 = UIBezierPath(arcCenter: center, radius: CGFloat(120 - n*2), startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        let circularPath4 = UIBezierPath(arcCenter: center, radius: CGFloat(120 - n*3), startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        let circularPath5 = UIBezierPath(arcCenter: center, radius: CGFloat(120 - n*4), startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        let circularPath6 = UIBezierPath(arcCenter: center, radius: CGFloat(120 - n*5), startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
    
        
        shapeLayer1.path = circularPath1.cgPath
        shapeLayer1.strokeColor = cc1.cgColor
        shapeLayer1.lineWidth = 20
        shapeLayer1.fillColor = UIColor.clear.cgColor
        //view.layer.addSublayer(shapeLayer1)
        
        shapeLayer2.path = circularPath2.cgPath
        
        shapeLayer2.strokeColor = cc2.cgColor
        shapeLayer2.lineWidth = 20
        shapeLayer2.fillColor = UIColor.clear.cgColor
        //view.layer.addSublayer(shapeLayer2)
        
        shapeLayer3.path = circularPath3.cgPath
        
        shapeLayer3.strokeColor = cc3.cgColor
        shapeLayer3.lineWidth = 20
        shapeLayer3.fillColor = UIColor.clear.cgColor
        //view.layer.addSublayer(shapeLayer3)
        
        shapeLayer4.path = circularPath4.cgPath
        
        shapeLayer4.strokeColor = cc4.cgColor
        shapeLayer4.lineWidth = 20
        shapeLayer4.fillColor = UIColor.clear.cgColor
        //view.layer.addSublayer(shapeLayer4)
        
        shapeLayer5.path = circularPath5.cgPath
        shapeLayer5.strokeColor = cc5.cgColor
        shapeLayer5.lineWidth = 20
        shapeLayer5.fillColor = UIColor.clear.cgColor
        //view.layer.addSublayer(shapeLayer5)
        
        shapeLayer6.path = circularPath6.cgPath
        
        shapeLayer6.strokeColor = cc6.cgColor
        shapeLayer6.lineWidth = 20
        shapeLayer6.fillColor = UIColor.clear.cgColor
        //view.layer.addSublayer(shapeLayer6)
        
        perform(#selector(add1), with: nil, afterDelay: 0)
        perform(#selector(add2), with: nil, afterDelay: 0.2)
        perform(#selector(add3), with: nil, afterDelay: 0.4)
        perform(#selector(add4), with: nil, afterDelay: 0.6)
        perform(#selector(add5), with: nil, afterDelay: 0.8)
        perform(#selector(add6), with: nil, afterDelay: 1)
        perform(#selector(remove1), with: nil, afterDelay: 1.2)
        
        //shapeLayer1.removeFromSuperlayer()
//        shapeLayer6.strokeColor = UIColor.clear.cgColor
//        view.layer.addSublayer(shapeLayer6)

//        for n in 0...5 {
//            let circularPath = UIBezierPath(arcCenter: center, radius: CGFloat(150 - n*20), startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
//            shapeLayer.path = circularPath.cgPath
//
//            shapeLayer.strokeColor = UIColor.black.cgColor
//            shapeLayer.lineWidth = 20
//            shapeLayer.fillColor = UIColor.clear.cgColor
//            perform(#selector(add0), with: nil, afterDelay: TimeInterval(1 + n))
//
//        }
        
        //view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc func add0() {
        view.layer.addSublayer(shapeLayer)
    }
    
    @objc func add1() {
        view.layer.addSublayer(shapeLayer1)
        let basicAnimation = CABasicAnimation(keyPath: "opacity")
        
        basicAnimation.fromValue = 0
        basicAnimation.toValue = 1
        
        basicAnimation.duration = 2
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer1.add(basicAnimation, forKey: "urSoBasic")
    }
    
    @objc func add2() {
        view.layer.addSublayer(shapeLayer2)
        let basicAnimation = CABasicAnimation(keyPath: "opacity")
        
        basicAnimation.fromValue = 0
        basicAnimation.toValue = 1
        
        basicAnimation.duration = 2
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer2.add(basicAnimation, forKey: "urSoBasic")
    }
    
    @objc func add3() {
        view.layer.addSublayer(shapeLayer3)
        let basicAnimation = CABasicAnimation(keyPath: "opacity")
        
        basicAnimation.fromValue = 0
        basicAnimation.toValue = 1
        
        basicAnimation.duration = 2
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer3.add(basicAnimation, forKey: "urSoBasic")
    }
    
    @objc func add4() {
        view.layer.addSublayer(shapeLayer4)
        let basicAnimation = CABasicAnimation(keyPath: "opacity")
        
        basicAnimation.fromValue = 0
        basicAnimation.toValue = 1
        
        basicAnimation.duration = 2
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer4.add(basicAnimation, forKey: "urSoBasic")
    }
    
    @objc func add5() {
        view.layer.addSublayer(shapeLayer5)
        let basicAnimation = CABasicAnimation(keyPath: "opacity")
        
        basicAnimation.fromValue = 0
        basicAnimation.toValue = 1
        
        basicAnimation.duration = 2
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer5.add(basicAnimation, forKey: "urSoBasic")
    }
    
    @objc func add6() {
        view.layer.addSublayer(shapeLayer6)
        let basicAnimation = CABasicAnimation(keyPath: "opacity")
        
        basicAnimation.fromValue = 0
        basicAnimation.toValue = 1
        
        basicAnimation.duration = 2
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer6.add(basicAnimation, forKey: "urSoBasic")
    }
    
    @objc func remove1() {
        
        let basicAnimation = CABasicAnimation(keyPath: "opacity")
        
        basicAnimation.fromValue = 1
        basicAnimation.toValue = 0
        
        basicAnimation.duration = 2
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer1.add(basicAnimation, forKey: "urSoBasic")
        shapeLayer1.strokeColor = UIColor.clear.cgColor
        //shapeLayer1.removeFromSuperlayer()
    }
    
    
    
 
    
}





    

