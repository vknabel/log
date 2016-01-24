//
//  LogData.swift
//  ConclurerLog
//
//  Created by Valentin Knabel on 24.01.16.
//  Copyright © 2016 Conclurer GmbH. All rights reserved.
//

private func _print<T>(item: T) {
    print(item)
}

public struct Log {
    public static var defaultHeaderStyle: TextStyle = .Default
    public static var defaultBodyStyle: TextStyle = .Default

    public var headerStyle: TextStyle
    public var bodyStyle: TextStyle
    public var filename: String
    public var line: Int
    public var function: String

    public init(filename: String = __FILE__, line: Int = __LINE__, function: String = __FUNCTION__, headerStyle: TextStyle = Log.defaultHeaderStyle, bodyStyle: TextStyle = Log.defaultBodyStyle) {
        self.filename = (filename as NSString).lastPathComponent
        self.line = line
        self.function = function
        self.headerStyle = headerStyle
        self.bodyStyle = bodyStyle
    }

    public func message<T>(items items: [T]) -> String {
        let msg = items.reduce("", combine: { $0+"\($1)"})
        return headerStyle.format("\(filename):\(line) \(function):") + "\n" + bodyStyle.format("\(msg)")
    }
}

public extension Log {

    public static var xcodeColorsEnabled: Bool {
        get {
            if let xcodeColors = String.fromCString(getenv("XcodeColors")) where xcodeColors == "YES" {
                return true
            } else {
                return false
            }
        }
        set {
            if newValue {
                setenv("XcodeColors", "YES", 0)
            } else {
                setenv("XcodeColors", "NO", 0)
            }
        }
    }

}

public extension Log {

    public func message<T>(items: T...) -> String {
        return message(items: items)
    }

    public func print<T>(items items: [T]) {
        _print(self.message(items: items))
    }

    public func print<T>(items: T...) {
        self.print(items: items)
    }

    public static func message<T>(items items: [T], filename: String = __FILE__, line: Int = __LINE__, function: String = __FUNCTION__, headerStyle: TextStyle = Log.defaultHeaderStyle, bodyStyle: TextStyle = Log.defaultBodyStyle) -> String {
        return Log(filename: filename, line: line, function: function, headerStyle: headerStyle, bodyStyle: bodyStyle).message(items: items)
    }

    public static func message<T>(items: T..., filename: String = __FILE__, line: Int = __LINE__, function: String = __FUNCTION__, headerStyle: TextStyle = Log.defaultHeaderStyle, bodyStyle: TextStyle = Log.defaultBodyStyle) -> String {
        return Log(filename: filename, line: line, function: function, headerStyle: headerStyle, bodyStyle: bodyStyle).message(items: items)
    }

    public static func print<T>(items items: [T], filename: String = __FILE__, line: Int = __LINE__, function: String = __FUNCTION__, headerStyle: TextStyle = Log.defaultHeaderStyle, bodyStyle: TextStyle = Log.defaultBodyStyle) {
        Log(filename: filename, line: line, function: function, headerStyle: headerStyle, bodyStyle: bodyStyle).print(items: items)
    }

    public static func print<T>(items: T..., filename: String = __FILE__, line: Int = __LINE__, function: String = __FUNCTION__, headerStyle: TextStyle = Log.defaultHeaderStyle, bodyStyle: TextStyle = Log.defaultBodyStyle) {
        Log(filename: filename, line: line, function: function, headerStyle: headerStyle, bodyStyle: bodyStyle).print(items: items)
    }
}
