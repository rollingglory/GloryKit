//
//  SwiftDate
//  Parse, validate, manipulate, and display dates, time and timezones in Swift
//
//  Created by Daniele Margutti
//   - Web: https://www.danielemargutti.com
//   - Twitter: https://twitter.com/danielemargutti
//   - Mail: hello@danielemargutti.com
//
//  Copyright © 2019 Daniele Margutti. Licensed under MIT License.
//

import Foundation

// MARK: - Comparing DateInRegion
/// Comparable `is the same`
public func == (lhs: DateInRegion, rhs: DateInRegion) -> Bool {
	return (lhs.date.timeIntervalSince1970 == rhs.date.timeIntervalSince1970)
}
/// Comparable `is earlier or the same`
public func <= (lhs: DateInRegion, rhs: DateInRegion) -> Bool {
	let result = lhs.date.compare(rhs.date)
	return (result == .orderedAscending || result == .orderedSame)
}
/// Comparable `is later or the same`
public func >= (lhs: DateInRegion, rhs: DateInRegion) -> Bool {
	let result = lhs.date.compare(rhs.date)
	return (result == .orderedDescending || result == .orderedSame)
}
/// Comparable `is earlier`
public func < (lhs: DateInRegion, rhs: DateInRegion) -> Bool {
	return lhs.date.compare(rhs.date) == .orderedAscending
}
/// Comparable `is later`
public func > (lhs: DateInRegion, rhs: DateInRegion) -> Bool {
	return lhs.date.compare(rhs.date) == .orderedDescending
}

// The type of comparison to do against today's date or with the suplied date.
/// Date Comparison
public enum DateComparisonType {

	// Days
    /// - isToday: hecks if date today.
	case isToday
    /// - isTomorrow: Checks if date is tomorrow.
	case isTomorrow
    /// - isYesterday: Checks if date is yesterday.
	case isYesterday
    /// - isSameDay: Compares date days
	case isSameDay(_ : DateRepresentable)

	// Weeks
    /// - isThisWeek: Checks if date is in this week.
	case isThisWeek
    /// - isNextWeek: Checks if date is in next week.
	case isNextWeek
    /// - isLastWeek: Checks if date is in last week.
	case isLastWeek
    /// - isSameWeek: Compares date weeks
	case isSameWeek(_: DateRepresentable)

	// Months
    /// - isThisMonth: Checks if date is in this month.
	case isThisMonth
    /// - isNextMonth: Checks if date is in next month.
	case isNextMonth
    /// - isLastMonth: Checks if date is in last month.
	case isLastMonth
    /// - isSameMonth: Compares date months
	case isSameMonth(_: DateRepresentable)

	// Years
    /// - isThisYear: Checks if date is in this year.
	case isThisYear
    /// - isNextYear: Checks if date is in next year.
	case isNextYear
    /// - isLastYear: Checks if date is in last year.
	case isLastYear
    /// - isSameYear: Compare date years
	case isSameYear(_: DateRepresentable)

	// Relative Time
    /// - isInTheFuture: Checks if it's a future date
	case isInTheFuture
    /// - isInThePast: Checks if the date has passed
	case isInThePast
    /// - isEarlier: Checks if earlier than date
	case isEarlier(than: DateRepresentable)
    /// - isLater: Checks if later than date
	case isLater(than: DateRepresentable)
    /// - isWeekday: Checks if it's a weekday
	case isWeekday
    /// - isWeekend: Checks if it's a weekend
	case isWeekend

	// Day time
    /// - isMorning: Return true if date is in the morning (>=5 - <12)
	case isMorning
    /// - isAfternoon: Return true if date is in the afternoon (>=12 - <17)
	case isAfternoon
    /// - isEvening: Return true if date is in the morning (>=17 - <21)
	case isEvening
    /// - isNight: Return true if date is in the morning (>=21 - <5)
	case isNight

	// TZ
    /// - isInDST: Indicates whether the represented date uses daylight saving time.
	case isInDST
}

public extension DateInRegion {

	/// Decides whether a DATE is "close by" another one passed in parameter,
	/// where "Being close" is measured using a precision argument
	/// which is initialized a 300 seconds, or 5 minutes.
	///
	/// - Parameters:
	///   - refDate: reference date compare against to.
	///   - precision: The precision of the comparison (default is 5 minutes, or 300 seconds).
	/// - Returns: A boolean; true if close by, false otherwise.
	func compareCloseTo(_ refDate: DateInRegion, precision: TimeInterval = 300) -> Bool {
		return (abs(date.timeIntervalSince(refDate.date)) <= precision)
	}

	/// Compare the date with the rule specified in the `compareType` parameter.
	///
	/// - Parameter compareType: comparison type.
	/// - Returns: `true` if comparison succeded, `false` otherwise
	func compare(_ compareType: DateComparisonType) -> Bool {
		switch compareType {
		case .isToday:
			return compare(.isSameDay(region.nowInThisRegion()))

		case .isTomorrow:
			let tomorrow = DateInRegion(region: region).dateByAdding(1, .day)
			return compare(.isSameDay(tomorrow))

		case .isYesterday:
			let yesterday = DateInRegion(region: region).dateByAdding(-1, .day)
			return compare(.isSameDay(yesterday))

		case .isSameDay(let refDate):
			return calendar.isDate(date, inSameDayAs: refDate.date)

		case .isThisWeek:
			return compare(.isSameWeek(region.nowInThisRegion()))

		case .isNextWeek:
			let nextWeek = region.nowInThisRegion().dateByAdding(1, .weekOfYear)
			return compare(.isSameWeek(nextWeek))

		case .isLastWeek:
			let lastWeek = region.nowInThisRegion().dateByAdding(-1, .weekOfYear)
			return compare(.isSameWeek(lastWeek))

		case .isSameWeek(let refDate):
			guard weekOfYear == refDate.weekOfYear else {
				return false
			}
			// Ensure time interval is under 1 week
			return (abs(date.timeIntervalSince(refDate.date)) < 1.weeks.timeInterval)

		case .isThisMonth:
			return compare(.isSameMonth(region.nowInThisRegion()))

		case .isNextMonth:
			let nextMonth = region.nowInThisRegion().dateByAdding(1, .month)
			return compare(.isSameMonth(nextMonth))

		case .isLastMonth:
			let lastMonth = region.nowInThisRegion().dateByAdding(-1, .month)
			return compare(.isSameMonth(lastMonth))

		case .isSameMonth(let refDate):
			return (date.year == refDate.date.year) && (date.month == refDate.date.month)

		case .isThisYear:
			return compare(.isSameYear(region.nowInThisRegion()))

		case .isNextYear:
			let nextYear = region.nowInThisRegion().dateByAdding(1, .year)
			return compare(.isSameYear(nextYear))

		case .isLastYear:
			let lastYear = region.nowInThisRegion().dateByAdding(-1, .year)
			return compare(.isSameYear(lastYear))

		case .isSameYear(let refDate):
			return (date.year == refDate.date.year)

		case .isInTheFuture:
			return compare(.isLater(than: region.nowInThisRegion()))

		case .isInThePast:
			return compare(.isEarlier(than: region.nowInThisRegion()))

		case .isEarlier(let refDate):
			return ((date as NSDate).earlierDate(refDate.date) == date)

		case .isLater(let refDate):
			return ((date as NSDate).laterDate(refDate.date) == date)

		case .isWeekday:
			return !compare(.isWeekend)

		case .isWeekend:
			let range = calendar.maximumRange(of: Calendar.Component.weekday)!
			return (weekday == range.lowerBound || weekday == range.upperBound - range.lowerBound)

		case .isInDST:
			return region.timeZone.isDaylightSavingTime(for: date)

		case .isMorning:
			return (hour >= 5 && hour < 12)

		case .isAfternoon:
			return (hour >= 12 && hour < 17)

		case .isEvening:
			return (hour >= 17 && hour < 21)

		case .isNight:
			return (hour >= 21 || hour < 5)

		}
	}

	/// Returns a ComparisonResult value that indicates the ordering of two given dates based on
	/// their components down to a given unit granularity.
	///
	/// - parameter date:        date to compare.
	/// - parameter granularity: The smallest unit that must, along with all larger units
	/// - returns: `ComparisonResult`
	func compare(toDate refDate: DateInRegion, granularity: Calendar.Component) -> ComparisonResult {
		switch granularity {
		case .nanosecond:
			// There is a possible rounding error using Calendar to compare two dates below the minute granularity
			// So we've added this trick and use standard Date compare which return correct results in this case
			// https://github.com/malcommac/SwiftDate/issues/346
			return date.compare(refDate.date)
		default:
			return region.calendar.compare(date, to: refDate.date, toGranularity: granularity)
		}
	}

	/// Compares whether the receiver is before/before equal `date` based on their components down to a given unit granularity.
	///
	/// - Parameters:
	///   - refDate: reference date
	///   - orEqual: `true` to also check for equality
	///   - granularity: smallest unit that must, along with all larger units, be less for the given dates
	/// - Returns: Boolean
	func isBeforeDate(_ date: DateInRegion, orEqual: Bool = false, granularity: Calendar.Component) -> Bool {
		let result = compare(toDate: date, granularity: granularity)
		return (orEqual ? (result == .orderedSame || result == .orderedAscending) : result == .orderedAscending)
	}

	/// Compares whether the receiver is after `date` based on their components down to a given unit granularity.
	///
	/// - Parameters:
	///   - refDate: reference date
	///   - orEqual: `true` to also check for equality
	///   - granularity: Smallest unit that must, along with all larger units, be greater for the given dates.
	/// - Returns: Boolean
	func isAfterDate(_ refDate: DateInRegion, orEqual: Bool = false, granularity: Calendar.Component) -> Bool {
		let result = compare(toDate: refDate, granularity: granularity)
		return (orEqual ? (result == .orderedSame || result == .orderedDescending) : result == .orderedDescending)
	}

	/// Compares equality of two given dates based on their components down to a given unit
	/// granularity.
	///
	/// - parameter date:        date to compare
	/// - parameter granularity: The smallest unit that must, along with all larger units, be equal for the given
	///         dates to be considered the same.
	///
	/// - returns: `true` if the dates are the same down to the given granularity, otherwise `false`
	func isInside(date: DateInRegion, granularity: Calendar.Component) -> Bool {
		return (compare(toDate: date, granularity: granularity) == .orderedSame)
	}

	/// Return `true` if receiver data is contained in the range specified by two dates.
	///
	/// - Parameters:
	///   - startDate: range upper bound date
	///   - endDate: range lower bound date
	///   - orEqual: `true` to also check for equality on date and date2, default is `true`
	///   - granularity: smallest unit that must, along with all larger units, be greater
	/// - Returns: Boolean
	func isInRange(date startDate: DateInRegion, and endDate: DateInRegion, orEqual: Bool = true, granularity: Calendar.Component = .nanosecond) -> Bool {
		return isAfterDate(startDate, orEqual: orEqual, granularity: granularity) && isBeforeDate(endDate, orEqual: orEqual, granularity: granularity)
	}

	// MARK: - Date Earlier/Later

	/// Return the earlier of two dates, between self and a given date.
	///
	/// - Parameter date: The date to compare to self
	/// - Returns: The date that is earlier
	func earlierDate(_ date: DateInRegion) -> DateInRegion {
		return self.date.timeIntervalSince(date.date) <= 0 ? self : date
	}

	/// Return the later of two dates, between self and a given date.
	///
	/// - Parameter date: The date to compare to self
	/// - Returns: The date that is later
	func laterDate(_ date: DateInRegion) -> DateInRegion {
		return self.date.timeIntervalSince(date.date) >= 0 ? self : date
	}

    /// Returns the difference in the calendar component given (like day, month or year)
    /// with respect to the other date as a positive integer
    func difference(in component: Calendar.Component, from other: DateInRegion) -> Int? {
        return self.date.difference(in: component, from: other.date)
    }

    /// Returns the differences in the calendar components given (like day, month and year)
    /// with respect to the other date as dictionary with the calendar component as the key
    /// and the diffrence as a positive integer as the value
    func differences(in components: Set<Calendar.Component>, from other: DateInRegion) -> [Calendar.Component: Int] {
        return self.date.differences(in: components, from: other.date)
    }

}
