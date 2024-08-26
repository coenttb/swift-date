//
//  File.swift
//  swift-date
//
//  Created by Coen ten Thije Boonkkamp on 26/08/2024.
//

import Foundation

extension Int {
    public var years: DateComponents {
        .init(year: self)
    }
    public var months: DateComponents {
        .init(month: self)
    }
    public var days: DateComponents {
        .init(day: self)
    }
    public var hours: DateComponents {
        .init(hour: self)
    }
    public var minutes: DateComponents {
        .init(minute: self)
    }
    public var seconds: DateComponents {
        .init(second: self)
    }
    public var nanoseconds: DateComponents {
        .init(nanosecond: self)
    }
//    public var weekdays: DateComponents {
//        .init(weekday: self)
//    }
//    public var weekdayOrdinals: DateComponents {
//        .init(weekdayOrdinal: self)
//    }
    public var quarters: DateComponents {
        .init(quarter: self)
    }
//    public var weekOfMonths: DateComponents {
//        .init(weekOfMonth: self)
//    }
//    public var weekOfYears: DateComponents {
//        .init(weekOfYear: self)
//    }
//    public var yearForWeekOfYears: DateComponents {
//        .init(yearForWeekOfYear: self)
//    }

}
