//
//  SFOnboardingStageViewController.swift
//  SFKit
//
//  Created by David Moore on 1/29/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

final internal class SFOnboardingStageViewController: SFViewController, UITableViewDataSource {
    
    // MARK: - Properties
    
    /// Stage associated with this specific view controller.
    var stage: SFOnboardingStage! {
        willSet {
            stageWillUpdate()
        } didSet {
            stageDidUpdate()
        }
    }
    
    /// Primary button title that will be presented to users.
    @IBOutlet var primaryButton: SFButton!
    
    /// Secondary button title that will be presented to users.
    ///
    /// - Note: When set to `nil` the secondary button is hidden.
    @IBOutlet var secondaryButton: UIButton!
    
    /// Leading button title that will be presented to users.
    ///
    /// - Note: When set to `nil` the leading button is hidden.
    @IBOutlet var leadingButton: SFButton!
    
    /// Trailing button title that will be presented to users.
    ///
    /// - Note: When set to `nil` the trailing button is hidden.
    @IBOutlet var trailingButton: SFButton!
    
    /// Contains the `leadingButton` and the `trailingButton`.
    ///
    /// - Note: When the leading & trailing buttons are both hidden, this view is also hidden.
    @IBOutlet var topContainer: UIView!
    
    /// Contains the `primaryButton` and the `secondaryButton`.
    ///
    /// - Note: When the primary & secondary buttons are both hidden, this view is also hidden.
    @IBOutlet var bottomContainer: UIView!
    
    /// Displays the cards.
    @IBOutlet var tableView: SFTableView!
    
    /// Retained transition controller.
    private let transitionController = SFOnboardingTransitionController(withPresentingAnimator: SFOnboardingPushAnimator(),
                                                              dismissingAnimator: SFOnboardingPushAnimator(isDismissing: true))
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
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
    
    override func appearanceStyleDidChange(_ newAppearanceStyle: SFAppearanceStyle) {
        super.appearanceStyleDidChange(newAppearanceStyle)
        // Perform additional appearance setup here.
        
        // Configure the appearance.
        view.backgroundColor = SFColor.white
        secondaryButton.setTitleColor(SFColor.blue, for: .normal)
        bottomContainer.backgroundColor = SFColor.white
    }
    
    func stageWillUpdate() {
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
    
    func stageDidUpdate() {
        // Configure the buttons and labels.
        primaryButton.setTitle(stage.primaryButtonLocalizedTitle, for: .normal)
        secondaryButton.setTitle(stage.secondaryButtonLocalizedTitle, for: .normal)
        leadingButton.setTitle(stage.leadingButtonLocalizedTitle, for: .normal)
        trailingButton.setTitle(stage.trailingButtonLocalizedTitle, for: .normal)
        
        // Configure the visibility of buttons and labels.
        primaryButton.isHidden = stage.primaryButtonLocalizedTitle.isEmpty
        secondaryButton.isHidden = stage.secondaryButtonLocalizedTitle == nil
        leadingButton.isHidden = stage.leadingButtonLocalizedTitle == nil
        trailingButton.isHidden = stage.trailingButtonLocalizedTitle == nil
        topContainer.isHidden = leadingButton.isHidden && trailingButton.isHidden
        bottomContainer.isHidden = primaryButton.isHidden && secondaryButton.isHidden
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Interface
    
    @IBAction func primaryButtonDidTouchUpInside(_ sender: SFButton) {
        let onboardingController = parent as? SFOnboardingController
        onboardingController?.presentStage(succeeding: stage, sender: self)
    }
    
    // MARK: - Table View Data Source
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stage.cards.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Retrieve the card from the stage.
        let card = stage.cards[indexPath.row]
        
        // Dequeue the appropriate cell for the card.
        let cardCell = tableView.dequeueReusableCell(withIdentifier: card.associatedCardName, for: indexPath) as! SFTableViewCell
        
        // Request that the card prepare its cell.
        card.prepare(cardCell)
        
        return cardCell
    }
}
