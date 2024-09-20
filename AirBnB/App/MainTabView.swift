//
//  MainTabView.swift
//  AirBnB
//
//  Created by Ujjwal Arora on 20/09/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView{
            ListingView()
                .tabItem {
                Image(systemName: "magnifyingglass")
                    Text("Explore")
                }
            ProfileView()
                .tabItem {
                Image(systemName: "person")
                    Text("Person")
                }
        }
    }
}

#Preview {
    NavigationStack{
        MainTabView()
    }
}

