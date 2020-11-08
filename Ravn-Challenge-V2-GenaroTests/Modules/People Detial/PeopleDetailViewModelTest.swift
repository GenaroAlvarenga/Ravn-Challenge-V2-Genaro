//
//  PeopleDetailViewModelTest.swift
//  Ravn-Challenge-V2-GenaroTests
//
//  Created by Genaro Alvarenga on 11/8/20.
//

import XCTest

import XCTest
import Combine
import Apollo
@testable import Ravn_Challenge_V2_Genaro

class PeopleDetailViewModelTest: XCTestCase {

    func testRequestPeople() {
        // given
        let expectedResult: StarWarsPersonDetail = .init(name: "Mock",
                                                         eyeColor: "Brown",
                                                         hairColor: "Black",
                                                         skinColor: nil,
                                                         birthYear: nil,
                                                         vehicles: [.init(name: "Falcon")])
        let service = PeopleDetailServiceMock(expectedResult: expectedResult)
        let viewModel = PeopleDetailViewModel(detailService: service, peopleID: "")
        
        // when
        viewModel.fetchPeopleRequest.accept()
        _ = XCTWaiter.wait(for: [XCTestExpectation()], timeout: 0.1)
        
        // then
        XCTAssertEqual(expectedResult.name, viewModel.detail.name, "The viewmodel dont present the expected detail name")
    }
    
    func testRequestError() {
        // given
        let service = PeopleDetailServiceErrorMock()
        let viewModel = PeopleDetailViewModel(detailService: service, peopleID: "")
        
        // when
        viewModel.fetchPeopleRequest.accept()
        _ = XCTWaiter.wait(for: [XCTestExpectation()], timeout: 0.1)
        
        // then
        XCTAssertNotNil(viewModel.error, "The viewmodel dont present the error")
        XCTAssertTrue(viewModel.showAlert, "The viewmodel dont show the alert")
    }
}

extension PeopleDetailViewModelTest {
    enum MockErrors: Error {
        case mock
    }

    struct PeopleDetailServiceMock: PeopleDetailServiceType {
        let expectedResult: StarWarsPersonDetail
        
        func getDetail(from identifier: GraphQLID) -> AnyPublisher<StarWarsPersonDetail, Error> {
            Just(expectedResult)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    struct PeopleDetailServiceErrorMock: PeopleDetailServiceType {
        func getDetail(from identifier: GraphQLID) -> AnyPublisher<StarWarsPersonDetail, Error> {
            Fail(error: MockErrors.mock)
                .eraseToAnyPublisher()
        }
    }
}
