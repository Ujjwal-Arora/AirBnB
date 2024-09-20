//
//  ListingView.swift
//  AirBnB
//
//  Created by Ujjwal Arora on 08/09/24.
//

import SwiftUI

struct ListingView: View {
    @StateObject var vm = ListingViewModel()
    var body: some View {
        ScrollView{
            NavigationLink(destination: FiltersView( vm: vm)) {
                SearchBar()
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
                            }.font(.footnote)
                        }
                        
                    }.padding(.horizontal)
                }
            }.foregroundStyle(.black)
        }
        .task {
            do{
                try await vm.fetchListings()

            }catch{
                print("Error fetching listings :\(error.localizedDescription)")
            }
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
