//
//  fangAndYuanwen.swift
//  shanghanlun
//
//  Created by xuhua on 2019/2/27.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit

class FangAndYuanwenViewCon: UIViewController {
 
    let bookType : UISegmentedControl = {
        let type = ["方剂","原文"]
        let sc = UISegmentedControl(items: type)
        sc.selectedSegmentIndex = 0
        sc.tintColor = .black
        
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    let fangViewmain = fangView()
    //let fView = fangViewmain.view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUI()
        
        
    }
    
    
    
    
    func setUI() {
        
        let fView = fangViewmain.view
        let nov_f = UINavigationController(rootViewController: fangViewmain)
        let nov_view = nov_f.view
        nov_view!.translatesAutoresizingMaskIntoConstraints = false
        
        let backView = UIView()
        backView.backgroundColor = .white
        backView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backView)
        
        
        // 设置背景颜色
        backView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
 
        view.addSubview(bookType)
        bookType.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 26).isActive = true
        bookType.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -26).isActive = true
        bookType.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        bookType.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(nov_view!)
        nov_view!.topAnchor.constraint(equalTo: bookType.bottomAnchor).isActive = true
        nov_view!.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nov_view!.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        nov_view!.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}
