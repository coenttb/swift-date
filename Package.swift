// swift-tools-version:5.10.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

extension String {
    static let date: Self = "Date"
}

extension Target.Dependency {
    static var date: Self { .target(name: .date) }
    
}

extension Target.Dependency {
//    static var malcommacSwiftDate: Self {
//        .product(
//            name: "SwiftDate",
//            package: "SwiftDate",
//            moduleAliases: [
//                "SwiftDate" : "MalcommacSwiftDate"
//            ]
//        )
//    }
    
    static let time: Self = .product(name: "Time", package: "Time")
    
    static var dependencies: Self { .product(name: "Dependencies", package: "swift-dependencies") }
}

extension [Target.Dependency] {
    static var shared: Self {
        [
//            .malcommacSwiftDate,
            .dependencies
        ]
    }
}

extension [Package.Dependency] {
    static var `default`: Self {
        [
            .package(url: "https://github.com/apple/swift-collections.git", from: "1.1.2"),
            .package(url: "https://github.com/pointfreeco/swift-dependencies.git", from: "1.3.5"),
//            .package(url: "https://github.com/malcommac/SwiftDate.git", from: "7.0.0"),
            .package(url: "https://github.com/davedelong/time", from: "1.0.0")
        ]
    }
}

struct CustomTarget {
    let name: String
    var library: Bool = true
    var dependencies: [Target.Dependency] = []
}

extension Package {
    static func date(
        targets: [CustomTarget]
    ) -> Package {
        return Package(
            name: "swift-date",
            platforms: [
                .macOS(.v13),
                .iOS(.v16),
                .tvOS(.v16),
                .watchOS(.v9),
                .macCatalyst(.v16),
            ],
            products: [
                .library(
                    name: .date,
                    targets:  targets.filter{ $0.library }.map(\.name).map { target in
                        "\(target)"
                    }
                )
            ],
            dependencies: .default,
            targets: [
                targets.map { target in
                    Target.target(
                        name: "\(target.name)",
                        dependencies: .shared + [] + target.dependencies
                    )
                },
                targets.map { target in
                    Target.testTarget(
                        name: "\(target.name) Tests",
                        dependencies: [.init(stringLiteral: target.name)]
                    )
                }
            ].flatMap { $0
            }
        )
    }
}

let package = Package.date(
    targets: [
        .init(
            name: .date,
            library: true,
            dependencies: [
//                .malcommacSwiftDate
                .time
            ]
        ),
    ]
)
