<p align="left" style="margin-top: 20px;">
  <img src="https://2.pik.vn/20190e80d58a-1c0c-4e30-9ed5-b0c0659b3db8.png" width="500" height="214" alt="Manager" />
</p>

![macOS](https://img.shields.io/badge/os-macOS%2010.10%2B-green.svg?style=flat)
![Swift4](https://img.shields.io/badge/swift-4.2-green.svg?style=flat)
![Release](https://img.shields.io/badge/release-1.3.0-blue.svg?style=flat)
![MIT](https://img.shields.io/badge/license-MIT-lightgray.svg)
![CocoaPods](https://img.shields.io/badge/dep-CocoaPods-orange.svg)
![Carthage](https://img.shields.io/badge/dep-Carthage-orange.svg)

## Summary

*TicketManager* is a lightweight library completely written in Swift that provides ticketbooking system capabilities to both Swift and Objective-C  applications.

*TicketManager* is brought to you with ❤️ by PDK team.

### QuickStart

* Download the [TicketManager Demo](https://github.com/) binary and give it a try!

## Table of Contents
* [Summary](#summary)
* [Features](#features)
* [Installation](#installation)
* [Usage](#usage)
* [FAQ](#faq)
* [License](#license)

## Features

- Written in Swift 4.2
- Optional configuration, none required
- Neglected performance impact
- Provide ticketbooking system for XXX.

## Installation

|TicketManager |Swift Version|
|----------------|-------------|
|1.0.0           |      3.0    |
|1.1.0           |      4.0    |
|1.2.0           |      4.1    |
|1.2.3           |      4.2    |

There are multiple options to include *TicketManager* on your project:

- **[CocoaPods](https://cocoapods.org)**

  Add to your `Podfile`:

  ```Podfile
  use_frameworks!
  target '[YOUR APP TARGET]' do
      pod 'TicketManager', '~> 1.0.0'
  end
  ```
  
  When using CocoaPods, the TicketManager module is named `TicketManager`:
  
  ```
  import TicketManager
  ```
  
- **Manually**
  - Either add `TicketManager.framework` on your project
  - If importing into a Objective-C project, you will need to include all the Swift related frameworks as well
  
  Then import TicketManager module with:
  
  ```
  import TicketManager
  ```
  

## Usage

### Simple Usage
At its simpler usage, applications can be init with a single line command:

##### In Swift:

```swift
let ticketManager = TicketManager(viewController: self)
ticketManager.openBookingTicketViewController()

// Delegate
extension ViewController: TicketManageDelegate {
    func canceled() {
        print("canceled")
    }

    func finish(with status: TicketStatus) {
        print(status)
        switch status {
            case .failed(let errorMessage):
            print(errorMessage)
            case .success(let ticketId):
            ticketLabel.text = "TicketID: \(ticketId)"
            print(ticketId)
        }
    }
}
```

## FAQ

### **Where can I find the API documentation?**
Documentation can be found [here](http://github.com). 

## License

*TicketManager* is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

