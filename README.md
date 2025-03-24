# StikImporter

**StikImporter** is a lightweight SwiftUI package that provides a file importer sheet with security-scoped resource support. It allows you to import files with customizable content types and optional multiple selection, while ensuring proper access permissions for sandboxed environments.

---

## Features

- **SwiftUI Integration**: Easily add file importer sheets to SwiftUI views.
- **Security-Scoped Resources**: Automatically manage access to user-selected files.
- **Customizable**: Supports multiple file types and optional multiple file selection.

---

## Installation

### Swift Package Manager

To add **StikImporter** to your project:

1. In Xcode, go to **File > Swift Packages > Add Package Dependency**.
2. Enter the repository URL:

   ```
   https://github.com/0-Blu/StikImporter.git
   ```

3. Follow the prompts to add the package.

---

## Usage

### Basic Example: Importing Files

Here’s how to use **StikImporter** to allow users to import files:

```swift
import SwiftUI
import StikImporter
import UniformTypeIdentifiers

struct ContentView: View {
    @State private var isImporterPresented = false
    @State private var importedURLs: [URL] = []
    
    var body: some View {
        VStack {
            if importedURLs.isEmpty {
                Text("No files imported.")
                    .foregroundColor(.secondary)
            } else {
                List(importedURLs, id: \.self) { url in
                    Text(url.lastPathComponent)
                }
            }
            
            Button(action: {
                isImporterPresented = true
            }) {
                Label("Import Files", systemImage: "folder.badge.plus")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .stikImporter(
            isPresented: $isImporterPresented,
            selectedURLs: $importedURLs,
            allowedContentTypes: [.image, .pdf, .plainText],
            allowsMultipleSelection: true
        ) { urls in
            print("Imported URLs: \(urls)")
        }
        .padding()
    }
}
```

---

### Key Features in Example:

- **`isPresented`**: Controls the presentation of the file importer.
- **`selectedURLs`**: A binding to store the imported file URLs.
- **`allowedContentTypes`**: Restricts file types (e.g., `.image`, `.pdf`, `.plainText`).
- **`allowsMultipleSelection`**: Enables selection of multiple files.
- **Callback**: Receives the imported URLs after successfully accessing them.

---

### Security-Scoped Resource Access

**StikImporter** automatically requests access to the selected files using:

- `startAccessingSecurityScopedResource()`  
- `stopAccessingSecurityScopedResource()`

This ensures compatibility with sandboxed environments on **macOS** and **iOS**.

---

## Supported Platforms

- iOS 14.0+
- macOS 11.0+
- tvOS 14.0+
- watchOS 7.0+ *(optional)*

---

## Customization

You can restrict file types using **`allowedContentTypes`**. Here are some examples:

- **Images**: `.image`
- **PDF Files**: `.pdf`
- **Text Files**: `.plainText`
- **All Items**: `.item`
- **Plist Files** `.plist`
- **Pairing Files** `.mobiledevicepairing`

Example:

```swift
allowedContentTypes: [.image, .pdf]
```

---

## License

**StikImporter** is available under the **MIT License**.

---

## Contributing

Contributions are welcome! Feel free to:

- Open an issue
- Submit a pull request

---

## Author

Developed by **[0-Blu](https://github.com/0-Blu)**.
