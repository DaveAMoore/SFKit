//
//  SFReuseable.swift
//  SFKit
//
//  Created by David Moore on 7/15/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

/// Produces a `String` value for a given type.
///
/// - Parameter type: Type for which a name will be generated for.
/// - Returns: `String` value of the type's given name.
fileprivate func name<T>(of type: T) -> String {
    return String(describing: type)
}

/// `SFReuseable` provides an automatic `reuseIdentifier` which may be used to enqueue and dequeue cells and/or reuseable views. The functionality is primarily useful for table views and collection views, but may be applied to other cases as well.
public protocol SFReuseable: class {
    /// Unique string-based identifier which represents the reuseable cell.
    static var reuseIdentifier: String { get }
}

// MARK: - Reuseable Default Conformance
extension SFReuseable {
    /// Unique string-based identifier which represents the reuseable cell.
    public static var reuseIdentifier: String {
        return name(of: Self.self)
    }
}

// MARK: - General Conformance

extension SFTableViewCell: SFReuseable {}
extension SFTableViewHeaderFooterView: SFReuseable {}
extension SFCollectionViewCell: SFReuseable {}
extension SFCollectionReusableView: SFReuseable {}
