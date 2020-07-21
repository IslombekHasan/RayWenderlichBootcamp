//
//  Saturation+CoreDataClass.swift
//  SandwichSaturation
//
//  Created by Islombek Hasanov on 7/21/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
//

import Foundation
import CoreData


public class Saturation: NSManagedObject {

  var sauceAmount: SauceAmount {
    get {
      guard let saturationLevel = SauceAmount(rawValue: level) else { return .none }
      return saturationLevel
    }
    set {
      self.level = newValue.rawValue
    }
  }

}
