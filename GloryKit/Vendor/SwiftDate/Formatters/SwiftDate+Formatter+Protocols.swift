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

/// Transform Date type directly to String with specified format
public protocol DateToStringTrasformable {
    /// Transform Date type directly to String with specified format
	static func format(_ date: DateRepresentable, options: Any?) -> String
}
/// Transform String type directly to Date with specified format in region
public protocol StringToDateTransformable {
    /// Transform String type directly to Date with specified format in region
	static func parse(_ string: String, region: Region?, options: Any?) -> DateInRegion?
}

// MARK: - Formatters

/// Format to represent a date to string
public enum DateToStringStyles {
    /// - iso: standard iso format. The ISO8601 formatted date, time and millisec "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
	case iso(_: ISOFormatter.Options)
    /// - extended: Extended format. "eee dd-MMM-yyyy GG HH:mm:ss.SSS zzz"
	case extended
    /// - rss: The RSS formatted date "EEE, d MMM yyyy HH:mm:ss ZZZ" i.e. "Fri, 09 Sep 2011 15:26:08 +0200"
	case rss
    /// - altRSS: The Alternative RSS formatted date "d MMM yyyy HH:mm:ss ZZZ" i.e. "09 Sep 2011 15:26:08 +0200"
	case altRSS
    /// - dotNet: The dotNet formatted date "/Date(%d%d)/" i.e. "/Date(1268123281843)/"
    case dotNet
    /// - httpHeader: The http header formatted date "EEE, dd MMM yyyy HH:mm:ss zzz" i.e. "Tue, 15 Nov 1994 12:45:26 GMT"
	case httpHeader
    /// - sql: Returns string in sql format
	case sql
    /// - date: Date only format (short = "2/27/17", medium = "Feb 27, 2017", long = "February 27, 2017", full = "Monday, February 27, 2017"
    case date(_: DateFormatter.Style)
    /// - time: Time only format (short = "2:22 PM", medium = "2:22:06 PM", long = "2:22:06 PM EST", full = "2:22:06 PM Eastern Standard Time"
    case time(_: DateFormatter.Style)
    /// - dateTime: Date/Time format (short = "2/27/17, 2:22 PM", medium = "Feb 27, 2017, 2:22:06 PM", long = "February 27, 2017 at 2:22:06 PM EST", full = "Monday, February 27, 2017 at 2:22:06 PM Eastern Standard Time"
    case dateTime(_: DateFormatter.Style)
    /// - custom: custom string format
    case custom(_: String)
    /// - standard: A generic standard format date i.e. "EEE MMM dd HH:mm:ss Z yyyy"
    case standard
    /// - relative: Give relative format style to string
	case relative(style: RelativeFormatter.Style?)

    /// :nodoc:
	public func toString(_ date: DateRepresentable) -> String {
		switch self {
		case .iso(let opts):			return ISOFormatter.format(date, options: opts)
		case .extended:					return date.formatterForRegion(format: DateFormats.extended).string(from: date.date)
		case .rss:						return date.formatterForRegion(format: DateFormats.rss).string(from: date.date)
		case .altRSS:					return date.formatterForRegion(format: DateFormats.altRSS).string(from: date.date)
		case .sql:						return date.formatterForRegion(format: DateFormats.sql).string(from: date.date)
		case .dotNet:					return DOTNETFormatter.format(date, options: nil)
		case .httpHeader:				return date.formatterForRegion(format: DateFormats.httpHeader).string(from: date.date)
		case .custom(let format):		return date.formatterForRegion(format: format).string(from: date.date)
		case .standard:					return date.formatterForRegion(format: DateFormats.standard).string(from: date.date)
		case .date(let style):
			return date.formatterForRegion(format: nil, configuration: {
				$0.dateStyle = style
				$0.timeStyle = .none
			}).string(from: date.date)
		case .time(let style):
			return date.formatterForRegion(format: nil, configuration: {
				$0.dateStyle = .none
				$0.timeStyle = style
			}).string(from: date.date)
		case .dateTime(let style):
			return date.formatterForRegion(format: nil, configuration: {
				$0.dateStyle = style
				$0.timeStyle = style
			}).string(from: date.date)
		case .relative(let style):
			return RelativeFormatter.format(date, options: style)
		}
	}

}

// MARK: - Parsers

/// String to date transform
public enum StringToDateStyles {
    /// - iso: standard automatic iso parser (evaluate the date components automatically)
	case iso(_: ISOParser.Options)
    /// - extended: Extended format. "eee dd-MMM-yyyy GG HH:mm:ss.SSS zzz"
	case extended
    /// - rss: The RSS formatted date "EEE, d MMM yyyy HH:mm:ss ZZZ" i.e. "Fri, 09 Sep 2011 15:26:08 +0200"
	case rss
    /// - altRSS: The Alternative RSS formatted date "d MMM yyyy HH:mm:ss ZZZ" i.e. "09 Sep 2011 15:26:08 +0200"
	case altRSS
    /// - dotNet: The dotNet formatted date "/Date(%d%d)/" i.e. "/Date(1268123281843)/"
    case dotNet
    /// - sql: Returns sql format
	case sql
    /// - httpHeader: The http header formatted date "EEE, dd MMM yyyy HH:mm:ss zzz" i.e. "Tue, 15 Nov 1994 12:45:26 GMT"
    case httpHeader
    /// - strict: custom string format with lenient options active
	case strict(_: String)
    /// - custom: custom string format
	case custom(_: String)
    /// - standard: A generic standard format date i.e. "EEE MMM dd HH:mm:ss Z yyyy"
	case standard

    /// Parse string to date
	public func toDate(_ string: String, region: Region) -> DateInRegion? {
		switch self {
		case .iso(let options):				return ISOParser.parse(string, region: region, options: options)
		case .custom(let format):			return DateInRegion(string, format: format, region: region)
		case .extended:						return DateInRegion(string, format: DateFormats.extended, region: region)
		case .sql:							return DateInRegion(string, format: DateFormats.sql, region: region)
		case .rss:							return DateInRegion(string, format: DateFormats.rss, region: Region.ISO)?.convertTo(locale: region.locale)
		case .altRSS:						return DateInRegion(string, format: DateFormats.altRSS, region: Region.ISO)?.convertTo(locale: region.locale)
		case .dotNet:						return DOTNETParser.parse(string, region: region, options: nil)
		case .httpHeader:					return DateInRegion(string, format: DateFormats.httpHeader, region: region)
		case .standard:						return DateInRegion(string, format: DateFormats.standard, region: region)
		case .strict(let format):
			let formatter = DateFormatter.sharedFormatter(forRegion: region, format: format)
			formatter.isLenient = false
			guard let absDate = formatter.date(from: string) else { return nil }
			return DateInRegion(absDate, region: region)
		}
	}
}
