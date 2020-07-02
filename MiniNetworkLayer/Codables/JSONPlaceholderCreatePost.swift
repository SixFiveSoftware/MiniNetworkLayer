//
//  JSONPlaceholderCreatePost.swift
//  MiniNetworkLayer
//
//  Created by BJ Miller on 7/2/20.
//  Copyright © 2020 BJ Miller. All rights reserved.
//

import Foundation

struct JSONPlaceholderCreatePost: Encodable {
  let title: String
  let body: String
  let userId: Int
}
