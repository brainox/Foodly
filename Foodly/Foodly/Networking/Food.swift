//
//  Food.swift
//  Foodly
//
//  Created by Decagon on 8.6.21.
//

import Foundation

struct Food {
    var name = ""
}

extension Food: RequestParameter {
    var asParameter: Parameter {
        return ["food": name]
    }
}
