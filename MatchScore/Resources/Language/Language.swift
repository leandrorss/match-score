//
//  Language.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 02/09/23.
//

import Foundation

enum Strings {
    static let tapToRefresh = Strings.tr("Localizable", "components.loadingView.tapToRefresh")
    static let matches = Strings.tr("Localizable", "matches.title")
    static let opponentsNotFound = Strings.tr("Localizable", "components.versusView.noOpponentsFound")
}

extension Strings {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = Bundle.main.localizedString(forKey: key, value: nil, table: table)
        return String(format: format, locale: Locale.current, arguments: args)
    }
}
