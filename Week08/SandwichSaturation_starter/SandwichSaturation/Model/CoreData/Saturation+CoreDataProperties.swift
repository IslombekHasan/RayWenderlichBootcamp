//
//  Saturation+CoreDataProperties.swift
//  SandwichSaturation
//
//  Created by Islombek Hasanov on 7/21/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
//

import Foundation
import CoreData


extension Saturation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Saturation> {
        return NSFetchRequest<Saturation>(entityName: "Saturation")
    }

    @NSManaged public var level: String
    @NSManaged public var sandwich: Sandwich?

}
