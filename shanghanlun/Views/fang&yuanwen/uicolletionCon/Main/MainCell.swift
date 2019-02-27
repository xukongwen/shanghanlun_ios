//
//  MainCell.swift
//  SwipingPageRedditFeature
//
//  Created by Brian Voong on 12/5/18.
//  Copyright © 2018 Brian Voong. All rights reserved.
//

import UIKit

class MainCell: UICollectionViewCell {
    
    let fangV = fangView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        
        //fangV.tableView
        
        let newsItemsView = fangV.tableView!
        
        let ok = UINavigationController(rootViewController: fangV)
        let okk = ok.view
        
        //fangV.navigationController = ok.navigationController
        
        addSubview(okk!)
        newsItemsView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
