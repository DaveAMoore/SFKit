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
    /// - Parameter isDismissing: Boolean value indicating if the animation should be reflective of a pop.
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
    
    /// Creates a container view that has a `frame` equal to the `sourceView`'s boundaries. The container view will have added all of the subviews to its view hierarchy.
    ///
    /// - Parameters:
    ///   - sourceView: View that will contain the container view. The container view will inherit its boundaries, in addition to being automatically added as a subview.
    ///   - subviews: Collection of views that will be added to the container view automatically, inheriting the container's boundaries.
    /// - Returns: Container view that has been configured and has been added as a subview of the `sourceView`.
    func containerView(for sourceView: UIView, with subviews: [UIView]) -> UIView {
        // Create a new container.
        let container = UIView(frame: sourceView.bounds)
        
        // Enumerate the subviews.
        for subview in subviews {
            // Configure the layout properties.
            subview.translatesAutoresizingMaskIntoConstraints = true
            subview.frame = container.bounds
            
            // Remove it from its superview.
            subview.removeFromSuperview()
            
            // Add the subivew to the container.
            container.addSubview(subview)
        }
        
        // Add the container to the source view.
        sourceView.addSubview(container)
        
        return container
    }
    
    /// Animates the transition between the `source` view controller and the `destination` view controller.
    ///
    /// - Parameters:
    ///   - source: View controller that is being transitioned *from*. This view controller will be hidden under normal circumstances, but revealed when dismissing.
    ///   - destination: View controller that is being transitioned *to*. This view controller will be presented under normal circumstances, but popped when dismissing.
    ///   - containerView: View that will contain and host the animation in its entirety. The animation will not affect the frame of the container view. This view can use autolayout, if desired. Subviews should not use autolayout with respect to the view itself. Subviews can contain autolayout constraints hosted within their frames, as these do not affect the animation directly.
    ///   - completionHandler: Closure that is called when the animation is either completed or cancelled. The boolean value passed along with execution indicates if the transition is `finished`.
    func animateTransition(from source: UIViewController, to destination: UIViewController,
                           withContainerView containerView: UIView, completionHandler: ((Bool) -> Void)?) {
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
        destination.view.layer.shadowColor = UIColorMetrics(forAppearanceStyle: .light).color(forRelativeHue: .black).cgColor
        destination.view.layer.shadowOffset = .zero
        destination.view.layer.shadowRadius = 4.0
        destination.view.layer.shadowOpacity = shadowFromValue
        
        // Set the view origin offscreen.
        destination.view.frame.origin.x = xFromValue
        
        // Add the destination view to the container.
        if isDismissing {
            source.view.translatesAutoresizingMaskIntoConstraints = true
            source.view.frame = containerView.bounds
            containerView.insertSubview(source.view, at: 0)
        } else {
            containerView.addSubview(destination.view)
        }
        
        // Retrieve the animation duration.
        let duration = transitionDuration(using: nil)
        
        // Configure a CoreAnimation shadow animation.
        let shadowAnimation = CABasicAnimation(keyPath: "shadowOpacity")
        shadowAnimation.fillMode = CAMediaTimingFillMode.forwards
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
            // Call the completion handler.
            completionHandler?(position == .end)
        }
        
        // Start the animation.
        animator.startAnimation()
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
            let destination = transitionContext.viewController(forKey: toKey) else {
                transitionContext.completeTransition(false)
                return
        }
        
        // Call the animation method.
        animateTransition(from: source, to: destination, withContainerView: transitionContext.containerView) { finished in
            // Notify the context that the transition has been completed, if it indeed has been.
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
