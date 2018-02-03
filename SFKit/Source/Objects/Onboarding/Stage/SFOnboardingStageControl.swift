//
//  SFOnboardingStageControl.swift
//  SFKit
//
//  Created by David Moore on 1/30/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

public let kSFOnboardingStageControlOnboardingStageViewController = "controller" as NSString

fileprivate extension Selector {
    
    static let dismissOnboardingController = #selector(SFOnboardingStageControl.dismissOnboardingController)
    
    static let startActivityIndicator = #selector(SFOnboardingStageControl.startActivityIndicator)
    
    static let enableUserInteraction = #selector(SFOnboardingStageControl.enableUserInteraction)
    
    static let disableUserInteraction = #selector(SFOnboardingStageControl.disableUserInteraction)
}

open class SFOnboardingStageControl: SFOnboardingStageElement {
    
    /// Closure used for communication between the receiver and caller of an initialization call.
    public typealias CommunicationClosure = ((([Action]) -> Void) -> Void)
    
    /// Wrapper for `Selector` that allows precise indication of action-related parameters.
    public enum Action {
        /// Represents the action that will be set by default.
        case `default`
        
        /// Dismisses the entire onboarding controller.
        case dismissOnboardingController
        
        /// Presents an activity indicator and starts it.
        case startActivityIndicator(CommunicationClosure?)
        
        /// Enables user interaction of the controller's view.
        case enableUserInteraction(CommunicationClosure?)
        
        /// Disables user interaction of the controller's view.
        case disableUserInteraction(CommunicationClosure?)
        
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
    
    /// Contains a hodgepodge of different objects that are stored under keys.
    open var userInfo = NSMapTable<NSString, AnyObject>.strongToWeakObjects()
    
    /// Collection of all actions that will be performed for the given control.
    open var actions: [Action]
    
    /// Stage view controller that owns the stage control.
    private var controller: SFOnboardingStageViewController? {
        return userInfo.object(forKey: kSFOnboardingStageControlOnboardingStageViewController) as? SFOnboardingStageViewController
    }
    
    /// Initializes a new stage control using the title & actions specified.
    ///
    /// - Parameters:
    ///   - localizedTitle: Title will be presented to the user for a given control.
    ///   - actions: Collection of all actions that may be performed for the control object. Default value is `[.default]`.
    public init(localizedTitle: String, actions: [Action] = [.default]) {
        self.actions = actions
        super.init(localizedTitle: localizedTitle)
    }
    
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
        
        // Copy the actions collection.
        var stagedActions = actions
        
        // Add the default action to the staged collection.
        if let defaultAction = defaultAction {
            stagedActions.append(defaultAction)
        }
        
        // Set the localized title on the control, if it is a button.
        if let control = control as? UIButton {
            control.setTitle(localizedTitle, for: .normal)
        }
        
        // Enumerate each action.
        for action in stagedActions {
            switch action {
            case .dismissOnboardingController:
                // Add the relevant target and action sequence.
                control.addTarget(self, action: .dismissOnboardingController, for: .touchUpInside)
            case let .startActivityIndicator(closure):
                closure? { actions in
                    
                }
                
                // Add the relevant target & action.
                control.addTarget(self, action: .startActivityIndicator, for: .touchUpInside)
            case let .custom(target, method, controlEvents):
                // Add the custom target's action for specific control events.
                control.addTarget(target, action: method, for: controlEvents)
            default:
                break
            }
        }
    }
    
    /// Dismisses the onboarding controller entirely.
    @objc internal func dismissOnboardingController() {
        // Dismiss the onboarding controller itself.
        controller?.onboardingController?.dismiss(animated: true)
    }
    
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
    }
    
    @objc internal func enableUserInteraction() {
        // Retrieve the controller from the user info map table.
        guard let controller = controller else { return }
        
        // Disable user interaction.
        controller.view.isUserInteractionEnabled = true
    }
    
    @objc internal func disableUserInteraction() {
        // Retrieve the controller from the user info map table.
        guard let controller = controller else { return }
        
        // Disable user interaction.
        controller.view.isUserInteractionEnabled = false
    }
}
