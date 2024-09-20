//
//  FilterViewModifier.swift
//  AirBnB
//
//  Created by Ujjwal Arora on 20/09/24.
//

import Foundation
import SwiftUI

struct FilterViewModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .fontWeight(.semibold)
            .font(.subheadline)
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding()
            .shadow(radius: 12)
    }
}
