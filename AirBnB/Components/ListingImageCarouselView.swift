//
//  ListingImageCarouselView.swift
//  AirBnB
//
//  Created by Ujjwal Arora on 20/09/24.
//

import SwiftUI

struct ListingImageCarouselView: View {
    var listing : ListingModel
    var body: some View {
        VStack(spacing: 8){
            TabView {
                ForEach(listing.imagesUrls,id: \.self) { imageUrl in
                    AsyncImage(url: URL(string: imageUrl)) { image in
                        image
                            .resizable()
                        
                    } placeholder: {
                        ProgressView()
                    }

                }
            }
            .tabViewStyle(.page)
            .frame(height: 320)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}
#Preview {
    ListingImageCarouselView(listing: MockData.listings[0])
}
