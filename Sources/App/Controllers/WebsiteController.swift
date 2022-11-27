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
    let year = Calendar.current.component(.year, from: Date())
    let context = IndexContext(year: String(year))
    return try await req.view.render("index", context)
  }
  
  private func about(_ req: Request) async throws -> View {
    let year = Calendar.current.component(.year, from: Date())
    let context = AboutContext(year: String(year))
    return try await req.view.render("about", context)
  }
  
  private func contact(_ req: Request) async throws -> View {
    let year = Calendar.current.component(.year, from: Date())
    let context = ContactContext(year: String(year))
    return try await req.view.render("contact", context)
  }
  
  private func cv(_ req: Request) async throws -> View {
    let year = Calendar.current.component(.year, from: Date())
    let context = CVContext(year: String(year))
    return try await req.view.render("cv", context)
  }
  
  private func portfolio(_ req: Request) async throws -> View {
    let year = Calendar.current.component(.year, from: Date())
    let context = PortfolioContext(year: String(year))
    return try await req.view.render("portfolio", context)
  }
}

struct IndexContext: Encodable {
  let title = "Neurothrone"
  let year: String
  let activePage: ActivePage = .index
}

struct AboutContext: Encodable {
  let title = "About Me"
  let year: String
  let activePage: ActivePage = .about
}

struct ContactContext: Encodable {
  let title = "Contact Me"
  let year: String
  let activePage: ActivePage = .contact
}


struct CVContext: Encodable {
  let title = "CV"
  let year: String
  let activePage: ActivePage = .cv
}

struct PortfolioContext: Encodable {
  let title = "Portfolio"
  let year: String
  let activePage: ActivePage = .portfolio
}
