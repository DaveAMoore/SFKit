//
//  SFOnboardingControl.swift
//  SFKit
//
//  Created by David Moore on 1/30/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

import ObjectiveC.runtime

fileprivate extension Selector {
    static let dismissOnboardingController  = #selector(SFOnboardingControl.dismissOnboardingController(_:))
    static let startActivityIndicator       = #selector(SFOnboardingControl.startActivityIndicator(_:))
    static let stopActivityIndicator        = #selector(SFOnboardingControl.stopActivityIndicator(_:))
    static let enableUserInteraction        = #selector(SFOnboardingControl.enableUserInteraction(_:))
    static let disableUserInteraction       = #selector(SFOnboardingControl.disableUserInteraction(_:))
    static let pushNextStage                = #selector(SFOnboardingControl.pushNextStage(_:))
    static let popStage                     = #selector(SFOnboardingControl.popStage(_:))
}

open class SFOnboardingControl: SFOnboardingElement<UIControl> {
    
    // MARK: - Types
    
    /// Closure used for communication between the receiver and caller of an initialization call.
    public typealias CommunicationClosure = ((SFOnboardingStageViewController?, Any?, (@escaping ([Action]) -> Void)) -> Void)
    
    /// Wrapper for `Selector` that allows precise indication of action-related parameters.
    public enum Action {
        /// Represents the action(s) that are automatically set by the control itself.
        case inherited
        
        /// Dismisses the entire onboarding controller.
        case dismissOnboardingController(UIControl.Event)
        
        /// Presents an activity indicator and starts it.
        case startActivityIndicator(UIControl.Event)
        
        /// Stops an activity indicator and then removes it from the view hierarchy.
        case stopActivityIndicator(UIControl.Event)
        
        /// Enables user interaction of the controller's view.
        case enableUserInteraction(UIControl.Event)
        
        /// Disables user interaction of the controller's view.
        case disableUserInteraction(UIControl.Event)
        
        /// Pushes the next stage controller onto the onboarding stack.
        case pushNextStage(UIControl.Event)
        
        /// Pops the current stage controller from the top of the onboarding stack.
        case popStage(UIControl.Event)
        
        /// Custom action that executes a particular CommunicationClosure for specific control events.
        /// The closure will be executed directly as a result of the control events occuring, and immediately when no control events are specified.
        case closure(UIControl.Event, CommunicationClosure)
        
        /// Void method will be called.
        @available(*, deprecated, message: "use '.closure' instead")
        case void(UIControl.Event)
        
        /// Custom defined action.
        ///
        /// `target`
        ///
        /// The target object—that is, the object whose action method is called. If you specify nil, UIKit searches the responder chain for an object that responds to the specified action message and delivers the message to that object.
        ///
        /// `method`
        ///
        /// A selector identifying the action method to be called. You may specify a selector whose signature matches any of the signatures in UIControl. This parameter must not be nil.
        ///
        /// `controlEvents`
        ///
        /// A bitmask specifying the control-specific events for which the action method is called. Always specify at least one constant. For a list of possible constants, see UIControlEvents.
        case custom(target: Any?, method: Selector, controlEvents: UIControl.Event)
        
        /// Specifies an action that should be called and provides a closure to call after execution.
        /// The communication closure may be used for any purpose. Actions should be returned on the main queue, failure to do so will result in undefined behaviour.
        @available(*, deprecated)
        indirect case callback(Action, CommunicationClosure)
    }
    
    /// Contains metadata for an `Action`.
    private struct MetaAction {
        /// Action target.
        var target: Any?
        
        /// Method selector for the action.
        var action: Selector
        
        /// Control events for which the action will be triggered.
        var controlEvents: UIControl.Event
    }
    
    // MARK: - Properties
    
    /// Stage view controller that owns the stage control.
    open weak internal(set) var controller: SFOnboardingStageViewController?
    
    /// Collection of all actions that will be performed for the given control.
    open var actions: [Action]
    
    /// Maps a method selector to a specific closure designated for communication.
    @available(*, deprecated)
    private lazy var callbackTable: [Selector: CommunicationClosure] = [:]
    
    // MARK: - Initialization
    
    /// Initializes a new stage control using the title & actions specified.
    ///
    /// - Parameters:
    ///   - localizedTitle: Title will be presented to the user for a given control.
    ///   - actions: Collection of all actions that may be performed for the control object. Default value is `[.default]`.
    public init(localizedTitle: String, actions: [Action] = [.inherited]) {
        self.actions = actions
        super.init(localizedTitle: localizedTitle)
    }
    
    // MARK: - Preparation
    
    /// Prepares a control for a given set of actions that have been designated by the receiver.
    ///
    /// - Parameters:
    ///   - control: Object which actions will be added to.
    ///   - defaultAction: Action that will be run when a `.default` `Action` is encountered. This value must be an `Action` with the `custom(target:method:controlEvents:)` case. Providing another case invokes undefined behaviour.
    ////  - controller: Onboarding stage view controller that will be used as the ultimate `target` when needed. The `controller` is weakly referenced.
    open func prepare(_ control: UIControl, withDefaultAction defaultAction: Action?,
                      for controller: SFOnboardingStageViewController?) {
        // Copy the controller weakly.
        self.controller = controller
        
        // Call super.
        super.prepare(control)
        
        // Set the localized title on the control, if it is a button.
        if let control = control as? UIButton {
            control.setTitle(localizedTitle, for: .normal)
        }
        
        // Enumerate each action.
        for action in actions {
            switch action {
            case .inherited:
                if let defaultAction = defaultAction {
                    addAction(defaultAction, to: control)
                }
            default:
                // Add the target to the control.
                addAction(action, to: control)
            }
        }
    }
    
    // MARK: - Meta Action Interface
    
    /// Creates a `MetaAction` that includes the metadata of `action`.
    ///
    /// - Parameter action: The action which the `MetaAction` will be based on.
    /// - Returns: Initialized `MetaAction` derrived from `action`.
    ///
    /// - Note: Calling this method will cause any relevant events to occur. For example, if a `.callback` case is provided as `action` it will be added to the callback table automatically. Therefore, it would be wise to use this method only when required and deemed a sufficent requirement. Result caching may be a useful technique in certain cases.
    private func metaAction(for action: Action) -> MetaAction {
        switch action {
        case let .dismissOnboardingController(controlEvents):
            return MetaAction(target: self, action: .dismissOnboardingController, controlEvents: controlEvents)
        case let .startActivityIndicator(controlEvents):
            return MetaAction(target: self, action: .startActivityIndicator, controlEvents: controlEvents)
        case let .stopActivityIndicator(controlEvents):
            return MetaAction(target: self, action: .stopActivityIndicator, controlEvents: controlEvents)
        case let .enableUserInteraction(controlEvents):
            return MetaAction(target: self, action: .enableUserInteraction, controlEvents: controlEvents)
        case let .disableUserInteraction(controlEvents):
            return MetaAction(target: self, action: .disableUserInteraction, controlEvents: controlEvents)
        case let .pushNextStage(controlEvents):
            return MetaAction(target: self, action: .pushNextStage, controlEvents: controlEvents)
        case let .popStage(controlEvents):
            return MetaAction(target: self, action: .popStage, controlEvents: controlEvents)
        case let .custom(target, method, controlEvents):
            return MetaAction(target: target, action: method, controlEvents: controlEvents)
        case let .closure(controlEvents, closure):
            // Create an Objective-C block that wraps the closure call.
            let closureBlock: @convention(block) (AnyObject?, AnyObject?) -> (Void) = { [weak self] (_self: AnyObject?, sender: AnyObject?) in
                guard let strongSelf = self else { return }
                
                // Execute the callback, passing in the closure for additional calling.
                closure(strongSelf.controller, sender) { actions in
                    for action in actions {
                        strongSelf.callAction(action, sender: sender)
                    }
                }
            }
            
            // Create the implementation using the closureBlock.
            let implementation = imp_implementationWithBlock(unsafeBitCast(closureBlock, to: AnyObject.self))
            
            // Make a random selector.
            let name = Selector(UUID().uuidString)
            
            // Attempt to add the method to the class.
            let didAddMethod = class_addMethod(object_getClass(self), name, implementation, "v@:@")
            
            // Assert that the method was added.
            assert(didAddMethod, "class_addMethod did not add method implementation for unique selector")
            
            return MetaAction(target: self, action: name, controlEvents: controlEvents)
        default:
            fatalError("expected action to be handled independently")
        }
    }
    
    /// Adds an action as a target to `control`.
    ///
    /// - Parameters:
    ///   - action: The action that will be added to the control.
    ///   - control: The control the action will be added to.
    private func addAction(_ action: Action, to control: UIControl) {
        addMetaAction(metaAction(for: action), to: control)
    }
    
    /// Adds a `MetaAction` as a target to `control`.
    ///
    /// - Parameters:
    ///   - meta: The `MetaAction` that will be added to `control`.
    ///   - control: The control the action will be added to.
    private func addMetaAction(_ meta: MetaAction, to control: UIControl) {
        // Add the target to the control.
        control.addTarget(meta.target, action: meta.action, for: meta.controlEvents)
    }
    
    /// Returns the method selector for a given `action`.
    private func methodSelector(for action: Action) -> Selector {
        return metaAction(for: action).action
    }
    
    /// Performs the selector for a given action passing `sender`.
    ///
    /// - Parameters:
    ///   - action: The action that will be called.
    ///   - sender: The object associated with the action calling.
    internal func callAction(_ action: Action, sender: Any?) {
        // Retrieve the MetaAction for this action.
        let meta = metaAction(for: action)
        
        // Unwrap the target.
        let target = (meta.target as AnyObject?) ?? self
        
        // Perform the action, as determined by the 'meta' object.
        let _ = target.perform(meta.action, with: sender)
    }
    
    /// Executes a callback retrieved from the `callbackTable` on behalf of a given method selector.
    ///
    /// - Parameters:
    ///   - method: Selector for a method that will be called.
    ///   - sender: The object that is associated with executing the callback.
    @available(*, deprecated)
    private func executeCallback(forMethod method: Selector, sender: Any?) {
        // Retrieve the callback using the given method selector.
        let callback = callbackTable[method]
        
        // Execute the callback, passing in the closure for additional calling.
        callback?(controller, sender) { actions in
            for action in actions {
                self.callAction(action, sender: sender)
            }
        }
    }
    
    /// Dismisses the onboarding controller entirely.
    @objc internal func dismissOnboardingController(_ sender: Any?) {
        // Dismiss the onboarding controller itself.
        controller?.onboardingController?.dismiss(animated: true)
    }
    
    /// Starts an activity indicator in the view.
    @objc internal func startActivityIndicator(_ sender: Any?) {
        guard let controller = controller else { return }
        
        // Selectively assign the sender.
        let trailingButton = controller.trailingButton!
        
        // Configure an activity indicator (i.e., spinner).
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.color = UIColorMetrics(forAppearance: trailingButton.appearance).color(forRelativeHue: .darkGray)
        activityIndicator.alpha = 0.0
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the indicator to the view & activate constraints for it to match the sender's position.
        controller.view.addSubview(activityIndicator)
        controller.view.addConstraints([activityIndicator.centerXAnchor.constraint(equalTo: trailingButton.centerXAnchor),
                                        activityIndicator.centerYAnchor.constraint(equalTo: trailingButton.centerYAnchor)])
        
        // Start spinning.
        activityIndicator.startAnimating()
        
        // Hide the sender & display the indicator.
        UIView.animate(withDuration: 0.25) {
            trailingButton.alpha = 0.0
            trailingButton.isHidden = true
            activityIndicator.alpha = 1.0
        }
    }
    
    /// Stops an activity indicator within the view.
    @objc internal func stopActivityIndicator(_ sender: UIActivityIndicatorView) {
        guard let controller = controller else { return }
        
        // Retrieve the values from the sender.
        let button = controller.trailingButton!
        let activityIndicator = sender
        
        // Prepare the button and activity indicator.
        activityIndicator.hidesWhenStopped = false
        activityIndicator.stopAnimating()
        button.alpha = 0.0
        button.isHidden = false
        
        // Hide the sender & display the indicator.
        UIView.animate(withDuration: 0.25, animations: {
            activityIndicator.alpha = 0.0
            button.alpha = 1.0
        }) { finished in
            activityIndicator.removeFromSuperview()
        }
    }
    
    /// Enables user interaction for the controller's view.
    @objc internal func enableUserInteraction(_ sender: Any?) {
        // Retrieve the controller from the user info map table.
        guard let controller = controller else { return }
        
        // Disable user interaction.
        controller.view.isUserInteractionEnabled = true
    }
    
    /// Disables user interaction for the controller's view.
    @objc internal func disableUserInteraction(_ sender: Any?) {
        // Retrieve the controller from the user info map table.
        guard let controller = controller else { return }
        
        // Disable user interaction.
        controller.view.isUserInteractionEnabled = false
    }
    
    /// Pushes the next stage controller onto the onboarding stack.
    @objc internal func pushNextStage(_ sender: Any?) {
        // Retrieve the controller from the user info map table.
        guard let controller = controller else { return }
        
        // Present the suceeding stage.
        controller.onboardingController?.presentStage(after: controller.stage, animated: true)
    }
    
    /// Pops the curent stage controller from the top of the onboarding stack.
    @objc internal func popStage(_ sender: Any?) {
        // Retrieve the controller from the user info map table.
        guard let controller = controller else { return }
        
        // Pop the current view controller from the onboarding stack.
        controller.onboardingController?.popViewController(animated: true)
    }
}
