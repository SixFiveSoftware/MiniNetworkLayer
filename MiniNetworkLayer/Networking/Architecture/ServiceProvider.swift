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

class ServiceProvider {
  let urlSession = URLSession.shared

  func load<ServiceType>(service: ServiceType) -> Promise<ServiceType.ResponseType> where ServiceType: Service {
    call(service.urlRequest)
      .then { (data) -> Promise<ServiceType.ResponseType> in
        do {
          let object = try ServiceType.ResponseType.decoder.decode(ServiceType.ResponseType.self, from: data)
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
