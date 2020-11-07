//
//  PeopleViewModel.swift
//  Ravn-Challenge-V2-Genaro
//
//  Created by Genaro Alvarenga on 11/7/20.
//

import Foundation
import Combine

class PeopleViewModel {
    private var people = [AllPeopleQuery.Data.AllPerson.Person]()
    private var isLoading = false
    private var subscriptions = Set<AnyCancellable>()
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
        peopleService.getPeople().sink { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .finished:
                print("Nothing")
            }
            self?.isLoading.toggle()
        } receiveValue: { [weak self] people in
            self?.people.append(contentsOf: people)
        }
        .store(in: &subscriptions)
    }
}
