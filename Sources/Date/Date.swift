//
//  File.swift
//  swift-date
//
//  Created by Coen ten Thije Boonkkamp on 26/08/2024.
//

import Foundation
import Dependencies

extension DateComponents {
    internal static let allComponents: [Calendar.Component] =  [
        .nanosecond, .second, .minute, .hour,
        .day, .month, .year, .yearForWeekOfYear,
        .weekOfYear, .weekday, .quarter, .weekdayOrdinal,
        .weekOfMonth
    ]
}

extension Date {
    public init?(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) {
        @Dependency(\.calendar) var calendar
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        
        guard let date = calendar.date(from: dateComponents)
        else { return nil }
        self = date
    }
}

// Extension to represent time components
extension Int {
    public var day: DateComponents { DateComponents(day: self) }
    public var days: DateComponents { day }
    public var month: DateComponents { DateComponents(month: self) }
    public var months: DateComponents { month }
    public var year: DateComponents { DateComponents(year: self) }
    public var years: DateComponents { year }
}

// Operator overloading for date arithmetic
public func +(lhs: Date, rhs: DateComponents) -> Date {
    @Dependency(\.calendar) var calendar
    return calendar.date(byAdding: rhs, to: lhs)!
}

public func -(lhs: Date, rhs: DateComponents) -> Date {
    @Dependency(\.calendar) var calendar
    return calendar.date(byAdding: rhs.negated(), to: lhs)!
}

extension DateComponents {
    func negated() -> DateComponents {
        var result = self
        if let day = day { result.day = -day }
        if let month = month { result.month = -month }
        if let year = year { result.year = -year }
        return result
    }
}
