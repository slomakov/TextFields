//
//  CustomTextField.swift
//  TextFields
//
//  Created by Stanislav Lomakov on 22.05.2023.
//

import UIKit

class CustomTextField: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textField: UITextField!

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
        Bundle.main.loadNibNamed("CustomTextField", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

//        let view = Bundle.main.loadNibNamed("CustomTextField", owner: self, options: nil)![0] as! UIView
//        addSubview(view)
//        view.frame = self.bounds
//        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
