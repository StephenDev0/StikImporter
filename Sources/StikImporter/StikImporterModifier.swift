//
//  StikImporterModifier.swift
//  StikImporter
//
//  Created by Stephen on 12/10/24.
//

import SwiftUI
import UniformTypeIdentifiers

/// A ViewModifier that attaches a StikImporter to a view.
public struct StikImporterModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var selectedURLs: [URL]
    
    public var allowedContentTypes: [UTType]
    public var allowsMultipleSelection: Bool
    public var onImport: (([URL]) -> Void)?
    
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
    
    public func body(content: Content) -> some View {
        content
            .background(
                StikImporter(
                    isPresented: $isPresented,
                    selectedURLs: $selectedURLs,
                    allowedContentTypes: allowedContentTypes,
                    allowsMultipleSelection: allowsMultipleSelection,
                    onImport: onImport
                )
            )
    }
}

extension View {
    /// Attaches a StikImporter to the view.
    /// - Parameters:
    ///   - isPresented: Binding to control the presentation.
    ///   - selectedURLs: Binding to receive the selected URLs.
    ///   - allowedContentTypes: The allowed content types.
    ///   - allowsMultipleSelection: Whether multiple selection is allowed.
    ///   - onImport: Optional callback with selected URLs.
    /// - Returns: A view with the StikImporter attached.
    public func stikImporter(
        isPresented: Binding<Bool>,
        selectedURLs: Binding<[URL]>,
        allowedContentTypes: [UTType] = [.item],
        allowsMultipleSelection: Bool = false,
        onImport: (([URL]) -> Void)? = nil
    ) -> some View {
        self.modifier(
            StikImporterModifier(
                isPresented: isPresented,
                selectedURLs: selectedURLs,
                allowedContentTypes: allowedContentTypes,
                allowsMultipleSelection: allowsMultipleSelection,
                onImport: onImport
            )
        )
    }
}
