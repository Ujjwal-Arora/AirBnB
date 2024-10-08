//
//  BoxModifier.swift
//  AirBnB
//
//  Created by Ujjwal Arora on 16/09/24.
//

import Foundation
import SwiftUI

struct BoxModifier : ViewModifier {
    let backgroundColor : Color
    func body(content: Content) -> some View {
        content
            .padding(12)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))

    }
}
#Preview {
    NavigationStack{
        LoginView(vm: UserViewModel())
    }
}
