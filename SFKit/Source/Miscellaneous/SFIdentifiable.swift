//
//  SFIdentifiable.swift
//  SFKit
//
//  Created by David Moore on 3/10/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

/// Produces a `String` value for a given type.
///
/// - Parameter type: Type for which a name will be generated for.
/// - Returns: `String` value of the type's given name.
fileprivate func name<T>(of type: T) -> String {
    return String(describing: type)
}

public protocol SFIdentifiable {
    /// Unique string-based identifier that represents the name of the object.
    static var typeName: String { get }
}

// MARK: - Identifiable Default Implementation
extension SFIdentifiable {
    /// Unique string-based identifier that represents the name of the object.
    public static var typeName: String {
        return name(of: Self.self)
    }
}

extension NSObject: SFIdentifiable {}
