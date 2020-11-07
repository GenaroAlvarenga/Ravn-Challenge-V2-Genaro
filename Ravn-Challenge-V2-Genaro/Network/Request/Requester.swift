//
//  Requester.swift
//  Ravn-Challenge-V2-Genaro
//
//  Created by Genaro Alvarenga on 11/7/20.
//

import Foundation
import Combine
import Apollo

protocol RequesterType {
    func requestfetch<Query: GraphQLQuery>(query: Query) -> AnyPublisher<GraphQLResult<Query.Data>, Error>
}

struct Requester: RequesterType {
    func requestfetch<Query: GraphQLQuery>(query: Query) -> AnyPublisher<GraphQLResult<Query.Data>, Error> {
        return Deferred {
            Future { promise in
                Network.shared.apollo.fetch(query: query) { result in
                    switch result {
                    case .failure(let error):
                        promise(.failure(error))
                    case .success(let graphQLResult):
                        promise(.success(graphQLResult))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}

