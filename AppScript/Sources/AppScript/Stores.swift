//
//  Stores.swift
//  This source file is part of the StackOv open source project
//

import Swinject
import StackexchangeNetworkService

@_exported import PageStore

// MARK: - Stores Assembly

final class StoresAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(PageStore.self) { resolver in
            PageStore(dataManager: resolver.resolve(PageDataManager.self)!)
        }.inObjectScope(.weak)
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
