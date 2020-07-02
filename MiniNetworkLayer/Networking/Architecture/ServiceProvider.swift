//
//  ServiceProvider.swift
//  MiniNetworkLayer
//
//  Created by BJ Miller on 7/2/20.
//  Copyright © 2020 BJ Miller. All rights reserved.
//

import Foundation
import PromiseKit

enum NetworkError: Error {
  case unknown
}

class ServiceProvider<T> where T: Service {
  let urlSession = URLSession.shared

  func load(service: T) -> Promise<Data> {
    call(service.urlRequest)
  }

  func loadDecodable<ResponseType>(service: T, decodeType: ResponseType.Type) -> Promise<ResponseType> where ResponseType: Decodable {
    call(service.urlRequest)
      .then { (data) -> Promise<ResponseType> in
        do {
          let object = try JSONDecoder().decode(decodeType.self, from: data)
          return .value(object)
        } catch {
          throw error
        }
      }
  }
}

extension ServiceProvider {
  private func call(_ request: URLRequest, deliveryQueue: DispatchQueue = .main) -> Promise<Data> {
    Promise { seal in
      urlSession.dataTask(with: request) { data, _, error in
        deliveryQueue.async {
          if let err = error {
            seal.reject(err)
          } else if let data = data {
            seal.fulfill(data)
          } else {
            seal.reject(NetworkError.unknown)
          }
        }
      }.resume()
    }
  }
}
