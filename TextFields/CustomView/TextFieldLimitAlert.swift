//
//  TextFieldLimitAlert.swift
//  TextFields
//
//  Created by Stanislav Lomakov on 27.05.2023.
//

import UIKit

class TextFieldLimitAlert: UIView, UITextFieldDelegate {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var upperLimitIndicator: UILabel!
    @IBOutlet weak var lowerLimitIndicator: UILabel!

    let maxInputLength = 10
    let textFieldFocusedColor = ColorHelper.hexStringToUIColor(hex: "#007AFF").cgColor

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
        textField.layer.borderColor = textFieldFocusedColor
        textField.delegate = self
        textField.layer.cornerRadius = 12.0
    }

    
    @IBAction func inputDidChange(_ sender: UITextField) {
        let inputTextLength = textField.text!.count
        lowerLimitIndicator.text = String(maxInputLength - inputTextLength)
        upperLimitIndicator.text = "\(inputTextLength)/\(maxInputLength)"
        checkLimitExceed(inputTextLength)
    }

    @IBAction func editingBegin(_ sender: UITextField) {
        textField.layer.borderWidth = 1.0
    }
    
    @IBAction func editingEnd(_ sender: UITextField) {
        if sender.text!.count <= maxInputLength {
            textField.layer.borderWidth = 0.0
        }
    }
    
    private func checkLimitExceed(_ inputTextLength: Int) {
        if inputTextLength > maxInputLength {
            lowerLimitIndicator.textColor = .red
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = UIColor.red.cgColor
            paintExceedLimitText()
        } else {
            lowerLimitIndicator.textColor = .black
            textField.layer.borderColor = textFieldFocusedColor
        }
    }

    private func paintExceedLimitText() {
        let text = textField.text!
        let mutableAttributedString = NSMutableAttributedString.init(string: text)

        let textRange = NSRange(text.startIndex..<text.endIndex, in: text)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: textRange)
        let exceedLimitSizeRange = NSRange(text.index(text.startIndex, offsetBy: maxInputLength)..., in: text)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: exceedLimitSizeRange)

        textField.attributedText = mutableAttributedString
    }
}
