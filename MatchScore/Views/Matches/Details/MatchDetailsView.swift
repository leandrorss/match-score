//
//  MatchDetailsView.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 03/09/23.
//

import SwiftUI

struct MatchDetailsView: View {
    @StateObject var vm: MatchDetailsViewModel
    
    init(match: Match) {
        self._vm = StateObject(wrappedValue: MatchDetailsViewModel(match: match))
    }
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            
            Color.background.ignoresSafeArea(.all)
            
            VStack(alignment: .center, spacing: 20) {
                VersusView(opponentsWrapper: vm.match.opponents)
                Text(vm.match.matchTime.capitalizedSentence)
                    .font(.bodyRegular1)
                    .foregroundColor(Color.primaryTextColor)
                
                if vm.hasOpponents {
                    ScrollView {
                        HStack {
                            renderTeamPlayers(players: vm.playersOpponentOne)
                            
                            Spacer()
                            
                            renderTeamPlayers(players: vm.playersOpponentTwo)
                        }
                    }
                } else {
                    Text(Strings.opponentsNotFound)
                        .font(.bodyBold1)
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle(vm.match.leagueAndSerieName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Icons.backButton
                    }
                }
            }
            .onAppear {
                vm.loadTeams()
            }
        }
    }
    
    func renderTeamPlayers(players: [Player]) -> some View {
        VStack(spacing: 12) {
            ForEach(players) { player in
                Text(player.nickname)
            }
            Spacer()
        }
    }
}

struct MatchDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailsView(match: Match.match)
    }
}
