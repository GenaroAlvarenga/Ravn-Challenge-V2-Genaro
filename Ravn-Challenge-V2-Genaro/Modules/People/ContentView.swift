//
//  ContentView.swift
//  Ravn-Challenge-V2-Genaro
//
//  Created by Genaro Alvarenga on 11/6/20.
//

import SwiftUI

struct ContentView: View {
    let request = PeopleViewModel()
    var body: some View {
        Text("Hello, world!")
            .padding()
        Button("Request") {
            request.fetchPeople()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
