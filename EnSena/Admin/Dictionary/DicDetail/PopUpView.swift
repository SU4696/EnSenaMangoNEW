//
//  PopUpView.swift
//  EnSena
//
//  Created by 조수연 on 2022/11/19.
//

import UIKit
import SwiftUI
import FirebaseStorage
import FirebaseFirestore

class PopUpView: UIView {

    @IBOutlet weak var close: UIButton!
    
    @IBOutlet weak var wordLabel: UILabel! 
    
    @IBOutlet weak var urlLabel: UILabel!
    
    
    @IBOutlet weak var wordImage: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        XibSetup(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
    }
    
    func XibSetup(frame: CGRect) {
        let view = loadXib()
        view.frame = frame
        addSubview(view)
    }
    
    func loadXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PopUp", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view!
    }
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
