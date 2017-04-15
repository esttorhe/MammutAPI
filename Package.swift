// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "MammutAPI",
    targets: {
      return [
        Target(name: "MammutAPI"),
        Target(name: "MammutAPITests", dependencies: [ "MammutAPI" ])
      ]
    }(),
    exclude: [
      "Tests/Mocks"
    ]
)
