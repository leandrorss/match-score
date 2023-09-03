//
//  RefreshableControl.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 03/09/23.
//

import SwiftUI

struct RefreshableScrollView<Content:View>: View {
    init(
        action: (() -> Void)? = nil,
        isRefreshing: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content)
    {
        self.content = content
        self.refreshAction = action
        self._isRefreshing = isRefreshing
    }
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                if isRefreshing {
                    PSProgressView()
                        .padding(.bottom)
                }
                content()
                    .anchorPreference(key: OffsetPreferenceKey.self, value: .top) {
                        geometry[$0].y
                    }
            }
            .onPreferenceChange(OffsetPreferenceKey.self) { offset in
                if offset > threshold {
                    if !isRefreshing {
                        refreshAction?()
                    }
                }
            }
        }
    }

    // MARK: - Private
    @Binding var isRefreshing: Bool
    private var content: () -> Content
    private var refreshAction: (() -> Void)?
    private let threshold: CGFloat = 50.0
}

fileprivate struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
