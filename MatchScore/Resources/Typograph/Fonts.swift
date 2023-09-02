//
//  Fonts.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 02/09/23.
//

import SwiftUI

public extension Font {
    private static func font(named name: String, size: CGFloat) -> Font {
        return Font.custom(name, size: size)
    }
    /// Roboto, Medium, 32pt
    static let heading1 = font(named: FontManager.Roboto.medium.rawValue, size: 32)
    /// Roboto, Medium, 18pt
    static let heading2 = font(named: FontManager.Roboto.medium.rawValue, size: 18)
    
    /// Roboto, Regular, 12pt
    static let bodyRegular1 = font(named: FontManager.Roboto.regular.rawValue, size: 12)
    /// Roboto, Regular, 10pt
    static let bodyRegular2: Font = Font.custom(FontManager.Roboto.regular.rawValue, size: 10)
    /// Roboto, Regular, 12pt
    static let bodyRegular3: Font = Font.custom(FontManager.Roboto.regular.rawValue, size: 8)
    
    /// Roboto, Bold, 14pt
    static let bodyBold1: Font = Font.custom(FontManager.Roboto.bold.rawValue, size: 14)
    /// Roboto, Bold, 12pt
    static let bodyBold2: Font = Font.custom(FontManager.Roboto.bold.rawValue, size: 12)
    /// Roboto, Bold, 8pt
    static let bodyBold3: Font = Font.custom(FontManager.Roboto.bold.rawValue, size: 8)
}
