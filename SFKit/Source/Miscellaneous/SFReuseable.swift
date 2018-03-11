//
//  SFReuseable.swift
//  SFKit
//
//  Created by David Moore on 3/10/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

/// `SFReuseable` provides an automatic `reuseIdentifier` which may be used to enqueue and dequeue cells and/or reuseable views. The functionality is primarily useful for table views and collection views, but may be applied to other cases as well.
@available(iOS, deprecated: 10.0, message: "use SFIdentifiable instead")
public protocol SFReuseable: class, SFIdentifiable {
    /// Unique string-based identifier which represents the reuseable cell.
    static var reuseIdentifier: String { get }
}

// MARK: - Reuseable Default Implementation
@available(iOS, deprecated: 10.0, message: "use SFIdentifiable instead")
extension SFReuseable {
    /// Unique string-based identifier which represents the reuseable cell.
    public static var reuseIdentifier: String {
        return typeName
    }
}

@available(iOS, deprecated: 10.0, message: "use SFIdentifiable instead")
extension UITableViewCell: SFReuseable {}

@available(iOS, deprecated: 10.0, message: "use SFIdentifiable instead")
extension UITableViewHeaderFooterView: SFReuseable {}

@available(iOS, deprecated: 10.0, message: "use SFIdentifiable instead")
extension UICollectionReusableView: SFReuseable {}
