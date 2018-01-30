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
final public class SFOnboardingController: SFViewController {

    // MARK: - Properties
    
    /// Collection of all stages that will be presented by the receiver.
    final public private(set) var stages: [SFOnboardingStage]
    
    public override var childViewControllerForStatusBarStyle: UIViewController? {
        return childViewControllers.last
    }
    
    // MARK: - Initialization
    
    /// Initializes a new onboarding controller with a collection of stages.
    public init(stages: [SFOnboardingStage]) {
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
    
    final public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Configure properties.
        definesPresentationContext = true
        providesPresentationContextTransitionStyle = true
        
        // Request that the primary content controller be presented.
        presentPrimaryContentController()
    }
    
    final private func presentPrimaryContentController() {
        guard let _ = viewIfLoaded, let stage = stages.first else { return }
        
        // Present the first stage as the primary content controller.
        let contentController = viewController(for: stage)
        presentContentController(contentController)
    }
    
    final private func viewController(for stage: SFOnboardingStage) -> SFOnboardingStageViewController {
        // Load the NIB from the bundle.
        let nib = UINib(nibName: SFOnboardingStageViewController.typeName,
                        bundle: Bundle(for: SFOnboardingStageViewController.self))
        
        // Instantiate and retrieve the view controller.
        let contentController = nib.instantiate(withOwner: nil, options: nil).first as! SFOnboardingStageViewController
        
        // Configure the stage property.
        contentController.stage = stage
        
        return contentController
    }
    
    final private func presentContentController(_ content: SFViewController) {
        // Add the content controller to the hierarchy.
        addChildViewController(content)
        
        // Configure the content view.
        content.view.translatesAutoresizingMaskIntoConstraints = false
        content.view.frame = view.bounds
        
        // Add the subview.
        view.addSubview(content.view)
        
        // Add constraints to the content view.
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                                   options: [], metrics: nil,
                                                                   views: ["view": content.view]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                                   options: [], metrics: nil,
                                                                   views: ["view": content.view]))
        
        // Notify the content controller that it has been moved to a new parent view controller.
        content.didMove(toParentViewController: self)
    }
    
    final public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Stage Presentation
    
    final internal func presentStage(succeeding stage: SFOnboardingStage, sender: SFViewController) {
        // Determine the index of the given stage.
        guard let index = stages.index(of: stage) else { return }
        
        // Calculate the next index.
        let newIndex = stages.index(after: index)
        
        // Ensure the index is within bounds.
        if newIndex <= stages.endIndex {
            // Retrieve the stage and create a content controller for it.
            let stage = stages[newIndex]
            let content = viewController(for: stage)
            
            // Present the controller.
            sender.present(content, animated: true)
        }
    }
    
    final internal func dismissCurrentStage() {
        
    }
    
    // MARK: - Stage Management
    
    /// Appends a stage object to the controller's queue.
    ///
    /// - Parameter stage: A stage that will be appended to the end of the current `stages` collection.
    final public func addStage(_ stage: SFOnboardingStage) {
        // Add the stage to the collection.
        stages.append(stage)
        
        if stages.first == stage, let _ = viewIfLoaded {
            presentPrimaryContentController()
        }
    }
}
