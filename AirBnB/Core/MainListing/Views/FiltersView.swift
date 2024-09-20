//
//  FiltersView.swift
//  AirBnB
//
//  Created by Ujjwal Arora on 09/09/24.
//

import SwiftUI

enum FilterOptions {
    case destination, dates, guests
}

struct FiltersView: View {
    @Environment(\.dismiss) var dismiss
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var selectedFilterOption : FilterOptions = .destination
    @ObservedObject var vm : ListingViewModel

    var body: some View {
        ScrollView{
            headerRow
            if selectedFilterOption == .destination{
                extendedDestination
            }else {
                CollapsedFilterView(title: "Where?", description: "Add destination")
                    .onTapGesture {
                        withAnimation (.snappy){
                            selectedFilterOption = .destination
                        }
                    }
            }
            if selectedFilterOption == .dates{
                extendedDates
            }else {
                CollapsedFilterView(title: "When?", description: "Add dates")
                    .onTapGesture {
                        withAnimation(.snappy) {
                            
                            selectedFilterOption = .dates
                        }
                    }
            }
            if selectedFilterOption == .guests{
                extendedGuests
            }else {
                CollapsedFilterView(title: "Who?", description: "Add guests")
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selectedFilterOption = .guests
                            
                        }
                    }
            }
            
            Spacer()
        }.navigationBarBackButtonHidden()
    }
    private var headerRow : some View{
        HStack{
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark.circle")
            })
            Spacer()
            if !vm.searchText.isEmpty{
                Button(action: {
                    vm.searchText = ""
                }, label: {
                    Text("Clear")
                })
            }
        }
        .font(.headline)
        .foregroundStyle(.black)
        .padding(20)
    }
    
    private var extendedDestination : some View {
        VStack(alignment : .leading){
            Text("Where to?")
                .font(.title2)
                .fontWeight(.semibold)
            HStack{
                Image(systemName: "magnifyingglass")
                TextField("Search destination", text: $vm.searchText)
            }
            .frame(height: 44)
            .padding(.horizontal)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke()
                    .foregroundStyle(.gray)
            }
        }
        .modifier(FilterViewModifier())
    }
    private var extendedDates : some View {
        VStack(alignment:.leading){
            Text("When's your trip?")
                .font(.title2)
            DatePicker("From", selection: $startDate, in: Date()...,displayedComponents: .date)
            
            Divider()
            
            DatePicker("To", selection: $endDate, in: Date()...,displayedComponents: .date)
        }
        .modifier(FilterViewModifier())
    }
    private var extendedGuests : some View {
        VStack(alignment:.leading){
            Text("Who's coming ?")
                .font(.title2)
            Stepper("\(vm.incomingGuests) Adults", value: $vm.incomingGuests, in: 1...10)
        }
        .modifier(FilterViewModifier())

    }
}

#Preview {
    FiltersView(vm: ListingViewModel())
}
