//
//  Services.swift
//  This source file is part of the StackOv open source project
//

import Swinject
import StackexchangeNetworkService
import class PageStore.PageDataManager

// MARK: - Services Assembly

final class ServicesAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(StackexchangeNetworkService.self) { _ in
            StackexchangeNetworkService()
        }.inObjectScope(.weak)
        
        container.register(PageDataManager.self) { resolver in
            PageDataManager(service: resolver.resolve(StackexchangeNetworkService.self)!)
        }.inObjectScope(.weak)
    }
}

// MARK: - Services Assembler

public struct ServicesAssembler {
    
    public static var shared: Resolver {
        assembler.resolver
    }
    
    public static let assembler: Assembler = {
        Assembler([
            ServicesAssembly()
        ])
    }()
}
