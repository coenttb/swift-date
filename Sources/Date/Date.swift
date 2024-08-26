//
//  File.swift
//  swift-date
//
//  Created by Coen ten Thije Boonkkamp on 26/08/2024.
//

import Foundation

extension DateComponents {
    internal static let allComponents: [Calendar.Component] =  [
        .nanosecond, .second, .minute, .hour,
        .day, .month, .year, .yearForWeekOfYear,
        .weekOfYear, .weekday, .quarter, .weekdayOrdinal,
        .weekOfMonth
    ]
}

extension Int {
    
    internal func toDateComponents(type: Calendar.Component) -> DateComponents {
            var dateComponents = DateComponents()
            DateComponents.allComponents.forEach( { dateComponents.setValue(0, for: $0 )})
            dateComponents.setValue(self, for: type)
            dateComponents.setValue(0, for: .era)
            return dateComponents
        }
    
    public var years: DateComponents {
        toDateComponents(type: .year)
    }
    public var months: DateComponents {
        toDateComponents(type: .month)
    }
    public var days: DateComponents {
        toDateComponents(type: .day)
    }
    public var hours: DateComponents {
        toDateComponents(type: .hour)
    }
    public var minutes: DateComponents {
        toDateComponents(type: .minute)
    }
    public var seconds: DateComponents {
        toDateComponents(type: .second)
    }
    public var nanoseconds: DateComponents {
        toDateComponents(type: .nanosecond)
    }

    public var quarters: DateComponents {
        toDateComponents(type: .quarter)
    }
    
//    public var weekdays: DateComponents {
//        .init(weekday: self)
//    }
//    public var weekdayOrdinals: DateComponents {
//        .init(weekdayOrdinal: self)
//    }
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
