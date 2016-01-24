//
//  TextStyle.swift
//  ConclurerLog
//
//  Created by Valentin Knabel on 24.01.16.
//  Copyright © 2016 Conclurer GmbH. All rights reserved.
//

public enum ColorTarget: String {
    case Foreground = "fg"
    case Background = "bg"
}

public enum TextStyle {
    private static let escape = "\u{001b}["
    private static let reset = "\(TextStyle.escape);"

    case Default
    case Colored(Color, ColorTarget)
    case ColoredTwice(Color, Color)

    public func format<T>(item: T) -> String {
        switch self {
        case .Colored(let color, let target) where Log.xcodeColorsEnabled:
            return "\(TextStyle.escape)\(target.rawValue)\(color.0),\(color.1),\(color.2);\(item)\(TextStyle.reset)"
        case .ColoredTwice(let foreground, let background):
            return "\(TextStyle.escape)\(ColorTarget.Foreground.rawValue)\(foreground.0),\(foreground.1),\(foreground.2);\(TextStyle.escape)\(ColorTarget.Background.rawValue)\(background.0),\(background.1),\(background.2);\(item)\(TextStyle.reset)"
        default:
            return "\(item)"
        }
    }
}