//
//  BaseView.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/3/20.
//

import UIKit

class BaseView: UIView {
    // MARK: - Variables
    private var contentView: UIView!
    
    // MARK: - Life Cycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        
    }
    
    private func loadFromXIB() {
        let name = String(describing: classForCoder)
        let view = Bundle(for: classForCoder).loadNibNamed(name, owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        addSubview(view)
        contentView = view
    }
}
