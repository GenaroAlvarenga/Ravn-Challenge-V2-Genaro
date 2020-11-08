//
//  PeopleService.swift
//  Ravn-Challenge-V2-Genaro
//
//  Created by Genaro Alvarenga on 11/7/20.
//

import Combine

protocol PopleServiceType {
    var cantLoadMore: Bool { get set }
    
    func getPeople() ->  AnyPublisher<[StarWarsPerson], Error>
}

class PopleService: PopleServiceType {
    var cantLoadMore: Bool = true
    private var lastConnection: AllPeopleQuery.Data.AllPerson.PageInfo?
    private let requester: RequesterType
    
    init(requester: RequesterType = Requester()) {
        self.requester = requester
    }
    
    func getPeople() ->  AnyPublisher<[StarWarsPerson], Error> {
        requester.requestfetch(query: AllPeopleQuery(number: 5,
                                                     cursor: lastConnection?.endCursor)).map { [weak self] result in
                                                        self?.lastConnection = result.data?.allPeople?.pageInfo
                                                        self?.cantLoadMore = result.data?.allPeople?.pageInfo.hasNextPage ?? true
                                                        if let people = result.data?.allPeople?.people {
                                                            return people.compactMap {
                                                                if let person = $0 {
                                                                    return StarWarsPerson(person)
                                                                }
                                                                return nil
                                                            }
                                                        }
                                                        return []
                                                     }.eraseToAnyPublisher()
    }
}
