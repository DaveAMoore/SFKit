//
//  SFOnboardingPushAnimator.swift
//  Hydro Fit
//
//  Created by David Moore on 1/12/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

/// View controller transition animation that is associated with a stack push transition.
///
/// **Transition Duration Values**:
/// - Presenting: 0.6 sec
/// - Dismissing: 0.53 sec
internal class SFOnboardingPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    /// Boolean value indicating if the animation should be reflective of a pop.
    var isDismissing: Bool
    
    /// Initializes a new push animator.
    ///
    /// - Parameter shouldPop: Boolean value indicating if the animation should be reflective of a pop.
    init(isDismissing: Bool = false) {
        self.isDismissing = isDismissing
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        if isDismissing {
            return 0.53
        } else {
            return 0.6
        }
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // Declare from and to view controller keys.
        let fromKey: UITransitionContextViewControllerKey
        let toKey: UITransitionContextViewControllerKey
        
        // Configure the keys.
        if isDismissing {
            fromKey = .to
            toKey = .from
        } else {
            fromKey = .from
            toKey = .to
        }
        
        // Retrieve the source & destination view controllers, safely.
        guard let source = transitionContext.viewController(forKey: fromKey),
            let destination = transitionContext.viewController(forKey: toKey) else { return }
        
        // Declare x value differentials.
        let xFromValue: CGFloat
        let xToValue: CGFloat
        
        // Declare shadow values.
        let shadowFromValue: Float
        let shadowToValue: Float
        
        // Determine the appropriate to & from values based on 'shouldPop'.
        if isDismissing {
            xFromValue = source.view.frame.origin.x
            xToValue = source.view.frame.maxX
            shadowFromValue = 0.2
            shadowToValue = 0.3
        } else {
            xFromValue = source.view.frame.maxX
            xToValue = source.view.frame.origin.x
            shadowFromValue = 0.3
            shadowToValue = 0.0
        }
        
        // Configure the destination view's shadow.
        destination.view.layer.shadowColor = SFColor.black.cgColor
        destination.view.layer.shadowOffset = .zero
        destination.view.layer.shadowRadius = 4.0
        destination.view.layer.shadowOpacity = shadowFromValue
        
        // Set the view origin offscreen.
        destination.view.frame.origin.x = xFromValue
        
        // Add the destination view to the container.
        if isDismissing {
            transitionContext.containerView.insertSubview(source.view, at: 0)
        } else {
            transitionContext.containerView.addSubview(destination.view)
        }
        
        // Retrieve the animation duration.
        let duration = transitionDuration(using: transitionContext)
        
        // Configure a CoreAnimation shadow animation.
        let shadowAnimation = CABasicAnimation(keyPath: "shadowOpacity")
        shadowAnimation.fillMode = kCAFillModeForwards
        shadowAnimation.fromValue = shadowFromValue
        shadowAnimation.toValue = shadowToValue
        shadowAnimation.duration = duration / 1.3
        
        // Create a property animator using a spring timing curve.
        let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: isDismissing ? 1.3 : 3.0) {
            // Move the frame's origin.
            destination.view.frame.origin.x = xToValue
            
            // Perform the shadow animation.
            destination.view.layer.add(shadowAnimation, forKey: "shadowOpacity")
            destination.view.layer.shadowOpacity = shadowToValue
        }
        
        // Add a completion handler.
        animator.addCompletion { position in
            // Notify the context that the transition has been completed, if it indeed has been.
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        // Start the animation.
        animator.startAnimation()
    }
}
