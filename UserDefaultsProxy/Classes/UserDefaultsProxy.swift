//
//  UserDefaultsProxy.swift
//  Pods
//
//  Created by Watanave on 2017/03/21.
//
//

import Foundation

// URL
public typealias URLProxy = UserDefalutsURLProxy

public typealias URLOptProxy = UserDefalutsURLOptProxy

// Dictionary
typealias DictionaryProxy = UserDefalutsProxy<[String: Any]>

typealias DictionaryOptProxy = UserDefalutsOptionalProxy<[String: Any]>

// String
public typealias StringProxy = UserDefalutsProxy<String>

public typealias StringOptProxy = UserDefalutsOptionalProxy<String>

public typealias StringArrayProxy = UserDefalutsProxy<[String]>

public typealias StringArrayOptProxy = UserDefalutsOptionalProxy<[String]>

// Data
public typealias DataProxy = UserDefalutsProxy<Data>

public typealias DataOptProxy = UserDefalutsOptionalProxy<Data>

public typealias DataArrayProxy = UserDefalutsProxy<[Data]>

public typealias DataArrayOptProxy = UserDefalutsOptionalProxy<[Data]>

// Bool
public typealias BoolProxy = UserDefalutsProxy<Bool>

public typealias BoolOptProxy = UserDefalutsOptionalProxy<Bool>

public typealias BoolArrayProxy = UserDefalutsProxy<[Bool]>

public typealias BoolArrayOptProxy = UserDefalutsOptionalProxy<[Bool]>

// Int
public typealias IntProxy = UserDefalutsProxy<Int>

public typealias IntOptProxy = UserDefalutsOptionalProxy<Int>

public typealias IntArrayProxy = UserDefalutsProxy<[Int]>

public typealias IntArrayOptProxy = UserDefalutsOptionalProxy<[Int]>

// Float
public typealias FloatProxy = UserDefalutsProxy<Float>

public typealias FloatOptProxy = UserDefalutsOptionalProxy<Float>

public typealias FloatArrayProxy = UserDefalutsProxy<[Float]>

public typealias FloatArrayOptProxy = UserDefalutsOptionalProxy<[Float]>

// Double
public typealias DoubleProxy = UserDefalutsProxy<Double>

public typealias DoubleOptProxy = UserDefalutsOptionalProxy<Double>

public typealias DoubleArrayProxy = UserDefalutsProxy<[Double]>

public typealias DoubleArrayOptProxy = UserDefalutsOptionalProxy<[Double]>

// Other
public typealias DateProxy = UserDefalutsProxy<Date>

public typealias DateOptProxy = UserDefalutsOptionalProxy<Date>


public class DuplicateKeyChecker {
    
    private static var keys: [String] = []
    public static var isCheckDuplicateKey: Bool = false
    
    fileprivate static func checkProc(key: String) {
        guard self.isCheckDuplicateKey else { return }
        
        assert(!self.keys.contains(key), "Duplicate property key: \(key)")
        self.keys.append(key)
    }
}

public class UserDefaultsContainer {
    
    public static var resolve: ()->UserDefaultsProtocol = {
        return UserDefaults.standard
    }
    
}

open class UserDefalutsProxy<Type> {
    
    public let userDefaults: UserDefaultsProtocol
    public let key: String
    public let defaultValue: Type
    
    public required init(key: String, defaultValue: Type) {
        DuplicateKeyChecker.checkProc(key: key)
        
        self.userDefaults = UserDefaultsContainer.resolve()
        self.key = key
        self.defaultValue = defaultValue
    }
    
    open var value: Type {
        get {
            return self.userDefaults.getValue(self.key) as? Type ?? self.defaultValue
        }
        set {
            self.userDefaults.setValue(newValue, key: self.key)
        }
    }
}

open class UserDefalutsOptionalProxy<Type> {
    
    public let userDefaults: UserDefaultsProtocol
    public let key: String
    
    public required init(key: String) {
        DuplicateKeyChecker.checkProc(key: key)
        
        self.userDefaults = UserDefaultsContainer.resolve()
        self.key = key
    }
    
    open var value: Type? {
        get {
            return self.userDefaults.getValue(self.key) as? Type
        }
        set {
            if let newValue = newValue {
                self.userDefaults.setValue(newValue, key: self.key)
            }
            else {
                self.remove()
            }
        }
    }
    open func remove() {
        self.userDefaults.removeValue(key: self.key)
    }
}

public class UserDefalutsURLProxy : UserDefalutsProxy<URL> {

    public required init(key: String, defaultValue: URL) {
        super.init(key: key, defaultValue: defaultValue)
    }

    public override var value: URL {
        get {
            return self.userDefaults.getUrl(self.key) ?? self.defaultValue
        }
        set {
            self.userDefaults.setUrl(newValue, key: self.key)
        }
    }
}

public class UserDefalutsURLOptProxy : UserDefalutsOptionalProxy<URL> {

    public required init(key: String) {
        super.init(key: key)
    }

    public override var value: URL? {
        get {
            return self.userDefaults.getUrl(self.key)
        }
        set {
            if let newValue = newValue {
                self.userDefaults.setUrl(newValue, key: self.key)
            }
            else {
                self.remove()
            }
        }
    }
}

public protocol UserDefaultsConvertibleEnumType: RawRepresentable {
    static var userDefalutsProxy: UserDefalutsEnumProxy<Self> { get }
    static var current: Self { get set }
}

public extension UserDefaultsConvertibleEnumType {
    static var current: Self {
        get {
            return Self.userDefalutsProxy.value
        }
        set {
            Self.userDefalutsProxy.value = newValue
        }
    }
}

public class UserDefalutsEnumProxy<Type>: UserDefalutsProxy<Type> where Type: RawRepresentable {
    
    public required init(key: String, defaultValue: Type) {
        super.init(key: key, defaultValue: defaultValue)
    }
    
    public override var value: Type {
        get {
            
            guard let rawValue = self.userDefaults.getValue(self.key) as? Type.RawValue else { return self.defaultValue }
            return Type.init(rawValue: rawValue) ?? self.defaultValue
        }
        set {
            let rawValue = newValue.rawValue
            self.userDefaults.setValue(rawValue, key: self.key)
        }
    }
}

