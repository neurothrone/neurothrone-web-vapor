//
//  File.swift
//  
//
//  Created by Zaid Neurothrone on 2022-11-24.
//

import Vapor

struct WebsiteController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    routes.get(use: index)
  }
  
  private func index(_ req: Request) async throws -> View {
    let context = IndexContext()
    return try await req.view.render("index", context)
  }
}

struct IndexContext: Encodable {
  let title = "Home"
  let year: String = Date.now.formatted(.dateTime.year(.defaultDigits))
}
