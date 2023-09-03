//
//  Icons.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 03/09/23.
//

import SwiftUI

enum IconNames {
    static let chevronLeft = "chevron.left"
}

public enum Icons {
    static let backButton: AnyView = AnyView(ChevronLeftIcon())
}

struct ChevronLeftIcon: View {
    var body: some View {
        Image(systemName: IconNames.chevronLeft)
            .accentColor(Color.primaryTextColor)
            .font(.bodyBold1)
    }
}
