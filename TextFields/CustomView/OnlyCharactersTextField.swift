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

    @IBAction func editingDidEnd(_ sender: UITextField) {
        textField.layer.borderWidth = 0.0
    }

    @IBAction func editingDidBegin(_ sender: UITextField) {
        textField.layer.borderWidth = 1.0
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string:  String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = formattedStringAndDigits(str: newString)
        return false
    }

    private func formattedStringAndDigits(str: String) -> String {
        if str.count >= inputFieldMask.count {
            return String(str.prefix(inputFieldMask.count))
        }
        let charArray = Array(str)
        let maskArray = Array(inputFieldMask)
        var result = ""
        var counter = 0

        for char in charArray {
            if maskArray[counter] == "w" && char.isLetter {
                result.append(char)
            } else if maskArray[counter] == "d" && char.isNumber {
                result.append(char)
            }
            else if maskArray[counter] == "-" {
                result.append(maskArray[counter])
            }
            counter += 1
        }
        return result
    }

    private func formattedString(str: String) -> String {
        // This works for phone numbers
        let cleanPhoneNumber = str.components(separatedBy: CharacterSet.letters.inverted).joined()

        let mask = "##-###-###"
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "#" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}
