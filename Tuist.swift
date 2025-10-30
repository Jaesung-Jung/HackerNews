import ProjectDescription

let tuist = Tuist(
  project: .tuist(
    swiftVersion: "6.0",
    generationOptions: .options(includeGenerateScheme: false)
  )
)
