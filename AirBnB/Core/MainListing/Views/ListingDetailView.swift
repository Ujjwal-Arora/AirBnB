//
//  ListingDetailView.swift
//  AirBnB
//
//  Created by Ujjwal Arora on 08/09/24.
//

import SwiftUI
import MapKit

struct ListingDetailView: View {
    @Environment(\.dismiss) var dismiss
    let listing : ListingModel
    var body: some View {
        ZStack{
            ScrollView{
                ListingImageCarouselView(listing: listing)
                
                listingHeader
                
                Divider()
                
                ownerInfo
                
                Divider()
                
                amenities
                
                Divider()
                
                features
                
            }.padding(.bottom,70)
            VStack{
                customBackButton
                Spacer()
                reserveDetails
            }
        }.ignoresSafeArea()
            .navigationBarBackButtonHidden()
    }
    
}
extension ListingDetailView{
    private var listingHeader : some View {
        VStack(alignment : .leading){
            Text(listing.title)
                .font(.title)
                .fontWeight(.semibold)
            Text("\(listing.city), \(listing.state)")
        }
        .padding()
        .font(.caption)
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    private var ownerInfo : some View {
        HStack{
            VStack(alignment : .leading,spacing: 5){
                Text("Entire property is hosted by ")
                    .font(.headline)
                Text(listing.Owner.fullname)
                    .font(.headline)
                HStack(spacing : 10){
                    Text("\(listing.maximumGuests) guests")
                    Text("\(listing.numberOfBedrooms) bedrooms")
                    Text("\(listing.numberOfBathrooms) bathrooms")
                }.font(.caption)
            }
            Spacer()
            AsyncImage(url: URL(string: listing.Owner.profilePhotoUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 64,height: 64)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
            
        }.padding(.horizontal)
    }
    private var amenities : some View {
        VStack(alignment: .leading,spacing: 16){
            ForEach(listing.amenities,id: \.self){ amenity in
                HStack(spacing: 16){
                    Image(systemName: amenity.imageName)
                        .font(.title)
                    VStack(alignment:.leading){
                        Text(amenity.title)
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Text(amenity.description)
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                }.frame(maxWidth: .infinity,alignment: .leading)
            }
            
            Divider()
            
            Text("Where you'll sleep")
                .font(.headline)
            ScrollView(.horizontal) {
                HStack(spacing: 16){
                    ForEach(1..<listing.numberOfBedrooms + 1,id: \.self){ count in
                        VStack {
                            Image(systemName: "bed.double")
                            Text("Bedroom \(count)")
                        }.frame(width: 130, height: 100)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke()
                                    .foregroundStyle(.gray)
                            }
                    }
                }
            }
        }.padding()
    }
    
    private var features : some View {
        VStack(alignment : .leading,spacing: 16){
            Text("What this place offers")
                .font(.headline)
            ForEach(listing.features){ feature in
                HStack{
                    Image(systemName: feature.imageName)
                        .frame(width: 32)
                    Text(feature.title)
                        .font(.footnote)
                    Spacer()
                }
            }
        }.padding()
    }
    
    private var customBackButton: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.backward.circle.fill")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
            }
            .padding(.horizontal,20)
            .padding(.vertical,50)
            Spacer()
        }
    }
    private var reserveDetails : some View {
        HStack{
            VStack(alignment:.leading){
                Text("Rs. \(listing.pricePerNight)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text("Total before taxes")
                    .font(.footnote)
            }
            Spacer()
            Button(action: {}, label: {
                Text("Reserve")
                    .foregroundStyle(.white)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 140, height: 40)
                    .background(.pink)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            })
        }
        .padding(20)
        .background(.white)
    }
}

#Preview {
    NavigationStack{
        ListingDetailView(listing: MockData.listings[0])
    }
}
