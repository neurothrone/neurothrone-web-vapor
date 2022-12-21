//
//  GasvoController.swift
//  
//
//  Created by Zaid Neurothrone on 2022-12-21.
//


import Foundation
import Vapor

import GVCCore
import Vapor

struct GasvoController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let mainRoutes = routes.grouped("app")
    
    mainRoutes.get("gasvo-web", use: indexHandler)
    mainRoutes.post("gasvo-web", use: calculateHandler)
  }
  
  private func indexHandler(_ req: Request) async throws -> View {
    let context = Gasvo.Web.IndexContext()
    return try await req.view.render("Apps/Gasvo/gasvo-web", context)
  }
  
  private func calculateHandler(_ req: Request) async throws -> Gasvo.Web.OutData {
    let inData = try req.content.decode(Gasvo.Web.InData.self)
    
    guard let nps = NPSSelection(rawValue: inData.nps) else {
      return Gasvo.Web.OutData(
        gasVolume: .zero,
        isValid: false
      )
    }
    
    let length = inData.length
    let pressure: Double
    
    if inData.pressureSelection == PressureSelection.custom.rawValue {
      guard let unwrappedPressure = inData.customPressure.toDouble() else {
        return Gasvo.Web.OutData(
          gasVolume: .zero,
          isValid: false
        )
      }
      
      pressure = unwrappedPressure
    } else {
      guard let unwrappedPressure = inData.pressureSelection.toDouble() else {
        return Gasvo.Web.OutData(
          gasVolume: .zero,
          isValid: false
        )
      }
      
      pressure = unwrappedPressure
    }
    
    let gasVolume = GVCCore.calculateGasVolume(nps: nps, length: length, pressure: pressure)
    
    return Gasvo.Web.OutData(
      gasVolume: gasVolume,
      isValid: true
    )
  }
}

enum Gasvo {
  enum Web {
    struct IndexContext: Encodable {
      let title: String = "GasVo"
      let npsOptions: [NPSOption] =
      NPSSelection.allCases.map { NPSOption(value: $0.rawValue, text: $0.toString) }
      let pressureOptions: [String] = PressureSelection.allCases.map { $0.toString }
      let gasVolume: Double = .zero
      let now = Date()
    }

    struct SuccessResultContext: Encodable {
      let title: String = "GasVo"
      let npsOptions: [NPSOption] =
      NPSSelection.allCases.map { NPSOption(value: $0.rawValue, text: $0.toString) }
      let pressureOptions: [String] = PressureSelection.allCases.map { $0.toString }
      let gasVolume: Double
      
    }

    struct NPSOption: Encodable {
      let value: Int
      let text: String
    }

    struct InData: Content {
      let nps: Int
      let length: Double
      let pressureSelection: String
      var customPressure: String
    }

    struct OutData: Content {
      let gasVolume: Double
      let isValid: Bool
    }
  }
}
