//
//  CollapsedFilterView.swift
//  AirBnB
//
//  Created by Ujjwal Arora on 09/09/24.
//

import SwiftUI

struct CollapsedFilterView: View {
    let title : String
    let description : String
    var body: some View {
        HStack{
            Text(title)
                .foregroundStyle(.gray)
            Spacer()
            Text(description)
        }
        .modifier(FilterViewModifier())
    }
}

#Preview {
    CollapsedFilterView(title: "Who?", description: "Add guests")
}
