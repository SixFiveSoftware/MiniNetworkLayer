//
//  JSONPlaceholderTodo.swift
//  MiniNetworkLayer
//
//  Created by BJ Miller on 7/2/20.
//  Copyright © 2020 BJ Miller. All rights reserved.
//

import Foundation

struct JSONPlaceholderTodo: Decodable {
  let userId: Int
  let id: Int
  let title: String
  let completed: Bool
}
