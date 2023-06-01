//
//  CustomTextField.swift
//  TextFields
//
//  Created by Stanislav Lomakov on 22.05.2023.
//

import UIKit

class NoDigitsTextField: UIView, UITextFieldDelegate {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textField: UITextField!

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
        textField.delegate = self
        textField.layer.cornerRadius = 12.0
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }

    @IBAction func editingDidEnd(_ sender: UITextField) {
        textField.layer.borderWidth = 0.0
    }

    @IBAction func editingDidBegin(_ sender: UITextField) {
        textField.layer.borderWidth = 1.0
    }
}
