//
//  Request+Extension.swift
//  StackOv (StackexchangeNetworkService module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import Network

extension Request {
    
    func produceJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }
    
}
