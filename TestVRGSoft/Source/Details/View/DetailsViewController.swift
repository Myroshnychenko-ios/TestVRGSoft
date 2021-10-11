//
//  DetailsViewController.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 11.10.2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - Variables
    
    var presenter: DetailsViewPresenterProtocol!
    var film: Film!
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var criticsPickLabel: UILabel!
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var summaryShortLabel: UILabel!
    @IBOutlet weak var srcImageView: UIImageView!
    @IBOutlet weak var displayTitleLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var openingDateLabel: UILabel!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.startSetup()
        configureDetailsView()
    }
    
}
