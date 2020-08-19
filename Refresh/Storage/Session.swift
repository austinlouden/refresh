//
//  Session.swift
//  Refresh
//
//  Created by Austin Louden on 8/18/20.
//  Copyright © 2020 Austin Louden. All rights reserved.
//

import Foundation

struct Session: Codable {
    let inhaleLength: Int
    let exhaleLength: Int
    let inhaleHoldLength: Int
    let exhaleHoldLength: Int
    let breaths: Int
    
    static func defaultSession() -> Session {
        return Session(inhaleLength: 4, exhaleLength: 4, inhaleHoldLength: 2, exhaleHoldLength: 2, breaths: 10)
    }
    
    static func sessionDataArray(_ s: Session) -> [String] {
        return [
            "Inhale for \(s.inhaleLength) seconds",
            "Hold for \(s.inhaleHoldLength) seconds",
            "Exhale for \(s.exhaleLength) seconds",
            "Hold for \(s.exhaleHoldLength) seconds",
            "\(s.breaths) breaths"
        ]
    }
}
