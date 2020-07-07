//
//  JSON+Extensions.swift
//  MiniNetworkLayer
//
//  Created by BJ Miller on 7/2/20.
//  Copyright © 2020 BJ Miller. All rights reserved.
//

import Foundation

extension JSONDecoder {
  static var defaultDecoder: JSONDecoder {
    let dec = JSONDecoder()
    dec.keyDecodingStrategy = .convertFromSnakeCase
    return dec
  }
}

extension JSONEncoder {
  static var defaultEncoder: JSONEncoder {
    JSONEncoder()
  }
}
