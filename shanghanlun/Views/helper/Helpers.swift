//
//  Helpers.swift
//  shanghanlun
//
//  Created by xuhua on 2019/2/11.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit

extension UIViewController {
    
    
    // 创建按钮
    func setpupPlus(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "创建", style: .plain, target: self, action: selector)
    }
    
    func setupNext(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一步", style: .plain, target: self, action: selector)
    }
    
    
    
    
    // 取消按钮
    func setpupCancle() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(handleCancle))
    }
    
    @objc func handleCancle() {
        dismiss(animated: true, completion: nil)
    }
    
    func setupUIBackgroud() {
        //要先创建一个底层的uiview，然后把其他ui放在这个上面
        let backView = UIView()
        backView.backgroundColor = .white
        backView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backView)
        
        
        // 设置背景颜色
        backView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backView.heightAnchor.constraint(equalToConstant: 350).isActive = true
    }
    
   
    
}
