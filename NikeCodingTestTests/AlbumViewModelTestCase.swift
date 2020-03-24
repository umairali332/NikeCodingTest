//
//  AlbumViewModelTestCase.swift
//  NikeCodingTestTests
//
//  Created by Umair Ali on 23/03/2020.
//  Copyright © 2020 Umair Ali. All rights reserved.
//

import XCTest
@testable import NikeCodingTest
import Combine

final class AlbumViewModelTestCase: XCTestCase {
    private var viewModel: AlbumViewModel!
    private var albumUseCaseMock: AlbumUseCaseMock!
    private var albumNavigatorMock: AlbumNavigatorMock!
    private var cancellable: [AnyCancellable] = []
    
    override func setUp() {
        super.setUp()
        
        albumNavigatorMock = AlbumNavigatorMock()
        albumUseCaseMock = AlbumUseCaseMock()
        viewModel = AlbumViewModel(albumUseCase: albumUseCaseMock, navigator: albumNavigatorMock)
    }
    
    override func tearDown() {
        viewModel = nil
        albumNavigatorMock = nil
        albumUseCaseMock = nil
        super.tearDown()
    }
    
    func testViewModel_whenScreenAppeared_shouldHaveLoadingState() {
        //Given
        let appear = PassthroughSubject<Void, Never>()
        let selection = PassthroughSubject<Int, Never>()
        
        let input = AlbumViewModelInput(
            appear: appear.eraseToAnyPublisher(),
            selection: selection.eraseToAnyPublisher())
        
        let output = viewModel.transform(input: input)
        let expect = expectation(description: "Output sink should be called")
        
        //When
        output.sink { (state: AlbumViewModelState) in
            guard case .loading = state else { return }
            
            //Then
            expect.fulfill()
            
        }.store(in: &cancellable)
        
        appear.send(())
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testViewModel_whenServerReturnAlbums_shouldHaveShowAlbumState() {
        //Given
        albumUseCaseMock.albumsPublisher = .just(.success([]))
        let appear = PassthroughSubject<Void, Never>()
        let selection = PassthroughSubject<Int, Never>()
        
        let input = AlbumViewModelInput(
            appear: appear.eraseToAnyPublisher(),
            selection: selection.eraseToAnyPublisher())
        
        let output = viewModel.transform(input: input)
        let expect = expectation(description: "Output sink should be called")
        
        //When
        output.sink { (state: AlbumViewModelState) in
            guard case .show = state else { return }
            
            //Then
            expect.fulfill()
            
        }.store(in: &cancellable)
        
        appear.send(())
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testViewModel_whenServerReturnFailure_shouldHaveNoResultState() {
        //Given
        let appear = PassthroughSubject<Void, Never>()
        let selection = PassthroughSubject<Int, Never>()
        
        let input = AlbumViewModelInput(
            appear: appear.eraseToAnyPublisher(),
            selection: selection.eraseToAnyPublisher())
        
        let output = viewModel.transform(input: input)
        let expect = expectation(description: "Output sink should be called")
        
        //When
        output.sink { (state: AlbumViewModelState) in
            guard case .noResults = state else { return }
            
            //Then
            expect.fulfill()
            
        }.store(in: &cancellable)
        
        appear.send(())
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testViewModel_whenAlbumSelected_shouldShowAlbumDetail() {
        //Given
        albumUseCaseMock.albumsPublisher = .just(.success([.makeAlbum()]))
        let appear = PassthroughSubject<Void, Never>()
        let selection = PassthroughSubject<Int, Never>()
        
        let input = AlbumViewModelInput(
            appear: appear.eraseToAnyPublisher(),
            selection: selection.eraseToAnyPublisher())
        
        let output = viewModel.transform(input: input)
        let expect = expectation(description: "Output sink should be called")
        
        //When
        output.sink { (state: AlbumViewModelState) in
            guard case .show = state else { return }
            
            //Then
            expect.fulfill()
            
        }.store(in: &cancellable)
        
        let firstIndex = 0
        appear.send(())
        selection.send(firstIndex)
        
        XCTAssertTrue(albumNavigatorMock.showAlbumDetailTriggered)
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}


extension Album {
    static func makeAlbum() -> Album {
        .init(artistName: "",
              id: "",
              releaseDate: "",
              name: "",
              artworkUrl100: nil,
              copyright: "",
              url: nil)
    }
}
