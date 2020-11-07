//
//  PeopleService.swift
//  Ravn-Challenge-V2-Genaro
//
//  Created by Genaro Alvarenga on 11/7/20.
//

import Combine

protocol PopleServiceType {
    func getPeople() ->  AnyPublisher<[AllPeopleQuery.Data.AllPerson.Person], Error>
}

class PopleService: PopleServiceType {
    private var lastConnection: AllPeopleQuery.Data.AllPerson.PageInfo?
    private let requester: RequesterType
    
    init(requester: RequesterType = Requester()) {
        self.requester = requester
    }
    
    func getPeople() ->  AnyPublisher<[AllPeopleQuery.Data.AllPerson.Person], Error> {
        requester.requestfetch(query: AllPeopleQuery(number: 5,
                                                     cursor: lastConnection?.startCursor)).map { [weak self] result in
                                                        self?.lastConnection = result.data?.allPeople?.pageInfo
                                                        if let people = result.data?.allPeople?.people {
                                                            return people.compactMap { $0 }
                                                        }
                                                        return []
                                                     }.eraseToAnyPublisher()
    }
}
