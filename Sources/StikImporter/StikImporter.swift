// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI
import UniformTypeIdentifiers

public extension UTType {
    static let plist                = UTType(filenameExtension: "plist", conformingTo: .data)             ?? .data
    static let mobileDevicePairing  = UTType(filenameExtension: "mobiledevicepairing", conformingTo: .data) ?? .data
    static let p12                  = UTType(filenameExtension: "p12", conformingTo: .data)               ?? .data
    static let mobileProvision      = UTType(filenameExtension: "mobileprovision", conformingTo: .data)   ?? .data
    static let ipa: UTType          = UTType(filenameExtension: "ipa", conformingTo: .zip)               ??
                                       UTType(filenameExtension: "ipa", conformingTo: .data)             ??
                                       .data
}

public struct StikImporter: View {
    @Binding public var isPresented: Bool
    @Binding public var selectedURLs: [URL]
    
    public let allowedContentTypes: [UTType]
    public let allowsMultipleSelection: Bool
    public let onImport: ([URL]) -> Void
    
    public init(
        isPresented: Binding<Bool>,
        selectedURLs: Binding<[URL]>,
        allowedContentTypes: [UTType] = [
            .item,
            .plist,
            .mobileDevicePairing,
            .p12,
            .mobileProvision,
            .ipa
        ],
        allowsMultipleSelection: Bool = false,
        onImport: @escaping ([URL]) -> Void = { _ in }
    ) {
        self._isPresented = isPresented
        self._selectedURLs = selectedURLs
        self.allowedContentTypes = allowedContentTypes
        self.allowsMultipleSelection = allowsMultipleSelection
        self.onImport = onImport
    }
    
    public var body: some View {
        Color.clear
            .fileImporter(
                isPresented: $isPresented,
                allowedContentTypes: allowedContentTypes,
                allowsMultipleSelection: allowsMultipleSelection,
                onCompletion: handleImport
            )
    }
    
    private func handleImport(_ result: Result<[URL], Error>) {
        isPresented = false
        
        guard case let .success(urls) = result else {
            if case let .failure(error) = result {
                print("StikImporter Error:", error.localizedDescription)
            }
            return
        }
        
        let accessible = urls.filter { url in
            url.startAccessingSecurityScopedResource()
        }
        
        selectedURLs = accessible
        onImport(accessible)
        
        accessible.forEach { $0.stopAccessingSecurityScopedResource() }
    }
}
