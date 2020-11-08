//
//  PeopleViewModel.swift
//  Ravn-Challenge-V2-Genaro
//
//  Created by Genaro Alvarenga on 11/7/20.
//

import Foundation
import Combine

enum CustomError: Error {
    case noConnection
}

class PeopleViewModel: ObservableObject {
    @Published var people = [StarWarsPerson]()
    @Published var isLoading = false
    @Published var error: Error = CustomError.noConnection
    private let peopleService: PopleServiceType
    
    init(peopleService: PopleServiceType = PopleService()) {
        self.peopleService = peopleService
    }

    func fetchPeople() {
        if !isLoading {
            isLoading.toggle()
            getAllPeople()
        }
    }
    
    // Example of service
    func getAllPeople() {
//        peopleService.getPeople().sink { [weak self] result in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .finished:
//                print("Nothing")
//            }
//            self?.isLoading.toggle()
//        } receiveValue: { [weak self] people in
//            self?.people.append(contentsOf: people)
//        }
//        .store(in: &subscriptions)
    }
}
