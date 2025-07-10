# SwoirCore

![Version](https://img.shields.io/badge/version-0.9.0-darkviolet)
[![Swift 5](https://img.shields.io/badge/Swift-5-blue.svg)](https://developer.apple.com/swift/)
[![License: Apache-2.0](https://img.shields.io/badge/License-Apache--2.0-green)](https://opensource.org/license/apache-2-0)

SwoirCore is a Swift package providing the shared core data structures utilised by [Swoir](https://github.com/Swoir/Swoir) and [Swoirenberg](https://github.com/Swoir/Swoirenberg), including the `SwoirBackendProtocol` protocol, the `SwoirBackendError` errors enum, and the `Proof` data type.

The `SwoirBackendProtocol` protocol defines the interface for a proving system backend. Backends conforming to this protocol, like [Swoirenberg](https://github.com/Swoir/Swoirenberg)
, are compatible with [Swoir](https://github.com/Swoir/Swoir) for use as its proving backend.

## Contributing

Contributions are welcome! For major changes, please open an issue first to discuss what you would like to change.

## License

Licensed under the Apache-2.0 License. See [LICENSE](./LICENSE) for more information.
