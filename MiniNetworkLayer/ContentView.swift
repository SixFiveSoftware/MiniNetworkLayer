//
//  ContentView.swift
//  MiniNetworkLayer
//
//  Created by BJ Miller on 7/2/20.
//  Copyright © 2020 BJ Miller. All rights reserved.
//

import SwiftUI
import PromiseKit

struct ContentView: View {
  @ObservedObject var viewModel = ViewModel()

  var body: some View {
    Group {
      if viewModel.shouldShowTodo {
        VStack {
          Text("userId: \(viewModel.model!.userId)")
          Text("id: \(viewModel.model!.id)")
          Text("title: \(viewModel.model!.title)")
          Text("completed: \(viewModel.model!.completed.description)")
        }
      } else {
        Text("Awaiting content...")
      }
    }
    .onAppear {
      self.viewModel.onLoad()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

class ViewModel: ObservableObject {
  @Published private(set) var model: JSONPlaceholderTodo?
  var shouldShowTodo: Bool { model != nil }

  private let provider = ServiceProvider<JSONPlaceholderService>()

  func onLoad() {
    print("starting to load...")
    provider.loadDecodable(service: .getTodo(1), decodeType: JSONPlaceholderTodo.self)
      .done { print("successfully loaded"); self.model = $0 }
      .catch { print("error: \($0.localizedDescription)") }
  }
}
