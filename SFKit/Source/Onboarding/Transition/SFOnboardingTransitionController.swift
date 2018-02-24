//
//  SFOnboardingTransitionController.swift
//  Hydro Fit
//
//  Created by David Moore on 1/12/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

internal class SFOnboardingTransitionController: NSObject, UIViewControllerTransitioningDelegate {
    
    /// Transition animator responsible for presenting the destination view controller.
    var presentingAnimator: UIViewControllerAnimatedTransitioning?
    
    /// Transition animator associated with dismissing a given view controller.
    var dismissingAnimator: UIViewControllerAnimatedTransitioning?
    
    /// Initializes a new transition controller with transition animators.
    init(withPresentingAnimator presentingAnimator: UIViewControllerAnimatedTransitioning?, dismissingAnimator: UIViewControllerAnimatedTransitioning? = nil) {
        self.presentingAnimator = presentingAnimator
        self.dismissingAnimator = dismissingAnimator
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentingAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissingAnimator
    }
}
