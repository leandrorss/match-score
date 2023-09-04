//
//  PlayerCardView.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 03/09/23.
//

import SwiftUI

struct PlayerCardView: View {
    let player: Player
    
    var body: some View {
        ZStack {
            HStack(spacing: 16) {
                VStack(alignment: .trailing, spacing: 2) {
                    Text(player.fullName)
                        .font(.bodyBold1)
                        .foregroundColor(.white)
                        .lineLimit(1)
                    Text(player.nickname)
                        .font(.bodyRegular1)
                        .foregroundColor(Color.textColor)
                }
                .padding(.trailing, 35)
            }
            .frame(width: 175)
            .frame(height: 60)
            .background(Color.container)
            .cornerRadius(12)
            
            PSImageView(imageUrl: player.imageUrl)
                .controlSize(.regular)
                .cornerRadius(12)
                .padding(.bottom, 20)
                .padding(.leading, 110)
        }
    }
}

struct PlayerCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            PlayerCardView(player: Player.player)
                .previewLayout(.sizeThatFits)
        }
    }
}
