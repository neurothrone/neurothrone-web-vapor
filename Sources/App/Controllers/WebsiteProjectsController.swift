//
//  WebsiteProjectsController.swift
//  
//
//  Created by Zaid Neurothrone on 2022-12-05.
//

import Foundation
import Vapor

struct WebsiteProjectsController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let mainRoutes = routes.grouped("app")
    
    mainRoutes.get("gasvo", use: gasvoPage)
    mainRoutes.get("fast-track", use: fastTrackPage)
    mainRoutes.get("we-inventory", use: weInventoryPage)
  }
  
  private func gasvoPage(_ req: Request) async throws -> View {
    let context = IndexContext()
    return try await req.view.render("Projects/gasvo", context)
  }
  
  private func fastTrackPage(_ req: Request) async throws -> View {
    let context = AboutContext()
    return try await req.view.render("Projects/fast-track", context)
  }
  
  private func weInventoryPage(_ req: Request) async throws -> View {
    let context = ContactContext()
    return try await req.view.render("Projects/we-inventory", context)
  }
}

struct GasVoContext: Encodable {
  let title = "GasVo"
  let now = Date()
  let activePage: ActivePage.Project = .gasvo
}

struct FastTrackContext: Encodable {
  let title = "FastTrack"
  let now = Date()
  let activePage: ActivePage.Project = .fastTrack
}

struct WeInventoryContext: Encodable {
  let title = "WeInventory"
  let now = Date()
  let activePage: ActivePage.Project = .weInventory
}
