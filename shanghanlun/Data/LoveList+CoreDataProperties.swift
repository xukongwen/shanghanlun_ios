//
//  LoveList+CoreDataProperties.swift
//  shanghanlun
//
//  Created by xuhua on 2019/1/24.
//  Copyright © 2019 xuhua. All rights reserved.
//
//

import Foundation
import CoreData


extension LoveList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoveList> {
        return NSFetchRequest<LoveList>(entityName: "LoveList")
    }

    @NSManaged public var row: Int64

}
