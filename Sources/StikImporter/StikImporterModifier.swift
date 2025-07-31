//
//  StikImporterModifier.swift
//  StikImporter
//
//  Created by Stephen on 12/10/24.
//

import SwiftUI
import UniformTypeIdentifiers

public struct StikImporterModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var selectedURLs: [URL]
    let allowedContentTypes: [UTType]
    let allowsMultipleSelection: Bool
    let onImport: ([URL]) -> Void

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
        _isPresented = isPresented
        _selectedURLs = selectedURLs
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

public extension View {
    func stikImporter(
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
    ) -> some View {
        modifier(
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
