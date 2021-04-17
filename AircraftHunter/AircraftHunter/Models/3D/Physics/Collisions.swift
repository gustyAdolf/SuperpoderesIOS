//
//  Collisions.swift
//  AircraftHunter
//
//  Created by Gustavo A Ramírez Franco on 12/4/21.
//

import Foundation

struct Collisions: OptionSet {
    let rawValue: Int

    static let plane = Collisions(rawValue: 1 << 0)
    static let bullet = Collisions(rawValue: 1 << 1)
}
