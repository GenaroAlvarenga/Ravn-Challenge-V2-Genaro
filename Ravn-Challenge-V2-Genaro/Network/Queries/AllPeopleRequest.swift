//
//  AllPeopleRequest.swift
//  Ravn-Challenge-V2-Genaro
//
//  Created by Genaro Alvarenga on 11/7/20.
//

import Foundation
import Apollo

class AllPeopleRequest {
    private var lastConnection: AllPeopleQuery.Data.AllPerson.PageInfo?
    private var activeRequest: Cancellable?
    private var people = [AllPeopleQuery.Data.AllPerson.Person]()
    private var isLoading = false
    
    func fetchPeople() {
        if !isLoading {
            isLoading.toggle()
            getAllPeople(from: lastConnection?.startCursor)
        }
    }
    
    func getAllPeople(from cursor: String?) {
        Network.shared.apollo.fetch(query: AllPeopleQuery(number: 5, cursor: cursor)) { [weak self] result in
            switch result {
            case .failure(let error):
                print("Failure! Error: \(error)")
            case .success(let graphQLResult):
                if let launchConnection = graphQLResult.data?.allPeople, let people = launchConnection.people {
                    self?.lastConnection = launchConnection.pageInfo
                    self?.people.append(contentsOf: people.compactMap { $0 })
                }
                
                if let errors = graphQLResult.errors {
                    let message = errors
                        .map { $0.localizedDescription }
                        .joined(separator: "\n")
                    print(message)
                }
            }
            self?.isLoading.toggle()
        }
    }
}
