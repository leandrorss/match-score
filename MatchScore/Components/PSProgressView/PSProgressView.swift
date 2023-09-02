//
//  PSProgressView.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 02/09/23.
//

import SwiftUI

struct PSProgressView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .controlSize(.regular)
            .tint(Color.white)
    }
}

struct PSProgressView_Previews: PreviewProvider {
    static var previews: some View {
        PSProgressView()
    }
}
