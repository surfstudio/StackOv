//
//  TransitionStore.swift
//  StackOv
//
//  Created by Erik Basargin on 07/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI
import Combine

class TransitionStore: ObservableObject {
    @Published var deviceOrientation: UIDeviceOrientation
    @Published var userInterface: UIUserInterfaceIdiom
    @Published var displayMode: UISplitViewController.DisplayMode = .allVisible
    @Published var edgesIgnoringSafeArea: Edge.Set = []
    
    private var canceBag: Set<AnyCancellable> = []

    init() {
        self.deviceOrientation = UIDevice.current.orientation
        self.userInterface = UIDevice.current.userInterfaceIdiom
        
        updateDisplayMode()
//        updateEdgesIgnoringSafeArea()
        
        NotificationCenter.default
            .publisher(for: .deviceWillTransition)
            .sink { [unowned self] _ in
                self.onDeviceWillTransition(orientation: UIDevice.current.orientation)
            }
            .store(in: &canceBag)
    }
    
    deinit {
        canceBag.forEach { $0.cancel() }
    }
    
    func onDeviceWillTransition(orientation: UIDeviceOrientation) {
        self.deviceOrientation = orientation
        if orientation.isFlat { return }
        
        updateDisplayMode()
//        updateEdgesIgnoringSafeArea()
    }
    
    func updateDisplayMode() {
        #if targetEnvironment(macCatalyst)
        displayMode = deviceOrientation.isLandscape ? .allVisible : .primaryOverlay
        #else
        displayMode = deviceOrientation.isLandscape || userInterface.isPhone ? .allVisible : .primaryOverlay
        #endif
    }
    
    func updateEdgesIgnoringSafeArea() {
        guard userInterface.isPhone else {
            edgesIgnoringSafeArea = []
            return
        }
        switch deviceOrientation {
        case .landscapeLeft:
            edgesIgnoringSafeArea = .trailing
        case .landscapeRight:
            edgesIgnoringSafeArea = [.leading, .trailing]
        default:
            edgesIgnoringSafeArea = []
        }
    }
}

