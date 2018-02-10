//
//  SFOnboardingStageControl.swift
//  SFKit
//
//  Created by David Moore on 1/30/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

public let kSFOnboardingStageControlOnboardingStageViewController = "controller" as NSString

fileprivate extension Selector {
    
    static let dismissOnboardingController = #selector(SFOnboardingStageControl.dismissOnboardingController(_:))
    
    static let startActivityIndicator = #selector(SFOnboardingStageControl.startActivityIndicator(_:))
    
    static let stopActivityIndicator = #selector(SFOnboardingStageControl.stopActivityIndicator(_:))
    
    static let enableUserInteraction = #selector(SFOnboardingStageControl.enableUserInteraction(_:))
    
    static let disableUserInteraction = #selector(SFOnboardingStageControl.disableUserInteraction(_:))
}

open class SFOnboardingStageControl: SFOnboardingStageElement {
    
    // MARK: - Types
    
    /// Closure used for communication between the receiver and caller of an initialization call.
    public typealias CommunicationClosure = ((Any?, (@escaping ([Action]) -> Void)) -> Void)
    
    /// Wrapper for `Selector` that allows precise indication of action-related parameters.
    public enum Action {
        /// Represents the action(s) that are automatically set by the control itself.
        case inherited
        
        /// Dismisses the entire onboarding controller.
        case dismissOnboardingController
        
        /// Presents an activity indicator and starts it.
        case startActivityIndicator
        
        /// Stops an activity indicator and then removes it from the view hierarchy.
        case stopActivityIndicator
        
        /// Enables user interaction of the controller's view.
        case enableUserInteraction
        
        /// Disables user interaction of the controller's view.
        case disableUserInteraction
        
        indirect case callback(Action, CommunicationClosure)
        
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
        case custom(target: Any?, method: Selector, controlEvents: UIControlEvents)
    }
    
    /// Contains metadata for an `Action`.
    private struct MetaAction {
        /// Action target.
        var target: Any?
        
        /// Method selector for the action.
        var action: Selector
        
        /// Control events for which the action will be triggered.
        var controlEvents: UIControlEvents
    }
    
    // MARK: - Properties
    
    /// Contains a hodgepodge of different objects that are stored under keys.
    open var userInfo = NSMapTable<NSString, AnyObject>.strongToWeakObjects()
    
    /// Collection of all actions that will be performed for the given control.
    open var actions: [Action]
    
    private lazy var callbackTable: [Selector: CommunicationClosure] = [:]
    
    /// Stage view controller that owns the stage control.
    private var controller: SFOnboardingStageViewController? {
        return userInfo.object(forKey: kSFOnboardingStageControlOnboardingStageViewController) as? SFOnboardingStageViewController
    }
    
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
    
    // MARK: -
    
    /// Prepares a control for a given set of actions that have been designated by the receiver.
    ///
    /// - Parameters:
    ///   - control: Object which actions will be added to.
    ///   - defaultAction: Action that will be run when a `.default` `Action` is encountered. This value must be an `Action` with the `custom(target:method:controlEvents:)` case. Providing another case invokes undefined behaviour.
    ////  - controller: Onboarding stage view controller that will be used as the ultimate `target` when needed. The `controller` is weakly referenced.
    open func prepare(_ control: UIControl, withDefaultAction defaultAction: Action?,
                      for controller: SFOnboardingStageViewController) {
        // Copy the controller weakly to the user info dictionary.
        userInfo.setObject(controller, forKey: kSFOnboardingStageControlOnboardingStageViewController)
        
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
        case .dismissOnboardingController:
            return MetaAction(target: self, action: .dismissOnboardingController, controlEvents: .touchUpInside)
        case .startActivityIndicator:
            return MetaAction(target: self, action: .startActivityIndicator, controlEvents: .touchUpInside)
        case .stopActivityIndicator:
            return MetaAction(target: self, action: .stopActivityIndicator, controlEvents: .touchUpInside)
        case .enableUserInteraction:
            return MetaAction(target: self, action: .enableUserInteraction, controlEvents: .touchUpInside)
        case .disableUserInteraction:
            return MetaAction(target: self, action: .disableUserInteraction, controlEvents: .touchUpInside)
        case let .custom(target, method, controlEvents):
            return MetaAction(target: target, action: method, controlEvents: controlEvents)
        case let .callback(action, closure):
            // Retrieve the meta-action for the action.
            let meta = metaAction(for: action)
            
            // Add the closure to the table.
            callbackTable[meta.action] = closure
            
            return meta
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
    private func callAction(_ action: Action, sender: Any?) {
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
    private func executeCallback(forMethod method: Selector, sender: Any?) {
        // Retrieve the callback using the given method selector.
        let callback = callbackTable[method]
        
        // Execute the callback, passing in the closure for additional calling.
        callback?(sender) { actions in
            for action in actions {
                self.callAction(action, sender: sender)
            }
        }
    }
    
    /// Dismisses the onboarding controller entirely.
    @objc internal func dismissOnboardingController(_ sender: Any?) {
        // Dismiss the onboarding controller itself.
        controller?.onboardingController?.dismiss(animated: true)
        
        // Execute the callback.
        executeCallback(forMethod: .dismissOnboardingController, sender: sender)
    }
    
    /// Starts an activity indicator in the view.
    @objc internal func startActivityIndicator(_ sender: UIButton) {
        guard let controller = controller else { return }
        
        // Configure an activity indicator (i.e., spinner).
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.color = SFColor.darkGray
        activityIndicator.alpha = 0.0
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the indicator to the view & activate constraints for it to match the sender's position.
        controller.view.addSubview(activityIndicator)
        controller.view.addConstraints([activityIndicator.centerXAnchor.constraint(equalTo: sender.centerXAnchor),
                                        activityIndicator.centerYAnchor.constraint(equalTo: sender.centerYAnchor)])
        
        // Start spinning.
        activityIndicator.startAnimating()
        
        // Hide the sender & display the indicator.
        UIView.animate(withDuration: 0.25) {
            sender.alpha = 0.0
            sender.isHidden = true
            activityIndicator.alpha = 1.0
        }
        
        // Execute the callback.
        executeCallback(forMethod: .startActivityIndicator, sender: [sender, activityIndicator])
    }
    
    @objc internal func stopActivityIndicator(_ sender: [Any]) {
        // Retrieve the values from the sender.
        let button = sender[0] as! UIButton
        let activityIndicator = sender[1] as! UIActivityIndicatorView
        
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
        
        // Execute the callback.
        executeCallback(forMethod: .stopActivityIndicator, sender: sender)
    }
    
    @objc internal func enableUserInteraction(_ sender: Any?) {
        // Retrieve the controller from the user info map table.
        guard let controller = controller else { return }
        
        // Disable user interaction.
        controller.view.isUserInteractionEnabled = true
        
        // Execute the callback.
        executeCallback(forMethod: .enableUserInteraction, sender: sender)
    }
    
    @objc internal func disableUserInteraction(_ sender: Any?) {
        // Retrieve the controller from the user info map table.
        guard let controller = controller else { return }
        
        // Disable user interaction.
        controller.view.isUserInteractionEnabled = false
        
        // Execute the callback.
        executeCallback(forMethod: .disableUserInteraction, sender: sender)
    }
}
