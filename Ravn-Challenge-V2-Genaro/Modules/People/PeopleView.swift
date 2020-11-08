//
//  PeopleView.swift
//  Ravn-Challenge-V2-Genaro
//
//  Created by Genaro Alvarenga on 11/7/20.
//

import SwiftUI

struct PeopleView: View {
    @ObservedObject var viewModel: PeopleViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.people) { person in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(person.name)
                                .bold()
                            Text(person.species)
                        }
                        Spacer()
                    }
                }
                .onMove(perform: { indices, newOffset in
                    // push
                })
                LoadingView(onLoad: { viewModel.fetchPeople() })
            }
            .navigationTitle("People of Star Wars")
        }
        
        .statusBar(hidden: true)
    }
}

struct PeopleView_Previews: PreviewProvider {
    static let viewModel: PeopleViewModel = {
        let model = PeopleViewModel()
        model.people = [.init(id: "1",
                              name: "Luke Skywalker",
                              species: "Human from Tatooine"),
                        .init(id: "2",
                              name: "C-3PO",
                              species: "Human from Tatooine"),
                        .init(id: "3",
                              name: "R2-D2",
                              species: "Human from Tatooine")]
        return model
    }()
    static var previews: some View {
        PeopleView(viewModel: PeopleView_Previews.viewModel)
    }
}

struct LoadingView: View {
    let onLoad: (() -> Void)
    
    var body: some View {
        HStack {
            Spacer()
            ProgressView()
                .onAppear(perform: {
                    onLoad()
                })
            Spacer()
        }
    }
}
