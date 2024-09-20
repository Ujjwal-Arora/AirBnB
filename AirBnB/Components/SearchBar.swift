//
//  SearchAndFilterBar.swift
//  AirBnB
//
//  Created by Ujjwal Arora on 09/09/24.
//

import SwiftUI

struct SearchBar: View {
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
            VStack(alignment : .leading,spacing: 2){
                Text("Where to?")
                    .font(.footnote)
                    .fontWeight(.semibold)
                Text("Anywhere - Any Week - Add guests")
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Image(systemName: "line.3.horizontal.decrease.circle")
        }
        .foregroundStyle(.black)
        .padding(.horizontal)
        .padding(.vertical,8)
        .overlay {
            Capsule()
                .stroke()
                .foregroundStyle(.gray)
                .shadow(color: .gray, radius: 10)
        }.padding()
    }
}

#Preview {
    SearchBar()
}
