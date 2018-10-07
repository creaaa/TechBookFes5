//
//  Int+secondify.swift
//  TechBookFes5
//
//  Created by crea on 2018/10/07.
//  Copyright © 2018 crea. All rights reserved.
//

import Foundation

extension Int {
    // thanks to 👉 https://qiita.com/color_box/items/33a7a46bdbf9d4122fb6
    func secondify() -> String? {
        let formatter          = DateComponentsFormatter()
        formatter.unitsStyle   = .positional
        formatter.allowedUnits = [.minute, .hour, .second]
        let outputString       = formatter.string(from: Double(self))
        return outputString
    }
}
