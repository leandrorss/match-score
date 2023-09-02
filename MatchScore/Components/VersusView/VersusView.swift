//
//  VersusView.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 02/09/23.
//

import SwiftUI

struct VersusView: View {
    let opponentsWrapper: [OpponentWrapper]?
    
    var body: some View {
        HStack(alignment: .center, spacing: 30) {
            if let opponents = opponentsWrapper, opponents.count > 1 {
                opponentView(opponents[0])
                
                vsText
                
                opponentView(opponents[1])
            } else {
                opponentsNotFound()
            }
        }
        .frame(height: 120)
        .padding(.horizontal, 75)
    }
    
    func opponentsNotFound() -> some View {
        Text(Strings.opponentsNotFound)
            .font(.heading1)
    }
    
    func opponentView(_ opponentWrapper: OpponentWrapper) -> some View {
        VStack(alignment: .center, spacing: 10) {
            PSImageView(imageUrl: opponentWrapper.opponent.imageUrl)
                .controlSize(.large)
            Text(opponentWrapper.opponent.name)
                .font(.bodyRegular2)
                .foregroundColor(Color.primaryTextColor)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
    }
    
    var vsText: some View {
        Text("vs")
            .font(.bodyRegular1)
            .foregroundColor(.white)
            .opacity(0.5)
    }
}

struct VersusView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.container
            VersusView(opponentsWrapper: Match.matches[0].opponents)
        }
    }
}
