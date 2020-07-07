//
//  JSONPlaceholderService.swift
//  MiniNetworkLayer
//
//  Created by BJ Miller on 7/2/20.
//  Copyright © 2020 BJ Miller. All rights reserved.
//

import Foundation

enum JSONPlaceholderService<T> where T: ResponseDecodable {
  typealias ResponseType = T

  case getTodo(Int)
  case createPost(JSONPlaceholderCreatePost)
}

extension JSONPlaceholderService: Service {
  var baseURL: String {
    "https://jsonplaceholder.typicode.com"
  }

  var path: String {
    switch self {
    case .getTodo(let id): return "todos/\(id)"
    case .createPost: return "posts"
    }
  }

  var parameters: [String : Any]? {
    nil
  }

  var method: ServiceMethod {
    switch self {
    case .getTodo: return .get
    case .createPost: return .post
    }
  }

  var body: Data? {
    switch self {
    case .getTodo: return nil
    case .createPost(let post): return try? JSONEncoder().encode(post)
    }
  }
}
