import UIKit
import XCTest
import UserDefaultsProxy

class Tests: XCTestCase {
    
    static let mock = UserDefaultsMock()
    
    static var __once: () = {
        DuplicateKeyChecker.isCheckDuplicateKey = true
        
        UserDefaultsContainer.resolve = {
            return mock
        }
    }()
    
    override func setUp() {
        super.setUp()
        _ = Tests.__once
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testURL() {
        let val1 = URL(string: "https://google.com")!
        let val2 = URL(string: "http://google.co.jp")!
        let proxy = URLProxy(key: #function, defaultValue: val1)
        XCTAssert(proxy.value == val1)
        
        proxy.value = val2
        XCTAssert(proxy.value == val2)
        
        proxy.userDefaults.removeValue(key: proxy.key)
        XCTAssert(proxy.value == val1)
    }
    func testURLOpt() {
        let val1 = URL(string: "https://google.com")!
        let proxy = URLOptProxy(key: #function)
        XCTAssert(proxy.value == nil)
        
        proxy.value = val1
        XCTAssert(proxy.value == val1)
        
        proxy.remove()
        XCTAssert(proxy.value == nil)
    }
    
    func testInt() {
        let val1 = 123
        let val2 = 0xffff
        let proxy = IntProxy(key: #function, defaultValue: val1)
        XCTAssert(proxy.value == val1)
        
        proxy.value = val2
        XCTAssert(proxy.value == val2)
        
        proxy.userDefaults.removeValue(key: proxy.key)
        XCTAssert(proxy.value == val1)
    }
    func testIntOpt() {
        let val1 = 123
        let proxy = IntOptProxy(key: #function)
        XCTAssert(proxy.value == nil)
        
        proxy.value = val1
        XCTAssert(proxy.value == val1)
        
        proxy.remove()
        XCTAssert(proxy.value == nil)
    }
    func testIntArray() {
        let arr1 = [1, 2, 3, 4, 5]
        let arr2 = [100, 200, 20, 3]
        let proxy = IntArrayProxy(key: #function, defaultValue: arr1)
        XCTAssert(proxy.value == arr1)
        
        proxy.value = arr2
        XCTAssert(proxy.value == arr2)
        
        proxy.userDefaults.removeValue(key: proxy.key)
        XCTAssert(proxy.value == arr1)
    }
    func testIntArrayOpt() {
        let arr1 = [1, 2, 3, 4, 5]
        let proxy = IntArrayOptProxy(key: #function)
        XCTAssert(proxy.value == nil)
        
        proxy.value = arr1
        XCTAssert(proxy.value! == arr1)
        
        proxy.remove()
        XCTAssert(proxy.value == nil)
    }
    
    func testString() {
        let val1 = "hoge"
        let val2 = "hugahuga"
        let proxy = StringProxy(key: #function, defaultValue: val1)
        XCTAssert(proxy.value == val1)
        
        proxy.value = val2
        XCTAssert(proxy.value == val2)
        
        proxy.userDefaults.removeValue(key: proxy.key)
        XCTAssert(proxy.value == val1)
    }
    func testStringOpt() {
        let val1 = "hoge"
        let proxy = StringOptProxy(key: #function)
        XCTAssert(proxy.value == nil)
        
        proxy.value = val1
        XCTAssert(proxy.value == val1)
        
        proxy.remove()
        XCTAssert(proxy.value == nil)
    }
    func testStringArray() {
        let arr1 = ["hoge", "huga", "poyo"]
        let arr2 = ["a", "b", "c"]
        let proxy = StringArrayProxy(key: #function, defaultValue: arr1)
        XCTAssert(proxy.value == arr1)
        
        proxy.value = arr2
        XCTAssert(proxy.value == arr2)
        
        proxy.userDefaults.removeValue(key: proxy.key)
        XCTAssert(proxy.value == arr1)
    }
    func testStringArrayOpt() {
        let arr1 = ["hoge", "huga", "poyo"]
        let proxy = StringArrayOptProxy(key: #function)
        XCTAssert(proxy.value == nil)
        
        proxy.value = arr1
        XCTAssert(proxy.value! == arr1)
        
        proxy.remove()
        XCTAssert(proxy.value == nil)
    }
    
    func testData() {
        let val1 = Data(base64Encoded: "hoge")!
        let val2 = Data(base64Encoded: "huga")!
        let proxy = DataProxy(key: #function, defaultValue: val1)
        XCTAssert(proxy.value == val1)
        
        proxy.value = val2
        XCTAssert(proxy.value == val2)
        
        proxy.userDefaults.removeValue(key: proxy.key)
        XCTAssert(proxy.value == val1)
    }
    func testDataOpt() {
        let val1 = Data(base64Encoded: "hoge")!
        let proxy = DataOptProxy(key: #function)
        XCTAssert(proxy.value == nil)
        
        proxy.value = val1
        XCTAssert(proxy.value == val1)
        
        proxy.remove()
        XCTAssert(proxy.value == nil)
    }
    func testDataArray() {
        let val1 = Data(base64Encoded: "hoge")!
        let val2 = Data(base64Encoded: "huga")!
        let val3 = Data(base64Encoded: "poyo")!
        let arr1 = [val1, val2, val3]
        let arr2 = [val1, val1, val1, val1]
        let proxy = DataArrayProxy(key: #function, defaultValue: arr1)
        XCTAssert(proxy.value == arr1)
        
        proxy.value = arr2
        XCTAssert(proxy.value == arr2)
        
        proxy.userDefaults.removeValue(key: proxy.key)
        XCTAssert(proxy.value == arr1)
    }
    func testDataArrayOpt() {
        let val1 = Data(base64Encoded: "hoge")!
        let val2 = Data(base64Encoded: "huga")!
        let val3 = Data(base64Encoded: "poyo")!
        let arr1 = [val1, val2, val3]
        let proxy = DataArrayOptProxy(key: #function)
        XCTAssert(proxy.value == nil)
        
        proxy.value = arr1
        XCTAssert(proxy.value! == arr1)
        
        proxy.remove()
        XCTAssert(proxy.value == nil)
    }
    
    func testBool() {
        let val1 = true
        let val2 = false
        let proxy = BoolProxy(key: #function, defaultValue: val1)
        XCTAssert(proxy.value == val1)
        
        proxy.value = val2
        XCTAssert(proxy.value == val2)
        
        proxy.userDefaults.removeValue(key: proxy.key)
        XCTAssert(proxy.value == val1)
    }
    func testBoolOpt() {
        let val1 = true
        let proxy = BoolOptProxy(key: #function)
        XCTAssert(proxy.value == nil)
        
        proxy.value = val1
        XCTAssert(proxy.value == val1)
        
        proxy.remove()
        XCTAssert(proxy.value == nil)
    }
    func testBoolArray() {
        let arr1 = [true, false, true]
        let arr2 = [false, false, true, true]
        let proxy = BoolArrayProxy(key: #function, defaultValue: arr1)
        XCTAssert(proxy.value == arr1)
        
        proxy.value = arr2
        XCTAssert(proxy.value == arr2)
        
        proxy.userDefaults.removeValue(key: proxy.key)
        XCTAssert(proxy.value == arr1)
    }
    func testBoolArrayOpt() {
        let arr1 = [true, false, true]
        let proxy = BoolArrayOptProxy(key: #function)
        XCTAssert(proxy.value == nil)
        
        proxy.value = arr1
        XCTAssert(proxy.value! == arr1)
        
        proxy.remove()
        XCTAssert(proxy.value == nil)
    }
    
    func testFloat() {
        let val1: Float = 0.1
        let val2: Float = 300.567
        let proxy = FloatProxy(key: #function, defaultValue: val1)
        XCTAssert(proxy.value == val1)
        
        proxy.value = val2
        XCTAssert(proxy.value == val2)
        
        proxy.userDefaults.removeValue(key: proxy.key)
        XCTAssert(proxy.value == val1)
    }
    func testFloatOpt() {
        let val1: Float = 256.654
        let proxy = FloatOptProxy(key: #function)
        XCTAssert(proxy.value == nil)
        
        proxy.value = val1
        XCTAssert(proxy.value == val1)
        
        proxy.remove()
        XCTAssert(proxy.value == nil)
    }
    func testFloatArray() {
        let arr1: [Float] = [0.1, 2003.3, 256.443]
        let arr2: [Float] = [-200, 50.234, 456]
        let proxy = FloatArrayProxy(key: #function, defaultValue: arr1)
        XCTAssert(proxy.value == arr1)
        
        proxy.value = arr2
        XCTAssert(proxy.value == arr2)
        
        proxy.userDefaults.removeValue(key: proxy.key)
        XCTAssert(proxy.value == arr1)
    }
    func testFloatArrayOpt() {
        let arr1: [Float] = [0.1, 2003.3, 256.443]
        let proxy = FloatArrayOptProxy(key: #function)
        XCTAssert(proxy.value == nil)
        
        proxy.value = arr1
        XCTAssert(proxy.value! == arr1)
        
        proxy.remove()
        XCTAssert(proxy.value == nil)
    }
    
    func testDouble() {
        let val1 = 0.1
        let val2 = 300.567
        let proxy = DoubleProxy(key: #function, defaultValue: val1)
        XCTAssert(proxy.value == val1)
        
        proxy.value = val2
        XCTAssert(proxy.value == val2)
        
        proxy.userDefaults.removeValue(key: proxy.key)
        XCTAssert(proxy.value == val1)
    }
    func testDoubleOpt() {
        let val1 = 256.654
        let proxy = DoubleOptProxy(key: #function)
        XCTAssert(proxy.value == nil)
        
        proxy.value = val1
        XCTAssert(proxy.value == val1)
        
        proxy.remove()
        XCTAssert(proxy.value == nil)
    }
    func testDoubleArray() {
        let arr1 = [0.1, 2003.3, 256.443]
        let arr2 = [-200, 50.234, 456]
        let proxy = DoubleArrayProxy(key: #function, defaultValue: arr1)
        XCTAssert(proxy.value == arr1)
        
        proxy.value = arr2
        XCTAssert(proxy.value == arr2)
        
        proxy.userDefaults.removeValue(key: proxy.key)
        XCTAssert(proxy.value == arr1)
    }
    func testDoubleArrayOpt() {
        let arr1 = [0.1, 2003.3, 256.443]
        let proxy = DoubleArrayOptProxy(key: #function)
        XCTAssert(proxy.value == nil)
        
        proxy.value = arr1
        XCTAssert(proxy.value! == arr1)
        
        proxy.remove()
        XCTAssert(proxy.value == nil)
    }
    
    func testDate() {
        let val1 = Date(timeIntervalSince1970: 30000)
        let val2 = Date()
        let proxy = DateProxy(key: #function, defaultValue: val1)
        XCTAssert(proxy.value == val1)
        
        proxy.value = val2
        XCTAssert(proxy.value == val2)
        
        proxy.userDefaults.removeValue(key: proxy.key)
        XCTAssert(proxy.value == val1)
    }
    func testDateOpt() {
        let val1 = Date(timeIntervalSince1970: 30000)
        let proxy = DateOptProxy(key: #function)
        XCTAssert(proxy.value == nil)
        
        proxy.value = val1
        XCTAssert(proxy.value == val1)
        
        proxy.remove()
        XCTAssert(proxy.value == nil)
    }
    
    
    static let userDefaultTestEnum = UserDefalutsEnumProxy<TestEnum>(key: "TestEnum", defaultValue: .c1)
    enum TestEnum: Int, UserDefaultsConvertibleEnumType {
        case c1
        case c2
        case c3
        
        static let userDefalutsProxy = userDefaultTestEnum
    }
    
    func testEnum() {
        XCTAssert(TestEnum.current == .c1)
        
        TestEnum.current = .c2
        XCTAssert(TestEnum.current == .c2)
        
        Tests.userDefaultTestEnum.userDefaults.removeValue(key: TestEnum.userDefalutsProxy.key)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
