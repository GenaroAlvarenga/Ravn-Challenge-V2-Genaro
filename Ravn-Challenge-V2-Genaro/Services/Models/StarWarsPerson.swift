//
//  StarWarsPerson.swift
//  Ravn-Challenge-V2-Genaro
//
//  Created by Genaro Alvarenga on 11/7/20.
//

import Foundation

struct StarWarsPerson: Identifiable {
    
    let id: String
    let name: String
    let species: String
    
    init(id: String, name: String, species: String) {
        self.id = id
        self.name = name
        self.species = species
    }
    
    init(_ person: AllPeopleQuery.Data.AllPerson.Person) {
        self.id = person.id
        self.name = person.name ?? ""
        self.species = person.species?.name ?? ""
    }
}
