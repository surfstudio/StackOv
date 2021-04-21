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
@_exported import ThreadStore
@_exported import FavoriteStore
@_exported import SidebarStore
@_exported import CommentsStore

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
        
		container.register(ThreadStore.self) { resolver, model in
            ThreadStore(model: model, dataManager: resolver.resolve(ThreadDataManager.self)!)
        }.inObjectScope(.transient)
        
        container.register(FilterStore.self) { resolver in
            FilterStore()
        }.inObjectScope(.transient)
        
        container.register(SidebarStore.self) { resolver in
            SidebarStore()
        }.inObjectScope(.weak)
        
        container.register(FavoriteStore.self) { resolver in
            FavoriteStore(dataManager: resolver.resolve(FavoriteDataManager.self)!)
        }.inObjectScope(.transient)
        
        container.register(CommentsStore.self) { resolver, model in
            CommentsStore(model: model)
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
