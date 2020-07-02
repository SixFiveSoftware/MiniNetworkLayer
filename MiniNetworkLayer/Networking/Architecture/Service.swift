//
//  Service.swift
//  MiniNetworkLayer
//
//  Created by BJ Miller on 7/2/20.
//  Copyright © 2020 BJ Miller. All rights reserved.
//

import Foundation

protocol Service {
  var baseURL: String { get }
  var path: String { get }
  var parameters: [String: Any]? { get }
  var method: ServiceMethod { get }
  var body: Data? { get }
}

extension Service {
  public var urlRequest: URLRequest {
    guard let url = url else { fatalError("URL could not be formed") }
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.httpBody = body
    return request
  }

  private var formattedPath: String {
    path.starts(with: "/") ? path : "/" + path
  }

  private var url: URL? {
    var urlComponents = URLComponents(string: baseURL)
    urlComponents?.path = formattedPath

    if method == .get {
      if let params = parameters as? [String: String] {
        urlComponents?.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
      }
    }

    return urlComponents?.url
  }
}
