# StikImporter

**StikImporter** is a lightweight Swift package that provides a reusable file importer sheet for SwiftUI applications. It simplifies the process of integrating file importing functionality, allowing developers to present a native file importer with minimal setup.

## Features

- **Easy Integration:** Seamlessly integrates with SwiftUI views.
- **Customizable:** Specify allowed content types and control multiple selections.
- **Reusable:** Encapsulated functionality for reuse across multiple projects.
- **Lightweight:** No external dependencies, keeping your project lean.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
  - [1. Using `StikImporter` View](#1-using-stikimporter-view)
  - [2. Using `.stikImporter` View Modifier](#2-using-stikimporter-view-modifier)
- [Example](#example)
- [License](#license)
- [Contributing](#contributing)

---

## Installation

### Swift Package Manager

1. **Open Your Project in Xcode:**
   - Navigate to your project in Xcode.

2. **Add Package Dependency:**
   - Go to `File` > `Add Packages...`.
   
3. **Enter Repository URL:**
   - Input the repository URL of `StikImporter`. Replace `yourusername` with your actual GitHub username or the repository owner.
   
     ```
     https://github.com/yourusername/StikImporter.git
     ```
   
4. **Select Package Options:**
   - Choose the desired version, typically the latest release.
   
5. **Add to Your Project:**
   - Select the target(s) where you want to include `StikImporter` and add the package.

### Manual Integration

If you prefer to add the package manually:

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/yourusername/StikImporter.git
   ```

2. **Drag and Drop:**
   - Drag the `StikImporter` folder into your Xcode project.

3. **Ensure Dependencies:**
   - Make sure your project targets include the necessary platforms supported by `StikImporter`.

---

## Usage

`StikImporter` offers two primary ways to integrate the file importer into your SwiftUI views:

1. **Using the `StikImporter` View Directly**
2. **Using the `.stikImporter` View Modifier**

### 1. Using `StikImporter` View

This approach involves embedding the `StikImporter` view within your view hierarchy.

#### Step-by-Step Guide:

1. **Import the Package:**

   ```swift
   import SwiftUI
   import StikImporter
   import UniformTypeIdentifiers
   ```

2. **Define State Variables:**

   ```swift
   @State private var isImporterPresented = false
   @State private var importedURLs: [URL] = []
   ```

3. **Integrate `StikImporter` into Your View:**

   ```swift
   struct ContentView: View {
       @State private var isImporterPresented = false
       @State private var importedURLs: [URL] = []
       
       var body: some View {
           VStack(spacing: 20) {
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
                       .font(.headline)
                       .padding()
                       .foregroundColor(.white)
                       .background(Color.blue)
                       .cornerRadius(8)
               }
           }
           .padding()
           .overlay(
               StikImporter(
                   isPresented: $isImporterPresented,
                   selectedURLs: $importedURLs,
                   allowedContentTypes: [.pdf, .image, .plainText],
                   allowsMultipleSelection: true
               ) { urls in
                   // Handle the imported URLs if needed
                   print("Imported URLs: \(urls)")
               }
           )
       }
   }
   ```

---

### 2. Using `.stikImporter` View Modifier

For a more seamless integration, `StikImporter` offers a view modifier that can be attached to any SwiftUI view.

```swift
struct ContentView: View {
    @State private var isImporterPresented = false
    @State private var importedURLs: [URL] = []
    
    var body: some View {
        Button("Import Files") {
            isImporterPresented = true
        }
        .stikImporter(
            isPresented: $isImporterPresented,
            selectedURLs: $importedURLs,
            allowedContentTypes: [.pdf],
            allowsMultipleSelection: false
        )
    }
}
```

---

## License

MIT License. See [LICENSE](LICENSE) for more information.

## Contributing

Contributions are welcome! Please follow these steps:

1. **Fork the Repository**
2. **Create a Feature Branch**

   ```bash
   git checkout -b feature/YourFeature
   ```

3. **Commit Your Changes**

   ```bash
   git commit -m "Add some feature"
   ```

4. **Push to the Branch**

   ```bash
   git push origin feature/YourFeature
   ```

5. **Open a Pull Request**

---

## Support

If you encounter any issues or have suggestions for improvements, feel free to open an [issue](https://github.com/yourusername/StikImporter/issues) on GitHub.

---

Happy Coding! 🎉
