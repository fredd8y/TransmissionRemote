[![CI_iOS](https://github.com/fredd8y/TransmissionRemote/actions/workflows/CI_iOS.yml/badge.svg)](https://github.com/fredd8y/TransmissionRemote/actions/workflows/CI_iOS.yml)
[![CI_macOS](https://github.com/fredd8y/TransmissionRemote/actions/workflows/CI_macOS.yml/badge.svg)](https://github.com/fredd8y/TransmissionRemote/actions/workflows/CI_macOS.yml)

# TransmissionRemote
Transmission is an app for iPhone that work as a Transmission Remote Controller, it aims to have iOS native look and feel and to follow iOS human interface guidelines.

I'm developing this app to gain confidence with some concept like:
- Testability
- Decoupling
- Composing

In addition to that I'm using the development of this app as a training for the following:
-  SwiftUI
-  Combine

This application aims to be fully tested and to use GitHub actions to automate the testing process.

Features included currently:

- Add torrent from torrent files
- Add torrent from link
- Start and stop torrent download
- Support multiple server
- Download folder available free space
- Show torrent info
- Show torrent peers info
- Show trackers info

This list of features will be constantly updated as more feature will be implemented.

The app is working, but since it is still in development at the moment, I cannot rule out more or less serious bugs, so for practical purposes it is to be considered non-functional.
This status will be changed when the app is considered stable.

## Acknowledgements

The developing of this app can be done thanks to the official transmission [repository](https://github.com/transmission/transmission) especially the [rpc-spec](https://github.com/transmission/transmission/blob/main/docs/rpc-spec.md) page
