//
//  ChartCell.swift
//  shanghanlun
//
//  Created by xuhua on 2019/2/22.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit


// 这个挺好，可以把一个数据图给放进cell里，看来cell里面啥都可以放
class ChartCell: UITableViewCell {
    
    let ScreenHeight = UIScreen.main.bounds.size.height
    let ScreenWidth = UIScreen.main.bounds.size.width
    
    var chart = SH_Charts()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        let myAppdelegate = UIApplication.shared.delegate as! AppDelegate
//        chart.fanglist = myAppdelegate.fanglist
        
        let pieView = chart.pieChartView
        
        pieView.backgroundColor = ZHFColor.white
        pieView.frame.size = CGSize.init(width: ScreenWidth - 20, height: 300)
        pieView.translatesAutoresizingMaskIntoConstraints = false
        //pieView.delegate = self as? ChartViewDelegate
        
        
        chart.setPieChartViewBaseStyle(title: "默认")
        chart.updataData()
        
        addSubview(pieView)
        pieView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        pieView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        pieView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pieView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pieView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
    
        
    }
    
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
