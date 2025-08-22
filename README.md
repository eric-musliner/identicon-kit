# IdenticonKit

---
[![Build Status][ci-svg]][ci-url]

A Cross-platform Swift package for generating unique, block-based identicon images. Perfect for creating consistent default avatars for your users or any data-driven visual representation.

## Features

* **Customizable Identicons:** Generate unique blocky avatars from various input types (e.g., user IDs, email hashes).
* **Pure Swift:** Designed to work seamlessly across Swift platforms, including server-side environments like Vapor.
* **Lightweight:** Minimal dependencies, ensuring a small footprint.

---

## Examples

<div style="display: flex; flex-wrap: wrap; justify-content: center; gap: 20px;">
  <img src="https://github.com/user-attachments/assets/0124772a-7171-4535-b718-ee7eab81f28a" style="width: 150px; height: auto; border: 1px solid #ccc; border-radius: 8px;">
  <img src="https://github.com/user-attachments/assets/4b018104-de0c-499c-bc82-d7d52258af3d" style="width: 150px; height: auto; border: 1px solid #ccc; border-radius: 8px;">
  <img src="https://github.com/user-attachments/assets/340994f9-5063-4cd2-9f7d-962ab9427a8a" style="width: 150px; height: auto; border: 1px solid #ccc; border-radius: 8px;">
  <img src="https://github.com/user-attachments/assets/0ec2a7a4-e375-4497-988c-af57ec7b2e48" style="width: 150px; height: auto; border: 1px solid #ccc; border-radius: 8px;">
  <img src="https://github.com/user-attachments/assets/d05e9fd2-ea33-42f4-aeda-832080125786" style="width: 150px; height: auto; border: 1px solid #ccc; border-radius: 8px;">
  <img src="https://github.com/user-attachments/assets/41100c8d-e709-4a69-85a3-5860a99c08ce" style="width: 150px; height: auto; border: 1px solid #ccc; border-radius: 8px;">
  <img src="https://github.com/user-attachments/assets/201395ed-bc62-4c34-b270-99aa0f95d03a" style="width: 150px; height: auto; border: 1px solid #ccc; border-radius: 8px;">
  <img src="https://github.com/user-attachments/assets/38c17324-5c13-49a2-86cb-6cbb73e50515" style="width: 150px; height: auto; border: 1px solid #ccc; border-radius: 8px;">
  <img src="https://github.com/user-attachments/assets/6d8234d7-2833-4d1c-a5c8-8f36822c14ee" style="width: 150px; height: auto; border: 1px solid #ccc; border-radius: 8px;">
  <img src="https://github.com/user-attachments/assets/4f0b537d-e54d-4ec2-8bcd-0bb6bf5df5c9" style="width: 150px; height: auto; border: 1px solid #ccc; border-radius: 8px;">
</div>

---

## Installation

You can add `IdenticonKit` to your project using Swift Package Manager.

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/eric-musliner/identicon-kit.git", from: "1.2.0")
]
```

## Usage

To create an Identicon in svg format

```swift
  let svg = IdenticonKit.generateSvg(from: "test@example.com")

  // Specify larger grid of elements (.xsmall, .small, .medium, .large)
  let svg = IdenticonKit.generate(from: "test@example.com", size: .medium)
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

<!-- Badges -->
[ci-svg]: https://github.com/eric-musliner/identicon-kit/actions/workflows/ci.yml/badge.svg
[ci-url]: https://github.com/eric-musliner/identicon-kit/actions/workflows/ci.yml

