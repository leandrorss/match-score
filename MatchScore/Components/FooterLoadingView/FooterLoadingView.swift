//
//  FooterLoadingView.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 02/09/23.
//

import SwiftUI

struct FooterLoadingView: View {
    
    let isFailed: Bool
    
    var body: some View {
        ZStack(alignment: .center) {
            
            Color.background.ignoresSafeArea(.all)
            
            if isFailed {
                Text(Strings.tapToRefresh)
            } else {
                PSProgressView()
            }
        }
    }
}

struct FooterLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        FooterLoadingView(isFailed: false)
    }
}
