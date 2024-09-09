//
//  File.swift
//  swift-date
//
//  Created by Coen ten Thije Boonkkamp on 04/08/2024.
//

import Foundation
import Testing
import Date

@Test
func test(){    
    let systemClock = Clocks.system

    let threeMonthsFromNow = systemClock.currentDay + .months(3)
    
    let date: Date = .init(threeMonthsFromNow)
    
    print(date)
}
