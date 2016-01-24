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

public enum LogType: String, Hashable {
    case Step
    case Success
    case Notice
    case Error
}

public struct Log {
    public static var styleMap: [LogType: (head: TextStyle, body: TextStyle)] = [
        .Step: (.Colored((128, 128, 128), .Foreground), .Default),
        .Success: (.Colored((0, 255, 0), .Foreground), .Default),
        .Notice: (.Colored((255, 255, 0), .Foreground), .Default),
        .Error: (.Colored((255, 0, 0), .Foreground), .Default)
    ]

    public var type: LogType
    public var filename: String
    public var line: Int
    public var function: String

    public init(filename: String = __FILE__, line: Int = __LINE__, function: String = __FUNCTION__, type: LogType = .Step) {
        self.filename = (filename as NSString).lastPathComponent
        self.line = line
        self.function = function
        self.type = type
    }

    public func message<T>(items items: [T]) -> String {
        let msg = items.reduce("", combine: { $0+"\($1)"})
        let (headerStyle, bodyStyle) = Log.styleMap[type] ?? (.Default, .Default)
        return headerStyle.format("[\(type)]") + " \(filename):\(line) \(function):\n" + bodyStyle.format("\(msg)")
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

    public static func message<T>(items items: [T], filename: String = __FILE__, line: Int = __LINE__, function: String = __FUNCTION__, type: LogType = .Step) -> String {
        return Log(filename: filename, line: line, function: function, type: type).message(items: items)
    }

    public static func message<T>(items: T..., filename: String = __FILE__, line: Int = __LINE__, function: String = __FUNCTION__, type: LogType = .Step) -> String {
        return Log(filename: filename, line: line, function: function, type: type).message(items: items)
    }

    public static func print<T>(items items: [T], filename: String = __FILE__, line: Int = __LINE__, function: String = __FUNCTION__, type: LogType = .Step) {
        Log(filename: filename, line: line, function: function, type: type).print(items: items)
    }

    public static func print<T>(items: T..., filename: String = __FILE__, line: Int = __LINE__, function: String = __FUNCTION__, type: LogType = .Step) {
        Log(filename: filename, line: line, function: function, type: type).print(items: items)
    }
}
