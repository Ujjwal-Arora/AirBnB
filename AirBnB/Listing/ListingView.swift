//
//  ListingView.swift
//  AirBnB
//
//  Created by Ujjwal Arora on 08/09/24.
//

import SwiftUI

struct ListingView: View {
    @StateObject var vm = ListingViewModel()
   // @State private var showFilters = false
    var body: some View {
        ScrollView{
            NavigationLink(destination: FiltersView( vm: vm)) {
                SearchAndFilterBar()
            }
            LazyVStack{
                ForEach(vm.listings) {listing in
                    NavigationLink(value: listing) {
                        VStack{
                            ListingImageCarouselView(listing: listing)
                            
                            HStack(alignment: .top){
                                VStack(alignment : .leading){
                                    Text("\(listing.city), \(listing.state)")
                                        .bold()
                                    Text("Rs.\(listing.pricePerNight) per night")
                                }
                                Spacer()
//                                HStack(spacing : 2){
//                                    Image(systemName: "star.fill")
//                                    Text(listing.rating.formatted())
//                                }
                            }.font(.footnote)
                        }
                        
                    }.padding(.horizontal)
                }
            }.foregroundStyle(.black)
        }
        .navigationDestination(for: ListingModel.self) { listing in
            ListingDetailView(listing: listing)
        }
    }
}

#Preview {
    NavigationStack{
        ListingView()
    }
}
