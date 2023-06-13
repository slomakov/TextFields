//
//  ViewController.swift
//  TextFields
//
//  Created by Stanislav Lomakov on 09.05.2023.
//

import SafariServices
import UIKit

class ViewController: UIViewController, LinkFieldSelectedDelegate {

    @IBOutlet weak var linkTextField: Link!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        linkTextField.delegate = self
    }

    func didPasteLink(urlString: String) {
        if urlString.starts(with: "https://") {
            present(SFSafariViewController(url: URL(string: urlString)!), animated: true)
        }
    }
}
