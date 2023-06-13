//
//  Link.swift
//  TextFields
//
//  Created by Stanislav Lomakov on 31.05.2023.
//

import UIKit


class Link: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textField: UITextField!

    var delegate: LinkFieldSelectedDelegate?
    let allowedCharacters = CharacterSet.decimalDigits.inverted
    var characterSet = CharacterSet()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        textField.layer.borderColor = ColorHelper.hexStringToUIColor(hex: "#007AFF").cgColor
        textField.layer.cornerRadius = 12.0
    }

    @IBAction func editingDidEnd(_ sender: UITextField) {
        textField.layer.borderWidth = 0.0
    }

    @IBAction func editingDidBegin(_ sender: UITextField) {
        textField.layer.borderWidth = 1.0
    }

    @IBAction func editingDidChange(_ sender: UITextField) {
        let stringUrl = sender.text!
        textField.text = (stringUrl.count > 1 && stringUrl.starts(with: "https://")) ? sender.text! : ""
        delegate?.didPasteLink(urlString: textField.text!)
    }
}

protocol LinkFieldSelectedDelegate {
    func didPasteLink(urlString: String)
}
