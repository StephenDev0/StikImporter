import XCTest
@testable import StikImporter
import SwiftUI

final class StikImporterTests: XCTestCase {
    func testStikImporterInitialization() throws {
        let isPresented = Binding<Bool>(get: { false }, set: { _ in })
        let selectedURLs = Binding<[URL]>(get: { [] }, set: { _ in })
        
        let importer = StikImporter(
            isPresented: isPresented,
            selectedURLs: selectedURLs,
            allowedContentTypes: [.pdf],
            allowsMultipleSelection: true,
            onImport: { urls in
                XCTAssertFalse(urls.isEmpty, "URLs should not be empty")
            }
        )
        
        XCTAssertNotNil(importer)
    }
    
}
