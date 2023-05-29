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
        textField.delegate = self
        textField.layer.cornerRadius = 12.0
    }

    private func commonInit() {
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        textField.layer.borderColor = textFieldFocusedColor
    }

    
    @IBAction func inputDidChange(_ sender: UITextField) {
        let inputTextLength = textField.text!.count
        let limitCounter = maxInputLength - inputTextLength
        lowerLimitIndicator.text = String(limitCounter)
        upperLimitIndicator.text = "\(inputTextLength)/10"
        checkLimitExceed(limitCounter)
    }

    @IBAction func editingBegin(_ sender: UITextField) {
        textField.layer.borderWidth = 1.0
    }
    
    @IBAction func editingEnd(_ sender: UITextField) {
        if sender.text!.count <= maxInputLength {
            textField.layer.borderWidth = 0.0
        }
    }
    
    private func checkLimitExceed(_ limitCounter: Int) {
        if limitCounter < 0 {
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
        let allowedSizeString = String(text.prefix(maxInputLength))
        let exceedLimitSizeString = String(text.suffix(text.count - maxInputLength))

        let mutableAttributedStringStart = NSMutableAttributedString.init(string: allowedSizeString)
        let mutableAttributedStringEnd = NSMutableAttributedString.init(string: exceedLimitSizeString)

        let range = NSRange(exceedLimitSizeString.startIndex..<exceedLimitSizeString.endIndex, in: exceedLimitSizeString)

        mutableAttributedStringEnd.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range)

        mutableAttributedStringStart.append(mutableAttributedStringEnd)
        textField.attributedText = mutableAttributedStringStart
    }
}
