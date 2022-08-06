//
//  ColorExtension.swift
//  ManageMyWallet
//
//  Created by Bouchedoub Rmazi on 6/8/2022.
//

import Foundation
import SwiftUI


extension UIColor {

     class func color(data: Data) -> UIColor? {
          return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
     }

     func encode() -> Data? {
          return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
     }
}
