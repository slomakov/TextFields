//
//  OnlyCharactersTextField.swift
//  TextFields
//
//  Created by Stanislav Lomakov on 31.05.2023.
//

import UIKit

class OnlyCharactersTextField: UIView, UITextFieldDelegate {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textField: UITextField!

    var characterSet = CharacterSet()
    let inputFieldMask = "wwwww-ddddd"
    private lazy var inputFieldMaskCharacters = Array(inputFieldMask)

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
        textField.placeholder = inputFieldMask
    }

    @IBAction func editingDidEnd(_ sender: UITextField) {
        textField.layer.borderWidth = 0.0
    }

    @IBAction func editingDidBegin(_ sender: UITextField) {
        textField.layer.borderWidth = 1.0
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string:  String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = formattedStringAndDigits(str: newString, isDeleting: string.isEmpty)
        DispatchQueue.main.async {
            textField.placeCursorAtEnd()
        }
        return false
    }

    private func formattedStringAndDigits(str: String, isDeleting: Bool) -> String {
        let charArray = Array(str)
        var result = ""
        var textCounter = 0
        var maskCounter = 0

        while textCounter < charArray.count && maskCounter < inputFieldMaskCharacters.count {
            switch inputFieldMaskCharacters[maskCounter] {
            case "w":
                if charArray[textCounter].isLetter {
                    result.append(charArray[textCounter])
                    maskCounter += 1
                }
            case "d":
                if charArray[textCounter].isNumber {
                    result.append(charArray[textCounter])
                    maskCounter += 1
                }
            case "-":
                result.append("-")
                maskCounter += 1
            default:
                assertionFailure("Implement if needed")
                maskCounter += 1
            }
            textCounter += 1
        }
        if textCounter < inputFieldMaskCharacters.count && inputFieldMaskCharacters[result.count] == "-" && !isDeleting {
            result.append("-")
        }
        if isDeleting && inputFieldMaskCharacters[result.count] == "-" {
            result = String(result.dropLast())
        }

        return result
    }
}

extension UITextField {

    func placeCursorAtEnd() {
        selectedTextRange = textRange(from: endOfDocument, to: endOfDocument)
    }
}
