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
    let mainRoutes = routes.grouped("portfolio")
    
    mainRoutes.get("gasvo", use: gasvoPage)
    mainRoutes.get("fast-track", use: fastTrackPage)
    mainRoutes.get("we-inventory", use: weInventoryPage)
    mainRoutes.get("workwork", use: workWorkPage)
    
    mainRoutes.get("gasvo-android", use: gasvoAndroidPage)
  }
  
  private func fastTrackPage(_ req: Request) async throws -> View {
    let context = FastTrackContext()
    return try await req.view.render("Portfolio/fast-track", context)
  }
  
  private func gasvoPage(_ req: Request) async throws -> View {
    let context = Gasvo.GasVoContext()
    return try await req.view.render("Portfolio/gasvo", context)
  }
  
  private func weInventoryPage(_ req: Request) async throws -> View {
    let context = WeInventoryContext()
    return try await req.view.render("Portfolio/we-inventory", context)
  }
  
  private func workWorkPage(_ req: Request) async throws -> View {
    let context = WorkWorkContext()
    return try await req.view.render("Portfolio/workwork", context)
  }
  
  //MARK: - Android
  
  private func gasvoAndroidPage(_ req: Request) async throws -> View {
    let context = Gasvo.GasVoContext()
    return try await req.view.render("Portfolio/gasvo-android", context)
  }
}

struct FastTrackContext: Encodable {
  let title = "FastTrack"
  let now = Date()
  let activePage: ActivePage.Project = .fastTrack
}

extension Gasvo {
  struct GasVoContext: Encodable {
    let title = "GasVo"
    let now = Date()
    let activePage: ActivePage.Project = .gasvo
  }
}

struct WeInventoryContext: Encodable {
  let title = "WeInventory"
  let now = Date()
  let activePage: ActivePage.Project = .weInventory
}

struct WorkWorkContext: Encodable {
  let title = "WorkWork"
  let now = Date()
  let activePage: ActivePage.Project = .workWork
}


//MARK: - Android Apps
extension Gasvo {
  struct GasVoAndroidContext: Encodable {
    let title = "GasVo"
    let now = Date()
    let activePage: ActivePage.Project = .gasvoAndroid
  }
}
