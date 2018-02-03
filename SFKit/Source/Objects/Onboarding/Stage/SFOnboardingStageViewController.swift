//
//  SFOnboardingStageViewController.swift
//  SFKit
//
//  Created by David Moore on 1/29/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

internal extension Selector {
    
    static let primaryButtonAction = #selector(SFOnboardingStageViewController.primaryButtonAction(_:))

    static let secondaryButtonAction = #selector(SFOnboardingStageViewController.secondaryButtonAction(_:))
    
    static let leadingButtonAction = #selector(SFOnboardingStageViewController.leadingButtonAction(_:))
    
    static let trailingButtonAction = #selector(SFOnboardingStageViewController.trailingButtonAction(_:))
}

open class SFOnboardingStageViewController: SFViewController, UITableViewDataSource {
    
    // MARK: - Properties
    
    /// Retained transition controller.
    private let transitionController = SFOnboardingTransitionController(withPresentingAnimator: SFOnboardingPushAnimator(),
                                                                        dismissingAnimator: SFOnboardingPushAnimator(isDismissing: true))
    
    /// Stage associated with this specific view controller.
    final public var stage: SFOnboardingStage! {
        willSet {
            stageWillUpdate()
        } didSet {
            stageDidUpdate()
        }
    }
    
    /// Parent view controller that is an onboarding controller. This property is computed and operates recursively.
    open var onboardingController: SFOnboardingController? {
        return parent as? SFOnboardingController
    }
    
    // MARK: - Outlets
    
    /// Primary button title that will be presented to users.
    @IBOutlet open var primaryButton: UIButton!
    
    /// Secondary button title that will be presented to users.
    ///
    /// - Note: When set to `nil` the secondary button is hidden.
    @IBOutlet open var secondaryButton: UIButton!
    
    /// Leading button title that will be presented to users.
    ///
    /// - Note: When set to `nil` the leading button is hidden.
    @IBOutlet open var leadingButton: UIButton!
    
    /// Trailing button title that will be presented to users.
    ///
    /// - Note: When set to `nil` the trailing button is hidden.
    @IBOutlet open var trailingButton: UIButton!
    
    /// Accessory label that acts as a secondary UI element which can be found above the `primaryControl`.
    @IBOutlet open var accessoryLabel: UILabel!
    
    /// Contains the `leadingButton` and the `trailingButton`.
    ///
    /// - Note: When the leading & trailing buttons are both hidden, this view is also hidden.
    @IBOutlet open var topContainer: UIView!
    
    /// Contains the `primaryButton` and the `secondaryButton`.
    ///
    /// - Note: When the primary & secondary buttons are both hidden, this view is also hidden.
    @IBOutlet open var bottomContainer: UIView!
    
    /// Displays the cards.
    @IBOutlet open var tableView: SFTableView!
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Configure custom modal presentation.
        modalPresentationStyle = .custom
        transitioningDelegate = transitionController
        
        // Hide the seperator for all empty table view cells.
        tableView?.tableFooterView = UIView(frame: .zero)
        
        // Configure the table view's data source.
        tableView.dataSource = self
    }
    
    open override func appearanceStyleDidChange(_ newAppearanceStyle: SFAppearanceStyle) {
        super.appearanceStyleDidChange(newAppearanceStyle)
        // Perform additional appearance setup here.
        
        // Configure the appearance.
        view.backgroundColor = SFColor.white
        secondaryButton.setTitleColor(SFColor.blue, for: .normal)
        bottomContainer.backgroundColor = SFColor.white
    }
    
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Stage Interaction
    
    open func stageWillUpdate() {
        // Unwrap the stage for this update method.
        guard let stage = stage else { return }
        
        // Enumerate the stage's cards.
        for card in stage.cards {
            // Determine the name of the card's type.
            let cardTypeName = card.associatedCardName
            
            // Register the appropriate cell's nib.
            let intermediate: UINib? = nil
            tableView.register(intermediate, forCellReuseIdentifier: cardTypeName)
        }
    }
    
    open func stageDidUpdate() {
        // Configure the controls & the label.
        stage.primaryControl?.prepare(primaryButton, withDefaultAction: .custom(target: self,
                                                                                method: .primaryButtonAction,
                                                                                controlEvents: .touchUpInside),
                                      for: self)
        stage.secondaryControl?.prepare(secondaryButton, withDefaultAction: .custom(target: self,
                                                                                    method: .secondaryButtonAction,
                                                                                    controlEvents: .touchUpInside),
                                        for: self)
        stage.leadingControl?.prepare(leadingButton, withDefaultAction: .custom(target: self,
                                                                                method: .leadingButtonAction,
                                                                                controlEvents: .touchUpInside),
                                      for: self)
        stage.trailingControl?.prepare(trailingButton, withDefaultAction: .custom(target: self,
                                                                                  method: .trailingButtonAction,
                                                                                  controlEvents: .touchUpInside),
                                       for: self)
        stage.accessoryLabel?.prepare(accessoryLabel)
        
        // Configure the visibility of buttons and labels.
        primaryButton.isHidden = stage.primaryControl == nil
        secondaryButton.isHidden = stage.secondaryControl == nil
        accessoryLabel.isHidden = stage.accessoryLabel == nil
        leadingButton.isHidden = stage.leadingControl == nil
        trailingButton.isHidden = stage.trailingControl == nil
        topContainer.isHidden = leadingButton.isHidden && trailingButton.isHidden
        bottomContainer.isHidden = primaryButton.isHidden && secondaryButton.isHidden && accessoryLabel.isHidden
        
        // Enumerate the stage's cards.
        for card in stage.cards {
            // Determine the name of the card's type.
            let cardTypeName = card.associatedCardName
            
            // Register the appropriate cell's nib.
            tableView.register(UINib(nibName: cardTypeName,
                                     bundle: Bundle(for: SFOnboardingStageViewController.self)),
                               forCellReuseIdentifier: cardTypeName)
        }
    }
    
    // MARK: - Actions
    
    @objc open func primaryButtonAction(_ sender: Any?) {
        onboardingController?.presentStage(after: stage)
    }
    
    @objc open func secondaryButtonAction(_ sender: Any?) {
        
    }
    
    @objc open func leadingButtonAction(_ sender: Any?) {
        onboardingController?.popViewController(animated: true)
    }
    
    @objc open func trailingButtonAction(_ sender: Any?) {
        onboardingController?.presentStage(after: stage)
    }
    
    // MARK: - Table View Data Source
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stage.cards.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Retrieve the card from the stage.
        let card = stage.cards[indexPath.row]
        
        // Dequeue the appropriate cell for the card.
        let cardCell = tableView.dequeueReusableCell(withIdentifier: card.associatedCardName, for: indexPath) as! SFTableViewCell
        
        // Request that the card prepare its cell.
        card.prepare(cardCell)
        
        return cardCell
    }
}
