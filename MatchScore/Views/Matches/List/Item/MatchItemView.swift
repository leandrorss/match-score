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
        Text(match.leagueAndSerieName)
    }
}

struct MatchItemView_Previews: PreviewProvider {
    static var previews: some View {
        MatchItemView(match: Match.match)
    }
}
