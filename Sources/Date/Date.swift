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
    public var era: DateComponents { DateComponents(era: self) }
    public var hour: DateComponents { DateComponents(hour: self) }
    public var hours: DateComponents { hour }
    public var minute: DateComponents { DateComponents(minute: self) }
    public var minutes: DateComponents { minute }
    public var second: DateComponents { DateComponents(second: self) }
    public var seconds: DateComponents { second }
    public var weekday: DateComponents { DateComponents(weekday: self) }
    public var weekdays: DateComponents { weekday }
    public var weekdayOrdinal: DateComponents { DateComponents(weekdayOrdinal: self) }
    public var weekdaysOrdinal: DateComponents { weekdayOrdinal }
    public var quarter: DateComponents { DateComponents(quarter: self) }
    public var quarters: DateComponents { quarter }
    public var weekOfMonth: DateComponents { DateComponents(weekOfMonth: self) }
    public var weeksOfMonth: DateComponents { weekOfMonth }
    public var weekOfYear: DateComponents { DateComponents(weekOfYear: self) }
    public var weeksOfYear: DateComponents { weekOfYear }
    public var yearForWeekOfYear: DateComponents { DateComponents(yearForWeekOfYear: self) }
    public var nanosecond: DateComponents { DateComponents(nanosecond: self) }
    public var nanoseconds: DateComponents { nanosecond }
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



extension Date {
    public func isAfter(_ date: Date) -> Bool {
        return self > date
    }
    
    public func isBefore(_ date: Date) -> Bool {
        return self < date
    }
    
    public func isSameDay(as date: Date) -> Bool {
        @Dependency(\.calendar) var calendar
        return calendar.isDate(self, inSameDayAs: date)
    }
}


extension Date {
    
    public var era: Int {
        @Dependency(\.calendar) var calendar
        return calendar.component(.era, from: self)
    }

    public var year: Int {
        @Dependency(\.calendar) var calendar
        return calendar.component(.year, from: self)
    }

    public var month: Int {
        @Dependency(\.calendar) var calendar
        return calendar.component(.month, from: self)
    }

    public var day: Int {
        @Dependency(\.calendar) var calendar
        return calendar.component(.day, from: self)
    }

    public var hour: Int {
        @Dependency(\.calendar) var calendar
        return calendar.component(.hour, from: self)
    }

    public var minute: Int {
        @Dependency(\.calendar) var calendar
        return calendar.component(.minute, from: self)
    }

    public var second: Int {
        @Dependency(\.calendar) var calendar
        return calendar.component(.second, from: self)
    }

    public var weekday: Int {
        @Dependency(\.calendar) var calendar
        return calendar.component(.weekday, from: self)
    }

    public var weekdayOrdinal: Int {
        @Dependency(\.calendar) var calendar
        return calendar.component(.weekdayOrdinal, from: self)
    }

    public var quarter: Int {
        @Dependency(\.calendar) var calendar
        return calendar.component(.quarter, from: self)
    }

    public var weekOfMonth: Int {
        @Dependency(\.calendar) var calendar
        return calendar.component(.weekOfMonth, from: self)
    }

    public var weekOfYear: Int {
        @Dependency(\.calendar) var calendar
        return calendar.component(.weekOfYear, from: self)
    }

    public var yearForWeekOfYear: Int {
        @Dependency(\.calendar) var calendar
        return calendar.component(.yearForWeekOfYear, from: self)
    }

    public var nanosecond: Int {
        @Dependency(\.calendar) var calendar
        return calendar.component(.nanosecond, from: self)
    }
    
    public var calendar: Int {
        @Dependency(\.calendar) var calendar
        return calendar.component(.calendar, from: self)
    }
    
    public var timeZone: Int {
        @Dependency(\.calendar) var calendar
        return calendar.component(.timeZone, from: self)
    }
    
    @available(macOS 14, iOS 17, tvOS 17, watchOS 10, *)
    public var isLeapMonth: Int {
        @Dependency(\.calendar) var calendar
        return calendar.component(.isLeapMonth, from: self)
    }
    
    @available(macOS 15, iOS 18, tvOS 18, watchOS 11, *)
    public var dayOfYear: Int {
        @Dependency(\.calendar) var calendar
        return calendar.component(.dayOfYear, from: self)
    }
}

extension Date {
    public var isWeekend: Bool {
        @Dependency(\.calendar) var calendar
        return calendar.isDateInWeekend(self)
    }
    
    public var nextWeekday: Date {
        @Dependency(\.calendar) var calendar
        var nextDate = self
        repeat {
            nextDate = calendar.date(byAdding: .day, value: 1, to: nextDate)!
        } while calendar.isDateInWeekend(nextDate)
        return nextDate
    }
}

extension Date {
    public func ifWeekendThenNextWorkday() -> Date {
        @Dependency(\.calendar) var calendar
        var currentDate = self
        
        while calendar.isDateInWeekend(currentDate) {
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return currentDate
    }

    public func ifWeekendThenPreviousWorkday() -> Date {
        @Dependency(\.calendar) var calendar
        var currentDate = self
        
        while calendar.isDateInWeekend(currentDate) {
            currentDate = calendar.date(byAdding: .day, value: -1, to: currentDate)!
        }
        
        return currentDate
    }
}


extension Date {
    public func next(_ weekday: Int) -> Date {
        @Dependency(\.calendar) var calendar
        return calendar.nextDate(after: self, matching: DateComponents(weekday: weekday), matchingPolicy: .nextTime)!
    }

    public func previous(_ weekday: Int) -> Date {
        @Dependency(\.calendar) var calendar
        return calendar.nextDate(after: self, matching: DateComponents(weekday: weekday), matchingPolicy: .previousTimePreservingSmallerComponents)!
    }
}

extension Date {
    public func daysBetween(_ date: Date) -> Int {
        @Dependency(\.calendar) var calendar
        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: date)
        return calendar.dateComponents([.day], from: date1, to: date2).day!
    }
}

extension Date {
    public func addingBusinessDays(_ businessDays: Int) -> Date {
        @Dependency(\.calendar) var calendar
        var date = self
        var daysRemaining = abs(businessDays)
        let direction: Int = businessDays < 0 ? -1 : 1

        while daysRemaining > 0 {
            date = calendar.date(byAdding: .day, value: direction, to: date)!
            if !calendar.isDateInWeekend(date) {
                daysRemaining -= 1
            }
        }

        return date
    }
}

extension Date {
    public var firstDayOfMonth: Date {
        @Dependency(\.calendar) var calendar
        return calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
    }

    public var lastDayOfMonth: Date {
        @Dependency(\.calendar) var calendar
        return calendar.date(byAdding: DateComponents(month: 1, day: -1), to: self.firstDayOfMonth)!
    }
}

extension Date {
    public func age(at referenceDate: Date = Date()) -> Int {
        @Dependency(\.calendar) var calendar
        return calendar.dateComponents([.year], from: self, to: referenceDate).year!
    }
}

// MARK: - DateFormatter Extension
extension DateFormatter {
    public static func dateFormat(_ dateFormat: String)-> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension FormatStyle where Self == StringDateFormat {
    public static func dateFormat(_ dateFormat: String) ->Self {
        StringDateFormat(dateFormat: dateFormat)
    }
}

public struct StringDateFormat: FormatStyle {
    let dateFormat: String
    public func format(_ value: Date) -> String {
        return DateFormatter.dateFormat(dateFormat).string(from: value)
    }
}


extension DateComponents {
    public static func + (lhs: DateComponents, rhs: DateComponents) -> DateComponents {
        @Dependency(\.calendar) var calendar
        let now = Date()
        guard let date1 = calendar.date(byAdding: lhs, to: now),
              let date2 = calendar.date(byAdding: rhs, to: date1) else {
            return DateComponents()
        }
        return calendar.dateComponents(Set(DateComponents.allComponents), from: now, to: date2)
    }

    public static func - (lhs: DateComponents, rhs: DateComponents) -> DateComponents {
        @Dependency(\.calendar) var calendar
        let now = Date()
        guard let date1 = calendar.date(byAdding: lhs, to: now),
              let date2 = calendar.date(byAdding: rhs.negated(), to: date1) else {
            return DateComponents()
        }
        return calendar.dateComponents(Set(DateComponents.allComponents), from: now, to: date2)
    }

    public static func * (lhs: DateComponents, rhs: Int) -> DateComponents {
        @Dependency(\.calendar) var calendar
        let now = Date()
        var result = DateComponents()
        
        for component in DateComponents.allComponents {
            if let value = lhs.value(for: component) {
                result.setValue(value * rhs, for: component)
            }
        }
        
        guard let finalDate = calendar.date(byAdding: result, to: now) else {
            return DateComponents()
        }
        
        return calendar.dateComponents(Set(DateComponents.allComponents), from: now, to: finalDate)
    }

    public static func * (lhs: Int, rhs: DateComponents) -> DateComponents {
        return rhs * lhs
    }

    func negated() -> DateComponents {
        var result = self
        for component in DateComponents.allComponents {
            if let value = self.value(for: component) {
                result.setValue(-value, for: component)
            }
        }
        return result
    }

    public static var zero: DateComponents {
        return DateComponents()
    }
}
