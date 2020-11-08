//
//  PeopleDetailView.swift
//  Ravn-Challenge-V2-Genaro
//
//  Created by Genaro Alvarenga on 11/8/20.
//

import SwiftUI

struct PeopleDetailView: View {
    @ObservedObject var viewModel: PeopleDetailViewModel
    let name: String
    
    var body: some View {
        ZStack {
            PeopleDetailListView(detail: viewModel.detail)
            if viewModel.isLoading {
                ProgressView()
            }
        }.alert(isPresented:  $viewModel.showAlert) {
            Alert(title: Text("Error"),
                  message: Text(viewModel.error?.localizedDescription ?? ""),
                  dismissButton: .default(Text("Close")))
        }
        .onAppear(perform: {
            viewModel.fetchPeopleRequest.accept()
        })
        .navigationTitle(name)
    }
}

struct PeopleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleDetailView(viewModel: PeopleDetailViewModel(peopleID: ""), name: "")
    }
}

struct PeopleDetailListView: View {
    let detail: StarWarsPersonDetail
    
    init(detail: StarWarsPersonDetail) {
        self.detail = detail
        UITableViewHeaderFooterView.appearance().tintColor = .clear
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        List {
            Section(header: CustomHeaderView(text: "General Information")) {
                ForEach(detail.details) { detail in
                    HStack {
                        Text(detail.type)
                            .bold()
                            .foregroundColor(.gray)
                        Spacer()
                        Text(detail.name)
                            .bold()
                    }
                }
            }
            if !detail.vehicles.isEmpty {
                Section(header: CustomHeaderView(text: "Vehicles")) {
                    ForEach(detail.vehicles) { vehicle in
                        HStack {
                            Text(vehicle.name)
                                .bold()
                                .foregroundColor(.gray)
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

struct CustomHeaderView: View {
    let text: String
    var body: some View {
        HStack {
                Text(text)
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    Spacer()
            }
            .background(Color.white)
            .listRowInsets(EdgeInsets(
                top: 0,
                leading: 0,
                bottom: 0,
                trailing: 0))
    }
}
