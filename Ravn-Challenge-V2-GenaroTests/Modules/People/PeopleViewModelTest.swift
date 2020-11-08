//
//  PeopleViewModelTest.swift
//  Ravn-Challenge-V2-GenaroTests
//
//  Created by Genaro Alvarenga on 11/7/20.
//

import XCTest
import Combine
@testable import Ravn_Challenge_V2_Genaro

class PeopleViewModelTest: XCTestCase {

    func testRequestPeople() {
        // given
        let expectedResult: [StarWarsPerson] = [.init(id: "123", name: "mock", species: "species")]
        let service = PopleServiceMock(expectedResult: expectedResult)
        let viewModel = PeopleViewModel(peopleService: service)
        
        // when
        viewModel.fetchPeople()
        _ = XCTWaiter.wait(for: [XCTestExpectation()], timeout: 0.1)
        
        // then
        XCTAssertEqual(expectedResult, viewModel.people, "The service dont present the expected people")
    }
    
    func testDontRequestMoreIfCantLoadMore() {
        // given
        let expectedResult: [StarWarsPerson] = [.init(id: "123", name: "mock", species: "species")]
        let service = PopleServiceMock(cantLoadMore: false, expectedResult: expectedResult)
        let viewModel = PeopleViewModel(peopleService: service)
        
        // when
        viewModel.fetchPeople()
        _ = XCTWaiter.wait(for: [XCTestExpectation()], timeout: 0.1)
        
        // then
        XCTAssertTrue(viewModel.people.isEmpty, "The service fetch more people")
    }

    func testPresentExpectedError() {
        // given
        let expectedResult: [StarWarsPerson] = [.init(id: "123", name: "mock", species: "species")]
        let service = PopleServiceErrorMock(expectedResult: expectedResult)
        let viewModel = PeopleViewModel(peopleService: service)
        
        // when
        viewModel.fetchPeople()
        _ = XCTWaiter.wait(for: [XCTestExpectation()], timeout: 0.1)
        
        // then
        XCTAssertTrue(viewModel.people.isEmpty, "The service fetch more people")
        XCTAssertTrue(viewModel.error is MockErrors, "The service fetch more people")
    }
}

extension PeopleViewModelTest {
    enum MockErrors: Error {
        case mock
    }

    struct PopleServiceMock: PeopleServiceType {
        var cantLoadMore: Bool = true
        let expectedResult: [StarWarsPerson]
        
        func getPeople() -> AnyPublisher<[StarWarsPerson], Error> {
            Just(expectedResult)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    struct PopleServiceErrorMock: PeopleServiceType {
        var cantLoadMore: Bool = true
        let expectedResult: [StarWarsPerson]
        
        func getPeople() -> AnyPublisher<[StarWarsPerson], Error> {
            Fail(error: MockErrors.mock)
                .eraseToAnyPublisher()
        }
    }
}
