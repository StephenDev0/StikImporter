// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "StikImporter",
    platforms: [
        .iOS(.v14),       // Supports iOS 14 and above
        .macOS(.v11),     // Supports macOS 11 and above
        .tvOS(.v14),      // Optional: Supports tvOS 14 and above
        .watchOS(.v7)     // Optional: Supports watchOS 7 and above
    ],
    products: [
        .library(
            name: "StikImporter",
            targets: ["StikImporter"]
        ),
    ],
    dependencies: [
        // No external dependencies
    ],
    targets: [
        .target(
            name: "StikImporter",
            dependencies: []
        ),
        .testTarget(
            name: "StikImporterTests",
            dependencies: ["StikImporter"]
        ),
    ]
)

