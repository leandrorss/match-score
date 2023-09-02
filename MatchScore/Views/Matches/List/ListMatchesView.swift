//
//  ListMatchesView.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 02/09/23.
//

import SwiftUI

struct ListMatchesView: View {
    
    @StateObject private var vm = ListMatchesViewModel()
    
    var body: some View {
        
        ZStack {
            Color
                .background
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
                if vm.requestState == .initialFetch {
                    PSProgressView()
                } else {
                    listView()
                    Spacer()
                }
                
            }
            .padding(.horizontal, 25)
            .navigationTitle(Strings.matches)
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    func listView() -> some View {
        ScrollView {
            LazyVStack {
                ForEach(vm.matches) { match in
                    
                    Text(match.leagueAndSerieName)
                    
                    if vm.lastMatch == match {
                        FooterLoadingView(isFailed: false)
                            .onAppear {
                                vm.loadData(.additionalItems)
                            }
                    }
                }
            }
        }
    }
}

struct ListMatchesView_Previews: PreviewProvider {
    static var previews: some View {
        ListMatchesView()
    }
}
