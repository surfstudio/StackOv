//
//  Stores.swift
//  StackOv (AppScript module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Swinject
import StackexchangeNetworkService

@_exported import PageStore
@_exported import PostStore

// MARK: - Stores Assembly

final class StoresAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(PageStore.self) { resolver in
            PageStore(dataManager: resolver.resolve(PageDataManager.self)!)
        }.inObjectScope(.transient)
        
        container.register(PostStore.self) { resolver, model in
            PostStore(model: model)
        }.inObjectScope(.transient)
    }
}

// MARK: - Stores Assembler

public struct StoresAssembler {
    
    public static var shared: Resolver {
        assembler.resolver
    }
    
    public static let assembler: Assembler = {
        Assembler([
            StoresAssembly()
        ], parent: ServicesAssembler.assembler)
    }()
}
