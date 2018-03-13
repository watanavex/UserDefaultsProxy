//
//  UserDefaultsMock.swift
//  Pods-UserDefaultsProxy_Tests
//
//  Created by Yohta Watanave on 2018/03/13.
//

import Foundation

public protocol UserDefaultsProtocol {
    func getValue(_ key: String) -> Any?
    func getUrl(_ key: String) -> URL?
    func setValue(_ value: Any, key: String)
    func setUrl(_ value: URL, key: String)
    func removeValue(key: String)
}

extension UserDefaults: UserDefaultsProtocol {
    public func getValue(_ key: String) -> Any? {
        return self.object(forKey: key)
    }
    public func getUrl(_ key: String) -> URL? {
        return self.url(forKey: key)
    }
    public func setValue(_ value: Any, key: String) {
        self.set(value, forKey: key)
    }
    public func setUrl(_ value: URL, key: String) {
        self.set(value, forKey: key)
    }
    public func removeValue(key: String) {
        self.removeObject(forKey: key)
    }
}

public class UserDefaultsMock: UserDefaultsProtocol {
    
    var store: [String: Any] = [:]
    
    public init() {}
    
    public func getValue(_ key: String) -> Any? {
        return self.store[key]
    }
    public func getUrl(_ key: String) -> URL? {
        return self.store[key] as? URL
    }
    public func setValue(_ value: Any, key: String) {
        self.store[key] = value
    }
    public func setUrl(_ value: URL, key: String) {
        self.store[key] = value
    }
    public func removeValue(key: String) {
        self.store.removeValue(forKey: key)
    }
}
