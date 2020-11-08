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
                    PersonCell(person: person)
                    .onAppear(perform: {
                        if viewModel.people.last == person {
                            viewModel.fetchPeople()
                        }
                    })
                    .padding(.all, 10)
                }
                if !(viewModel.error is CustomError) {
                    Text(viewModel.error.localizedDescription)
                        .foregroundColor(.red)
                        .padding(.all, 10)
                } else if viewModel.cantLoadMore {
                    LoadingView()
                }
            }
            .navigationBarTitle(Localizable.peopleHeader,
                                displayMode: .inline)
            .onAppear(perform: { viewModel.fetchPeople() })
        }
        
        .statusBar(hidden: true)
    }
}

struct PersonCell: View {
    let person: StarWarsPerson

    var body: some View {
        NavigationLink(
            destination: PeopleDetailView(viewModel: PeopleDetailViewModel(peopleID: person.id),
                                          name: person.name)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(person.name)
                        .bold()
                    Text(person.species)
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
        }
    }
}

struct LoadingView: View {
    var body: some View {
        HStack {
            Spacer()
            ProgressView()
            Text("Loading")
                .foregroundColor(.gray)
                .padding(.leading, 10)
            Spacer()
        }
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
