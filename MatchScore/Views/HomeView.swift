//
//  HomeView.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 02/09/23.
//

import SwiftUI

struct HomeView: View {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(.primaryTextColor)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(.primaryTextColor)]
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea(.all)
                ListMatchesView()
            }
            .navigationTitle(Strings.matches)
            .navigationBarTitleDisplayMode(.large)
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
