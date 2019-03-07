//
//  Models.swift
//  shanghanlun
//
//  Created by xuhua on 2019/1/23.
//  Copyright © 2019 xuhua. All rights reserved.
//

import Foundation

//Decodable

struct Yao: Codable {
    let amount: String?
    let yaoID: Int?
    let weight: Int!
    let showName: String?
    let extraProcess: String?
}

struct SH_json: Codable {
    let yaoCount: Int?
    let drinkNum: Int?
    var height: Int?
    let standardYaoList: [Yao?]
    let text: String?
    let fangList: [String?]
    let yaoList: [String?]
    let ID: Int?
    let name: String?
}

struct Section_jk {
    var name: String
    var items: [SH_fang_final]
    var collapsed: Bool
    
    init(name: String, items: [SH_fang_final], collapsed: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

struct SH_book_data: Decodable {
    let ID: Int?
    let text: String?
    let height: Int?
    
}

struct SH_book: Decodable {
    let section: Int?
    let data: [SH_book_data?]
    let header: String?
}

struct Section {
    var name: String
    var items: [SH_book]
    var collapsed: Bool
    
    init(name: String, items: [SH_book], collapsed: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

struct BookDetailSection {
    var name: String
    var items: [SH_book_data]
    var collapsed: Bool
    
    init(name: String, items: [SH_book_data],collapsed: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

struct BookSearcheSection {
    var name: String
    //var items: [SH_book_data]
    var newcells: [CellConfiguratorType]
    var collapsed: Bool
    
    init(name: String, newcells: [CellConfiguratorType], collapsed: Bool = false) {
        self.name = name
        self.newcells = newcells
        self.collapsed = collapsed
    }
}





struct CaoYao: Codable {
    let ID: Int!
    let yaoList: [String]!
    let name: String!
    let height: Int!
    let text: String!
}

struct BenCao: Decodable {
    let ID: Int
    let name: String
    let wei: String
    let temp: String
    let cost: Int
    let text: String
}


//=======================new===================

struct SH_fang_final: Decodable {
    let name: String
    let ID: Int
    let book: String
    let yinyang: String
    let jing: String
    let zheng: Zheng
    let yaocount: Int
    let yaoList: [YaoList]
    let zhengtext: String
    let yaotext: String
    let fuyaotext: String
  
}

struct Zheng: Decodable {
    let ti: [String]
    let mai: [String]
}

struct YaoList: Decodable {
    let yaoname: String
    let dirction: String
    let temp: String
    let wuxing: String
    let weightChina: String
    let weight: Int
    let extraProcess: String
    let cost: Int
}

struct People {
    let name: String
    let age: Int
    let sex: String
}


