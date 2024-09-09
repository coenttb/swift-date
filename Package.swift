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
    static var dependencies: Self { .product(name: "Dependencies", package: "swift-dependencies") }
}

extension [Target.Dependency] {
    static var shared: Self {
        [
            .dependencies
        ]
    }
}

extension [Package.Dependency] {
    static var `default`: Self {
        [
            .package(url: "https://github.com/pointfreeco/swift-dependencies.git", from: "1.3.5"),
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
                .iOS(.v13),
                .macOS(.v10_15),
                .tvOS(.v13),
                .watchOS(.v6),
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

            ]
        ),
    ]
)
