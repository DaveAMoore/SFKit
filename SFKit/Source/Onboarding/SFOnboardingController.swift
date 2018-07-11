//
//  SFOnboardingController.swift
//  SFKit
//
//  Created by David Moore on 1/28/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

/// Modal view controller that has been designed to provide a concrete and consistent onboarding experience. The design is referenced from an internal resource, thus limiting complete customization to a certain degree.
///
/// # Onboarding
/// Launch time is your first opportunity to onboard new users and reconnect with returning ones. Use `SFOnboardingController` to design a launch experience that’s fast, fun, and educational.
open class SFOnboardingController: UIViewController {

    // MARK: - Properties
    
    /// Collection of all stages that will be presented by the receiver.
    open private(set) var stages: [SFOnboardingStage]
    
    /// Dictionary that may contain a variety of different value pairs without any particular specificity.
    open lazy var userInfo: [AnyHashable: Any] = [:]
    
    /// The view controller at the root of the onboarding stack.
    open var rootViewController: UIViewController? {
        return children.first
    }
    
    /// The view controller at the top of the onboarding stack.
    open var topViewController: UIViewController? {
        return children.last
    }
    
    /// The view controller associated with the currently visible view in the onboarding stack. The currently visible view can belong either to the view controller at the top of the onboarding stack or to a view controller that was presented modally on top of the onboarding controller itself.
    open var visibleViewController: UIViewController? {
        return presentedViewController ?? topViewController
    }
    
    /// The view controllers currently on the onboarding stack.
    open var viewControllers: [UIViewController] {
        return children
    }
    
    /// Child view controller that is responsible for the status bar.
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
    // MARK: - Initialization
    
    /// Initializes a new onboarding controller with a collection of stages.
    public init(stages: [SFOnboardingStage] = []) {
        self.stages = stages
        
        // Call super.
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.stages = []
        
        // Call super.
        super.init(coder: aDecoder)
    }
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Configure properties.
        definesPresentationContext = true
        providesPresentationContextTransitionStyle = true
        
        // Attempt to push the root onto the onboarding stack.
        pushRootViewController()
    }
    
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - View Controller Management
    
    /// Creates a new view controller for a stage. Intended to be used before calling `pushViewController(_:animated:)`.
    ///
    /// - Parameter stage: Stage for which the view controller will be configured.
    /// - Returns: New onboarding stage view controller that has its stage property configured, and is ready for presentation.
    open func viewController(for stage: SFOnboardingStage) -> SFOnboardingStageViewController {
        // Load the NIB from the bundle.
        let nib = UINib(nibName: SFOnboardingStageViewController.typeName,
                        bundle: Bundle(for: SFOnboardingStageViewController.self))
        
        // Instantiate and retrieve the view controller.
        let contentController = nib.instantiate(withOwner: nil, options: nil).first as! SFOnboardingStageViewController
        
        // Configure the stage property.
        contentController.stage = stage
        
        return contentController
    }
    
    /// Pushes a view controller onto the receiver's stack and updates the display.
    ///
    /// - Parameters:
    ///   - viewController: The view controller to push onto the stack. If the view controller is already on the onboarding stack, this method throws an exception.
    ///   - isAnimated: Specify `true` to indicate that the transition should be animated or `false` to indicate that you do not want the transition to be animated. You might specify `false` during initial setup, where it is not necessary.
    open func pushViewController(_ viewController: UIViewController, animated isAnimated: Bool) {
        // Ensure that the view controller hasn't already been pushed.
        assert(!viewControllers.contains(viewController), "expected 'viewController' to not already be presented")
        
        // Update the controller's size so it appears to match the previous controller.
        viewController.view.frame.size = view.frame.size
        
        // Copy the reference for later usage.
        let topViewController = self.topViewController
        
        // Create a completion closure that will handle the final process.
        let completionHandler: ((Bool) -> Void) = { finished in
            // Add the subview, if it hadn't already been added.
            if viewController.view.superview == nil {
                self.view.addSubview(viewController.view)
            }
            
            // Remove the previous view controller from the hierarchy.
            topViewController?.view.removeFromSuperview()
            
            // Add constraints.
            self.addConstraints(to: viewController)
            
            // Notify the content controller that it has been moved to a new parent view controller.
            viewController.didMove(toParent: self)
        }
        
        // Add the view controller to the hierarchy.
        addChild(viewController)
        
        // Perform the animation only if it has been requested.
        guard isAnimated, let _visibleViewController = topViewController else {
            completionHandler(false)
            return
        }
        
        // Create a new push animator.
        let pushAnimator = SFOnboardingPushAnimator(isDismissing: false)
        
        // Transition between the controller's.
        pushAnimator.animateTransition(from: _visibleViewController, to: viewController,
                                       withContainerView: view, completionHandler: completionHandler)
    }
    
    /// Pops view controllers until the specified view controller is at the top of the navigation stack.
    ///
    /// - Parameters:
    ///   - viewController: The view controller that you want to be at the top of the stack. This view controller must currently be on the onboarding stack.
    ///   - isAnimated: Specify `true` to indicate that the transition should be animated or `false` to indicate that you do not want the transition to be animated. You might specify `false` during initial setup, where it is not necessary.
    /// - Returns: An array containing the view controllers that were popped from the stack.
    @discardableResult
    open func popToViewController(_ viewController: UIViewController, animated isAnimated: Bool) -> [UIViewController]? {
        // Ensure the view controller that we're trying to pop to is included in the stack.
        assert(viewControllers.contains(viewController), "expected 'viewController' to be included in the onboarding stack")
        
        // Do not continue if there is nothing to be done.
        guard topViewController != viewController else { return nil }
        
        // Determine the index of the view controller on the onboarding stack.
        let viewControllerIndex = viewControllers.index(of: viewController)!
        
        // Retrieve an array slice containing all of the view controllers that must be removed.
        var viewControllersToPop = viewControllers[(viewControllerIndex + 1)..<viewControllers.endIndex]
        
        // Remove the last view controller.
        let lastViewController = viewControllersToPop.removeLast()
        
        // Notify the child that it will be removed.
        lastViewController.willMove(toParent: nil)
        
        // Declare a closure that will handle the completion.
        let completionHandler: ((Bool) -> Void) = { finished in
            // Remove the view.
            lastViewController.view.removeFromSuperview()
            
            // Remove the child.
            lastViewController.removeFromParent()
            
            // Enumerate through each view controller that must be popped.
            for viewControllerToPop in viewControllersToPop {
                viewControllerToPop.willMove(toParent: nil)
                viewControllerToPop.removeFromParent()
            }
            
            // Add the destination view.
            self.view.addSubview(viewController.view)
            
            // Add constraints to the destination controller.
            self.addConstraints(to: viewController)
        }
        
        // Only continue if the popping is animated.
        guard isAnimated else {
            completionHandler(false)
            return Array(viewControllersToPop)
        }
        
        // Create a new push animator.
        let pushAnimator = SFOnboardingPushAnimator(isDismissing: true)
        
        // Create a new container view for the visible view controller.
        let containerView = pushAnimator.containerView(for: view, with: [lastViewController.view])
        
        // Transition between the controller's.
        pushAnimator.animateTransition(from: viewController, to: lastViewController, withContainerView: containerView) { finished in
            // Remove the controller's view from the container, then remove the container.
            lastViewController.view.removeFromSuperview()
            viewController.view.removeFromSuperview()
            containerView.removeFromSuperview()
            
            // Call completion.
            completionHandler(finished)
        }
        
        return Array(viewControllersToPop)
    }
    
    /// Pops the top view controller from the onboarding stack and updates the display.
    ///
    /// - Parameter isAnimated: Specify `true` to indicate that the transition should be animated or `false` to indicate that you do not want the transition to be animated. You might specify `false` during initial setup, where it is not necessary.
    @discardableResult
    open func popViewController(animated isAnimated: Bool) -> UIViewController? {
        guard topViewController != rootViewController else { return nil }
        
        // Retrieve the destination view controller.
        let destination = viewControllers[viewControllers.endIndex - 2]
        
        return popToViewController(destination, animated: isAnimated)?.first
    }
    
    /// Pops all the view controllers on the onboarding stack, except for the root view controller, and updates the display.
    ///
    /// - Parameter isAnimated: Specify `true` to indicate that the transition should be animated or `false` to indicate that you do not want the transition to be animated. You might specify `false` during initial setup, where it is not necessary.
    /// - Returns: An array of view controllers representing the items that were popped from the stack.
    @discardableResult
    open func popToRootViewController(animated isAnimated: Bool) -> [UIViewController]? {
        guard let rootViewController = rootViewController else { return nil }
        return popToViewController(rootViewController, animated: isAnimated)
    }
    
    // MARK: - Stage Presentation Management
    
    /// Presents a new stage succeeding a specific `stage`, if there is one after it.
    ///
    /// - Parameters:
    ///   - stage: Stage that functions as the preceeding parameter.
    ///
    /// - Note: In the event where there is no succeeding stage to be presented, the receiver/caller remain unaffected.
    open func presentStage(after stage: SFOnboardingStage, animated isAnimated: Bool) {
        // Determine the index of the given stage.
        guard let index = stages.index(of: stage) else { return }
        
        // Calculate the next index.
        let newIndex = stages.index(after: index)
        
        // Ensure the index is within bounds.
        if newIndex < stages.endIndex {
            // Retrieve the stage and create a content controller for it.
            let stage = stages[newIndex]
            let content = viewController(for: stage)
            
            // Push to the content view controller.
            pushViewController(content, animated: isAnimated)
        }
    }
    
    /// Presents a new stage after the current stage, if there is one after it.
    ///
    /// - Parameter isAnimated: Boolean value indicating if the push will be animated.
    open func pushNextStage(animated isAnimated: Bool) {
        // Retrieve the current top view controller.
        let currentStageController = topViewController as? SFOnboardingStageViewController
        
        // Determine the index of the given stage.
        guard let currentStage = currentStageController?.stage,
            let index = stages.index(of: currentStage) else { return }
        
        // Calculate the next index.
        let newIndex = stages.index(after: index)
        
        // Ensure the index is within bounds.
        if newIndex < stages.endIndex {
            // Retrieve the stage and create a content controller for it.
            let stage = stages[newIndex]
            let content = viewController(for: stage)
            
            // Push to the content view controller.
            pushViewController(content, animated: isAnimated)
        }
    }
    
    /// Pushes the provided stage onto the onboarding stack.
    ///
    /// - Parameters:
    ///   - stage: Stage that will be presented.
    ///   - isAnimated: Boolean value indicating if the push will be animated.
    open func push(_ stage: SFOnboardingStage, animated isAnimated: Bool) {
        // Ensure the stage has been added, and if not then add it.
        if !stages.contains(stage) {
            stages.append(stage)
        }
        
        // Retrieve the content controller.
        let content = viewController(for: stage)
        
        // Push to the content view controller.
        pushViewController(content, animated: isAnimated)
    }
    
    // MARK: - Helper Methods
    
    /// Pushes the root view controller onto the onboarding stack.
    private func pushRootViewController() {
        // Only continue if the view has loaded and there is an initial stage.
        guard let _ = viewIfLoaded, let stage = stages.first else { return }
        
        // Create a view controller.
        let content = viewController(for: stage)
        
        // Push that controller onto the stack.
        pushViewController(content, animated: false)
    }
    
    /// Adds standard boundary constraints between the `viewController` and the receiver.
    ///
    /// - Parameter viewController: View controller that will have its view constrained to the bounds of the receiver's view.
    ///
    /// - Note: The layout constraints that will be added use the following visual format:
    /// - `V:|[view]|`
    /// - `H:|[view]|`
    private func addConstraints(to viewController: UIViewController) {
        // Disable auto constraints.
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Add constraints to the content view.
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                                   options: [], metrics: nil,
                                                                   views: ["view": viewController.view]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                                   options: [], metrics: nil,
                                                                   views: ["view": viewController.view]))
    }
    
    // MARK: - Stage Management
    
    /// Appends a stage object to the controller's queue.
    ///
    /// - Parameter stage: A stage that will be appended to the end of the current `stages` collection.
    open func addStage(_ stage: SFOnboardingStage) {
        insertStage(stage, at: stages.endIndex)
    }
    
    /// Inserts a stage object into the controller's stack queue at a specific index. The new element is inserted before the element currently at the specified index. If you pass the array’s endIndex property as the index parameter, the new element is appended to the array.
    ///
    /// - Parameters:
    ///   - stage: The stage that will be inserted into the `stages` array.
    ///   - index: Index where the stage will be inserted.
    open func insertStage(_ stage: SFOnboardingStage, at index: Int) {
        // Insert the stage.
        stages.insert(stage, at: index)
        
        // Try to push the root if it seems eligible.
        if stages.first == stage, let _ = viewIfLoaded {
            // Attempt to push the root onto the onboarding stack.
            pushRootViewController()
        }
    }
    
    /// Removes a stage object that is located at a specific index.
    ///
    /// - Parameter index: The index of the stage that will be removed.
    open func removeStage(at index: Int) {
        stages.remove(at: index)
    }
}
