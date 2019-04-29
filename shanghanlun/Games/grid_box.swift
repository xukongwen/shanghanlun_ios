//
//  grid_box.swift
//  shanghanlun
//
//  Created by xuhua on 2019/1/25.
//  Copyright © 2019 xuhua. All rights reserved.
//

import Foundation
import UIKit

class BoxGird: UIViewController {
    
    let numberPerRow = 15
    var cells = [String: UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let redbox = UIView()
        redbox.backgroundColor = .red
        //redbox.frame = CGRect(x: 0, y: 100, width: 50, height: 50)
        
        
        let width = view.frame.width / CGFloat(numberPerRow)
        
        for i in 0...numberPerRow {
            
            for j in 0...30 {
                let redbox = UIView()
                redbox.backgroundColor = .green
                redbox.frame = CGRect(x: CGFloat(i) * width, y: (CGFloat(j) * width), width: width, height: width)
                redbox.layer.borderWidth = 0.2
                redbox.layer.borderColor = UIColor.gray.cgColor
                view.addSubview(redbox)
                
                let key = "\(i)|\(j)"
                cells[key] = redbox
            }
        }
        
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handpan)))
        
        
    }
    
    @objc func handpan(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: view)
        //print(location)
        let width = view.frame.width / CGFloat(numberPerRow)
        
        let i = Int(location.x / width)
        let j = Int(location.y / width)
        print(i)
        
        let key = "\(i)|\(j)"
        let redbox = cells[key]
        //redbox?.backgroundColor = .white
        
        view.bringSubviewToFront(redbox!)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            redbox?.layer.transform = CATransform3DMakeScale(3, 3, 3)
            redbox?.backgroundColor = self.randomColor()
        }, completion: nil)

    }
    
    fileprivate func randomColor() -> UIColor {
        
        let red = CGFloat(drand48())
        let greed = CGFloat(drand48())
        let blue = CGFloat(drand48())
        
        return UIColor(red: red, green: greed, blue: blue, alpha: 1)
    }
    
    
}
