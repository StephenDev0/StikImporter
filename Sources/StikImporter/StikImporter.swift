// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import UniformTypeIdentifiers

/// A SwiftUI view that presents a file importer sheet.
public struct StikImporter: View {
    @Binding public var isPresented: Bool
    @Binding public var selectedURLs: [URL]
    
    /// The allowed content types for the importer.
    public var allowedContentTypes: [UTType]
    
    /// Whether multiple selection is allowed.
    public var allowsMultipleSelection: Bool
    
    /// Callback with the selected URLs.
    public var onImport: (([URL]) -> Void)?
    
    /// Initializes a new StikImporter.
    /// - Parameters:
    ///   - isPresented: Binding to control the presentation.
    ///   - selectedURLs: Binding to receive the selected URLs.
    ///   - allowedContentTypes: The allowed content types.
    ///   - allowsMultipleSelection: Whether multiple selection is allowed.
    ///   - onImport: Optional callback with selected URLs.
    public init(
        isPresented: Binding<Bool>,
        selectedURLs: Binding<[URL]>,
        allowedContentTypes: [UTType] = [.item],
        allowsMultipleSelection: Bool = false,
        onImport: (([URL]) -> Void)? = nil
    ) {
        self._isPresented = isPresented
        self._selectedURLs = selectedURLs
        self.allowedContentTypes = allowedContentTypes
        self.allowsMultipleSelection = allowsMultipleSelection
        self.onImport = onImport
    }
    
    public var body: some View {
        EmptyView()
            .fileImporter(
                isPresented: $isPresented,
                allowedContentTypes: allowedContentTypes,
                allowsMultipleSelection: allowsMultipleSelection
            ) { result in
                self.isPresented = false
                switch result {
                case .success(let urls):
                    self.selectedURLs = urls
                    self.onImport?(urls)
                case .failure(let error):
                    print("StikImporter Error: \(error.localizedDescription)")
                }
            }
    }
}
