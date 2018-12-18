//
//  SFOnboardingCard.swift
//  SFKit
//
//  Created by David Moore on 1/28/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

import UIKit

/// A discrete unit for an `SFOnboardingStage`. A particular stage will have cards associated with it, as this structure represents the content component.
open class SFOnboardingCard: NSObject {
    
    /// Type of cell that will be created for the card.
    open var cellType: UITableViewCell.Type {
        fatalError("expected 'cellType' to be implemented")
    }
    
    /// Name of the cell's associated nib.
    @available(*, deprecated)
    open var nibName: String {
        return reuseIdentifier
    }
    
    /// Unique identifier that should be used for cell instances of this class.
    @available(*, deprecated)
    open var reuseIdentifier: String {
        return String(describing: cellType)
    }
    
    open func register(with tableView: UITableView) {
        fatalError("expected 'register(with:)' to be implemented")
    }
    
    open func unregister(from tableView: UITableView) {
        fatalError("expected 'unregister(from:)' to be implemented")
    }
    
    /// Selection style of the associated cell.
    open var selectionStyle: UITableViewCell.SelectionStyle = .default
    
    /// Prepares a card for presentation within a table view.
    ///
    /// - Parameter cell: Card that must be configured for display.
    open func prepare(_ cell: UITableViewCell, for controller: SFOnboardingStageViewController?) {
        cell.selectionStyle = selectionStyle
    }
    
    // MARK: - Deprecations
    
    /// Prepares a card for presentation within a table view.
    ///
    /// - Parameter card: Card that must be configured for display.
    @available(*, deprecated, renamed: "prepare(_:for:)")
    open func prepare(_ card: UITableViewCell, forController controller: SFOnboardingStageViewController?) {
        prepare(card, for: controller)
    }
}
