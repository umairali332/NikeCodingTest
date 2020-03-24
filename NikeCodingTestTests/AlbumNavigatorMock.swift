//
//  AlbumNavigatorMock.swift
//  NikeCodingTestTests
//
//  Created by Umair Ali on 23/03/2020.
//  Copyright © 2020 Umair Ali. All rights reserved.
//

@testable import NikeCodingTest

final class AlbumNavigatorMock: AlbumNavigating {
    private(set) var showAlbumDetailTriggered = false
    private(set) var showAlertTriggered = false
    
    func showAlbumDetail(forAlbum album: Album) {
        showAlbumDetailTriggered = true
    }
    
    func showAlert(withError error: Error) {
        showAlertTriggered = true
    }
}
