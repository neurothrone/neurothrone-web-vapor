import Fluent
import Vapor

func routes(_ app: Application) throws {
  //    try app.register(collection: TodoController())
  try app.register(collection: WebsiteController())
  try app.register(collection: WebsiteProjectsController())
  try app.register(collection: GasvoController())
}
