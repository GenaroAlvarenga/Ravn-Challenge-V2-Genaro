//
//  PeopleDetailService.swift
//  Ravn-Challenge-V2-Genaro
//
//  Created by Genaro Alvarenga on 11/7/20.
//

import Combine
import Apollo

protocol PeopleDetailServiceType {
    func getDetail(from identifier: GraphQLID) ->  AnyPublisher<StarWarsPersonDetail, Error>
}

class PeopleDetailService: PeopleDetailServiceType {
    private let requester: RequesterType
    
    init(requester: RequesterType = Requester()) {
        self.requester = requester
    }
    
    func getDetail(from identifier: GraphQLID)  ->  AnyPublisher<StarWarsPersonDetail, Error> {
        requester.requestfetch(query: PersonDetailQuery(id: identifier))
            .tryMap { result in
                if let person = result.data?.person {
                    return StarWarsPersonDetail(person)
                } else {
                    // thow error if the API return empty data
                    throw result.errors?.description != nil ?
                    CustomError.custom(result.errors?.description ?? "") :
                    CustomError.emptyData
                }
            }
            .eraseToAnyPublisher()
    }
}
