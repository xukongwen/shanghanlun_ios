//
//  readBookJson.swift
//  shanghanlun
//
//  Created by xuhua on 2019/3/8.
//  Copyright © 2019 xuhua. All rights reserved.
//

import Foundation

struct ReadJson {
    
    static let shared = ReadJson()
    
    let bookname = "Book_XinJjing.json"
    
    func readBookJson() -> ([Book]) {
        
        var outbook = [Book]()
   
        guard let fileURL = Bundle.main.url(forResource: bookname, withExtension: nil),
            let _ = try? Data.init(contentsOf: fileURL) else{
                fatalError("`JSON File Fetch Failed`")
        }
        
        URLSession.shared.dataTask(with: fileURL) { (data, response, err) in
            DispatchQueue.main.async {
                guard let data = data else { return }
                
                do {
                    let oneJson = try JSONDecoder().decode(Book.self, from: data)
                    outbook.append(oneJson)
                   
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
            
            }.resume()
        return outbook
    }
}





