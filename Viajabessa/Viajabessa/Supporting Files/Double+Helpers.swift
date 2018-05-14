//
//  Double+Helpers.swift
//
//  Created by Lucas Ferraço on 16/02/18.
//  Copyright © 2018 Radix Eng. All rights reserved.
//

import Foundation

extension Double {
    public var toString: String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "|"
        formatter.numberStyle = .decimal
        let thousandSeparatorString = formatter.string(from: self as NSNumber)!
        let charChangeString = thousandSeparatorString.replacingOccurrences(of: ".", with: ",").replacingOccurrences(of: "|", with: ".")
        
        var comps = charChangeString.components(separatedBy: ",")
        if comps.count == 1 {
            comps.append("00")
        } else if comps[1].count == 1 {
            comps[1].append("0")
        }
        
        return comps[0] + "," + comps[1]
    }
}
