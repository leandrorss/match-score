//
//  MatchItemView.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 02/09/23.
//

import SwiftUI

struct MatchItemView: View {
    
    let match: Match
    
    var body: some View {
        VStack(spacing: .zero) {
            headerView()
            
            VersusView(opponentsWrapper: match.opponents)
            
            Spacer()
            
            Divider()
                .background(Color.placeholderColor)
            footerView()
            
        }
        .frame(height: 176)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.container)
        )
    }
    
    func headerView() -> some View {
        HStack(spacing: .zero) {
            Spacer()
            HStack {
                Text(match.matchTime.capitalizedSentence)
                    .font(.bodyBold3)
                    .foregroundColor(Color.white)
                    .padding(8)
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        match.IsRunning ?
                        Color.backgroundLiveContainer : Color.backgroundScheduleContainer
                    )
            )
            .padding(.top, 18)
        }
        .frame(height: 25)
    }
    
    func footerView() -> some View {
        HStack(spacing: 15) {
            PSImageView(imageUrl: match.league.imageUrl)
                .controlSize(.small)
            Text(match.leagueAndSerieName)
                .font(.bodyRegular3)
                .foregroundColor(Color.white)
            Spacer()
        }
        .frame(height: 32)
        .padding(.bottom, 8)
        .padding(.leading, 16)
    }
}

struct MatchItemView_Previews: PreviewProvider {
    static var previews: some View {
        MatchItemView(match: Match.match)
    }
}
