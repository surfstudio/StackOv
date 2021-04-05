//
//  Stores.swift
//  StackOv (AppScript module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Swinject
import StackexchangeNetworkService

@_exported import GlobalBannerStore
@_exported import PageStore
@_exported import FilterStore
@_exported import PostStore
@_exported import FavoriteStore

// MARK: - Stores Assembly

final class StoresAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(GlobalBannerStore.self) { resolver in
            GlobalBannerStore()
        }.inObjectScope(.weak)
        
        container.register(PageStore.self) { resolver in
            PageStore(dataManager: resolver.resolve(PageDataManager.self)!,
                      filterStore: resolver.resolve(FilterStore.self)!)
        }.inObjectScope(.transient)
        
		container.register(PostStore.self) { resolver, model in
            PostStore(model: model)
        }.inObjectScope(.transient)
        
        container.register(FilterStore.self) { resolver in
            FilterStore()
        }.inObjectScope(.transient)
        
        container.register(FavoriteStore.self) { resolver in
            FavoriteStore(dataManager: resolver.resolve(FavoriteDataManager.self)!)
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
