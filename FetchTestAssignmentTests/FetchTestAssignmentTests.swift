//
//  FetchTestAssignmentTests.swift
//  FetchTestAssignmentTests
//
//  Created by саргашкаева on 17.05.2023.
//

import XCTest
@testable import FetchTestAssignment

final class FetchTestAssignmentTests: XCTestCase {

    func testMealsNetworkRequest() throws {
        let mockService = MockNetworkService()
        let viewModel = DessertViewViewModel()
        viewModel.networkService = mockService
        
        let expectation = XCTestExpectation(description: "getDesserts")
        viewModel.getDessert {
            expectation.fulfill()
        }
        wait(for: [expectation])
        let desserts = try XCTUnwrap(viewModel.allDesserts)
        XCTAssertFalse(desserts.isEmpty)
    }

}
