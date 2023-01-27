//
//  File.swift
//  
//
//  Created by Zaid Neurothrone on 2022-11-24.
//

import Foundation
import Vapor

enum ActivePage: String, Encodable {
  case index,
       about,
       contact,
       cv,
       portfolio
  
  enum Project: String, Encodable {
    case gasvo,
         fastTrack,
         weInventory,
         workWork
  }
}

struct WebsiteController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let mainRoutes = routes.grouped("")
    
    mainRoutes.get(use: index)
    mainRoutes.get("about", use: about)
    mainRoutes.get("contact", use: contact)
    mainRoutes.get("cv", use: cv)
    mainRoutes.get("portfolio", use: portfolio)

//    routes.get(use: index)

  }
  
  private func index(_ req: Request) async throws -> View {
    let context = IndexContext()
    return try await req.view.render("index", context)
  }
  
  private func about(_ req: Request) async throws -> View {
    let context = AboutContext()
    return try await req.view.render("about", context)
  }
  
  private func contact(_ req: Request) async throws -> View {
    let context = ContactContext()
    return try await req.view.render("contact", context)
  }
  
  private func cv(_ req: Request) async throws -> View {
    let context = CVContext()
    return try await req.view.render("cv", context)
  }
  
  private func portfolio(_ req: Request) async throws -> View {
    let context = PortfolioContext()
    return try await req.view.render("portfolio", context)
  }
}

struct IndexContext: Encodable {
  let title = "Neurothrone"
  let now = Date()
  let activePage: ActivePage = .index
}

struct AboutContext: Encodable {
  let title = "About Me"
  let now = Date()
  let activePage: ActivePage = .about
}

struct ContactContext: Encodable {
  let title = "Contact Me"
  let now = Date()
  let activePage: ActivePage = .contact
}


struct CVContext: Encodable {
  let title = "CV"
  let now = Date()
  let activePage: ActivePage = .cv
}

struct PortfolioContext: Encodable {
  let title = "Portfolio"
  let now = Date()
  let activePage: ActivePage = .portfolio
}
