//
//  bookpageCell.swift
//  shanghanlun
//
//  Created by xuhua on 2019/3/14.
//  Copyright © 2019 xuhua. All rights reserved.
//

import Foundation
import UIKit
import SelectableTextView

class BookPageCell : UITableViewCell {
    
    let textView = SelectableTextView()
    
    let peoplename : UILabel = {
        let lable = UILabel()
        lable.font = UIFont.init(name: "Songti Tc", size: 28)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
    
        addSubview(peoplename)
        peoplename.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        peoplename.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        peoplename.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        peoplename.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(textView)
        textView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        textView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        

        textView.sizeToFit()
      
        
        
        let hashtagValidator = PrefixValidator(prefix: "#")
        textView.registerValidator(hashtagValidator) { (validText, validator) in
            print("hi")
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}
