import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) throws {
  // uncomment to serve files from /Public folder
  app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
  
  // TODO: Enable only when database is required
//  if let databaseURL = Environment.get("DATABASE_URL"),
//     var postgresConfig = PostgresConfiguration(url: databaseURL) {
//    postgresConfig.tlsConfiguration = .makeClientConfiguration()
//    postgresConfig.tlsConfiguration?.certificateVerification = .none
//    app.databases.use(.postgres(configuration: postgresConfig), as: .psql)
//  } else {
//    app.databases.use(.postgres(
//      hostname: Environment.get("DATABASE_HOST") ?? "localhost",
//      port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
//      username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
//      password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
//      database: Environment.get("DATABASE_NAME") ?? "vapor_database"
//    ), as: .psql)
//  }
  
  //  app.migrations.add(CreateTodo())
  
  app.views.use(.leaf)
  
  // Set log level
//  app.logger.logLevel = .debug
  
  // register routes
  try routes(app)
  
  // This will run the migrations on every app launch
//  try app.autoMigrate().wait()
}
