# UserDefaultsProxy

[![Version](https://img.shields.io/cocoapods/v/UserDefaultsProxy.svg?style=flat)](http://cocoapods.org/pods/UserDefaultsProxy)
[![License](https://img.shields.io/cocoapods/l/UserDefaultsProxy.svg?style=flat)](http://cocoapods.org/pods/UserDefaultsProxy)
[![Platform](https://img.shields.io/cocoapods/p/UserDefaultsProxy.svg?style=flat)](http://cocoapods.org/pods/UserDefaultsProxy)

It is wrapper for UserDefaults.  
UserDefaultsProxy is Type-safety, and Testable.

## Example
```
class AppSetting {

    // String value. It isn't optional. It's needs default value.
    static let userName = StringProxy(key: "userName", defaultValue: "unknown")

    // Optional int value.
    static let age = IntOptProxy(key: "age")

}

func doSomething() {
    let userName = AppSetting.userName.value
    let age = AppSetting.age.value
}

func updateAge(_ age: Int) {
    AppSetting.age.value = age
}

```

### Keys
There is no rule in Key. But do not duplicate.  
if you would like to duplicate key check in debug build...
```
#if DEBUG
    DuplicateKeyChecker.isCheckDuplicateKey = true
#endif
```

### UnitTest
If you would like to test for UserDefaults, You can use mock objects.
```
class Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        UserDefaultsContainer.resolve = {
            return UserDefaultsMock()
        }
    }
```
A new instance of UserDefaults mock is created each time it is executed.

## Installation

UserDefaultsProxy is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "UserDefaultsProxy"
```

## Author

watanave, susan.se3p@gmail.com

## License

UserDefaultsProxy is available under the MIT license. See the LICENSE file for more info.
