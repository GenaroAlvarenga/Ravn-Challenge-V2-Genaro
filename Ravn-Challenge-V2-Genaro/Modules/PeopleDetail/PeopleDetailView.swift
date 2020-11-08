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

    var body: some View {
        List {
            Section(header: Text("General Information")) {
                ForEach(detail.details) { detail in
                    HStack {
                        Text(detail.type)
                        Spacer()
                        Text(detail.name)
                            .bold()
                    }
                }
            }
            if !detail.vehicles.isEmpty {
                Section(header: Text("Vehicles")) {
                    ForEach(detail.vehicles) { vehicle in
                        HStack {
                            Text(vehicle.name)
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}
