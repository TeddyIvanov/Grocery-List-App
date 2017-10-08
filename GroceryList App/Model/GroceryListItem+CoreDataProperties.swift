//
//  GroceryListItem+CoreDataProperties.swift
//  GroceryList App
//
//  Created by Teodor Ivanov on 10/8/17.
//  Copyright © 2017 Teodor Ivanov. All rights reserved.
//
//

import Foundation
import CoreData

extension GroceryListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroceryListItem> {
        return NSFetchRequest<GroceryListItem>(entityName: "GroceryListItem")
    }

    @NSManaged public var grocery: String?

}
