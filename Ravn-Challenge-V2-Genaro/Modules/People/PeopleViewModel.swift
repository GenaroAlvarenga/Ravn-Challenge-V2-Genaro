//
//  PeopleViewModel.swift
//  Ravn-Challenge-V2-Genaro
//
//  Created by Genaro Alvarenga on 11/7/20.
//

import Foundation
import Combine
import CombineExt

enum CustomError: Error {
    case noConnection
    case emptyData
    case custom(String)
}

class PeopleViewModel: ObservableObject {
    @Published var people = [StarWarsPerson]()
    @Published var isLoading = false
    @Published var error: Error = CustomError.noConnection
    @Published var cantLoadMore = true
    private let peopleService: PeopleServiceType
    
    let fetchPeopleRequest = PassthroughRelay<Void>()
    private var subscriptions = Set<AnyCancellable>()
    
    init(peopleService: PeopleServiceType = PeopleService()) {
        self.peopleService = peopleService
        
        let fetchPeopleResult = fetchPeopleRequest
            .flatMapLatest {
                peopleService.getPeople().materialize()
            }.share()
        
        let searchSucces = fetchPeopleResult
            .values()
            .sink(receiveValue: { [weak self] newPeople in
                self?.people.append(contentsOf: newPeople)
                self?.cantLoadMore = self?.peopleService.cantLoadMore ?? true
            })
            .store(in: &subscriptions)

        let searchFailure = fetchPeopleResult
            .failures()
            .assign(to: \.error, on: self, ownership: .weak)
            .store(in: &subscriptions)
        
        fetchPeopleRequest
            .map { _ in true }
            .merge(with: fetchPeopleResult.map { _ in false })
            .assign(to: \.isLoading, on: self, ownership: .weak)
            .store(in: &subscriptions)
        
    }

    func fetchPeople() {
        if !isLoading, peopleService.cantLoadMore {
            isLoading.toggle()
            fetchPeopleRequest.accept()
        }
    }
}
