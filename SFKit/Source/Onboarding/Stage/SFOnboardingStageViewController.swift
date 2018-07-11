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

open class SFOnboardingStageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    @IBOutlet open var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Configure custom modal presentation.
        modalPresentationStyle = .custom
        transitioningDelegate = transitionController
        
        // Hide the seperator for all empty table view cells.
        tableView?.tableFooterView = UIView(frame: .zero)
        
        // Configure the table view's data source & delegate.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    open override func appearanceStyleDidChange(_ previousAppearanceStyle: SFAppearanceStyle) {
        super.appearanceStyleDidChange(previousAppearanceStyle)
        // Perform additional appearance setup here.
        
        // Configure the appearance.
        let colorMetrics = UIColorMetrics(forAppearance: appearance)
        view.backgroundColor = colorMetrics.color(forRelativeHue: .white)
        secondaryButton.setTitleColor(colorMetrics.color(forRelativeHue: .blue), for: .normal)
        bottomContainer.backgroundColor = colorMetrics.color(forRelativeHue: .white)
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
            // Register the appropriate cell's nib.
            let intermediate: UINib? = nil
            tableView.register(intermediate, forCellReuseIdentifier: card.reuseIdentifier)
        }
    }
    
    open func stageDidUpdate() {
        // Configure the controls & the label.
        stage!.primaryControl?.prepare(primaryButton,
                                      withDefaultAction: .custom(target: self, method: .primaryButtonAction,
                                                                 controlEvents: .touchUpInside), for: self)
        stage!.secondaryControl?.prepare(secondaryButton,
                                        withDefaultAction: .custom(target: self, method: .secondaryButtonAction,
                                                                   controlEvents: .touchUpInside), for: self)
        stage!.leadingControl?.prepare(leadingButton,
                                      withDefaultAction: .custom(target: self, method: .leadingButtonAction,
                                                                 controlEvents: .touchUpInside), for: self)
        stage!.trailingControl?.prepare(trailingButton,
                                       withDefaultAction: .custom(target: self, method: .trailingButtonAction,
                                                                  controlEvents: .touchUpInside), for: self)
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
            // Register the appropriate cell's nib.
            tableView.register(UINib(nibName: card.nibName,
                                     bundle: Bundle(for: type(of: card))),
                               forCellReuseIdentifier: card.reuseIdentifier)
        }
    }
    
    // MARK: - Actions
    
    @objc open func primaryButtonAction(_ sender: Any?) {
        onboardingController?.presentStage(after: stage, animated: true)
    }
    
    @objc open func secondaryButtonAction(_ sender: Any?) {
        
    }
    
    @objc open func leadingButtonAction(_ sender: Any?) {
        onboardingController?.popViewController(animated: true)
    }
    
    @objc open func trailingButtonAction(_ sender: Any?) {
        onboardingController?.presentStage(after: stage, animated: true)
    }
    
    // MARK: - Table View Cell Access
    
    /// Retrieves a cell associated with a given `card`. The behaviour of this method is undefined when `tableView`'s cell contents have been modified externally.
    ///
    /// - Parameter card: The onboarding card that will be matched to a given cell.
    /// - Returns: Cell that was prepared and associated with an onboarding card.
    open func cell(for card: SFOnboardingCard) -> UITableViewCell? {
        if let index = stage.cards.index(of: card) {
            return tableView.cellForRow(at: IndexPath(row: index, section: 0))
        } else {
            return nil
        }
    }
    
    // MARK: - Table View Data Source
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stage.cards.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Retrieve the card from the stage.
        let card = stage.cards[indexPath.row]
        
        // Dequeue the appropriate cell for the card.
        let cardCell = tableView.dequeueReusableCell(withIdentifier: card.reuseIdentifier, for: indexPath)
        
        // Request that the card prepare its cell.
        card.prepare(cardCell, forController: self)
        
        return cardCell
    }
    
    // MARK: - Table View Delegate
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellSelected = stage.cellSelected else { return }
        
        // Retrieve the selected cell.
        let cell = tableView.cellForRow(at: indexPath)!
        
        // Create a control to call the action.
        let control = SFOnboardingControl(localizedTitle: "", actions: [])
        control.controller = self
        control.callAction(cellSelected, sender: cell)
    }
}
