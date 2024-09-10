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
    
    withDependencies {
        $0.calendar = .current
    } operation: {
        let y = Date.now
        
        let x = 1.year + 6.minutes * 6
        print((y + x).formatted(date: .long, time: .complete))
    }
}
