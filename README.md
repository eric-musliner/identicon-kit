# IdenticonKit

---

A Cross-platform Swift package for generating unique, block-based identicon images. Perfect for creating consistent default avatars for your users or any data-driven visual representation.

## Features

* **Customizable Identicons:** Generate unique blocky avatars from various input types (e.g., user IDs, email hashes).
* **Pure Swift:** Designed to work seamlessly across Swift platforms, including server-side environments like Vapor.
* **Lightweight:** Minimal dependencies, ensuring a small footprint.
* **[Add more specific features here, e.g., "Output as PNG/SVG data," "Customizable colors," "Adjustable grid size"]**

---

## Installation

You can add `IdenticonKit` to your project using Swift Package Manager.

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "[https://github.com/eric-musliner/IdenticonKit.git](https://github.com/eric-musliner/IdenticonKit.git)", from: "1.0.0")
]
```


## Development

### Linux

Build or run tests with:

```bash
swift build \
  -Xcc -I/usr/include/c++/11 \
  -Xcc -I/usr/include/x86_64-linux-gnu/c++/11
```

```bash
swift test \
  -Xcc -I/usr/include/c++/11 \
  -Xcc -I/usr/include/x86_64-linux-gnu/c++/11 \
  -Xlinker -L/usr/lib/gcc/x86_64-linux-gnu/11
```
