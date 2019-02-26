//
//  PeopleCell.swift
//  shanghanlun
//
// 这里是自定义cell
//
//  Created by xuhua on 2019/2/11.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit

class ZhengCell: UITableViewCell {
    
    
    // 头像
    let peopleimageivew : UIImageView = {
        var im = UIImageView(image: #imageLiteral(resourceName: "deselect"))
        im.contentMode = .scaleAspectFit
        im.translatesAutoresizingMaskIntoConstraints = false
//        im.layer.cornerRadius = 20
//        im.clipsToBounds = true
        return im
    }()
    
    // 名字等
    let peoplename : UILabel = {
        let lable = UILabel()
        lable.font = UIFont.init(name: "Songti Tc", size: 18)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(peopleimageivew)
        peopleimageivew.heightAnchor.constraint(equalToConstant: 30).isActive = true
        peopleimageivew.widthAnchor.constraint(equalToConstant: 30).isActive = true
        peopleimageivew.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        peopleimageivew.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(peoplename)
        peoplename.leftAnchor.constraint(equalTo: peopleimageivew.rightAnchor, constant: 8).isActive = true
        peoplename.topAnchor.constraint(equalTo: topAnchor).isActive = true
        peoplename.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        peoplename.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
    
    
    
}

