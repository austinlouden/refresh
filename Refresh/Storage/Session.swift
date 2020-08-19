//
//  Session.swift
//  Refresh
//
//  Created by Austin Louden on 8/18/20.
//  Copyright © 2020 Austin Louden. All rights reserved.
//

import Foundation

struct Session: Codable {
    let inBreathLength: Int
    let outBreathLength: Int
    let inHoldLength: Int
    let outHoldLength: Int
    let breaths: Int
    
    static func defaultSession() -> Session {
        return Session(inBreathLength: 4, outBreathLength: 4, inHoldLength: 2, outHoldLength: 2, breaths: 10)
    }
}
