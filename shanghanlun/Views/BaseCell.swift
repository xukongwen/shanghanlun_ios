//
//  BaseCell.swift
//  shanghanlun
//
//  Created by xuhua on 2019/1/23.
//  Copyright © 2019 xuhua. All rights reserved.
//

import Foundation
import UIKit

class BaseCell: UITableViewCell {
    
    var item: Any! {
        didSet{
            textLabel?.text = item as? String
            textLabel?.font = UIFont.init(name: "Songti Tc", size: 18)
            detailTextLabel?.font = UIFont.init(name: "STSong", size: 14)
        }
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        backgroundColor = .yellow
//    }
}
