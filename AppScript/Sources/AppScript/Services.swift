//
//  Services.swift
//  StackOv (AppScript module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Swinject
import StackexchangeNetworkService
import AuthManager
import class Common.StackexchangeAuthConfigurations
import class PageStore.PageDataManager

// MARK: - Services Assembly

final class ServicesAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(StackexchangeNetworkService.self) { _ in
            StackexchangeNetworkService()
        }.inObjectScope(.weak)
        
        container.register(AuthManager.self) { resolver in
            AuthManager(configurations: try! StackexchangeAuthConfigurations.load())
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

// MARK: - Extensions

public extension AuthManager {
    
    static func appearance() -> Self {
        ServicesAssembler.shared.resolve(Self.self)!
    }
}
