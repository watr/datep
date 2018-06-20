//
//  main.swift
//  datep
//
//  Created by hashimoto wataru on 2018/06/20.
//  Copyright © 2018年 HASHIMOTO Wataru. All rights reserved.
//

import Foundation
import Cocoa

let currentVersionDescription: String = "datep 0.0.1"
let title: String = UserDefaults.standard.string(forKey: "title") ?? "Date"

NSApplication.shared.setActivationPolicy(.accessory)
let delegate = AppDelegate()
NSApplication.shared.delegate = delegate

NSApplication.shared.activate(ignoringOtherApps: true)

let picker = NSDatePicker().apply {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.datePickerStyle = .textFieldAndStepper
    $0.datePickerMode = .single
    $0.datePickerElements = [.yearMonthDay, .hourMinuteSecond]
    $0.sizeToFit()
    
    $0.dateValue = Date()
}
delegate.datepicker = picker

let okButton = NSButton(title: "OK",
                        target: delegate,
                        action: #selector(AppDelegate.ok)).apply {
                            $0.translatesAutoresizingMaskIntoConstraints = false
                            $0.keyEquivalent = "\r"
                            $0.sizeToFit()
}

let window = NSWindow()
window.title = title

let contentView = window.contentView!
contentView.addSubview(picker)
contentView.addSubview(okButton)

let views: [String: Any] = [ "picker": picker, "okButton": okButton]
let constraints: [NSLayoutConstraint] = (
    NSLayoutConstraint.constraints(withVisualFormat: "V:[okButton]-|",
                                   metrics: nil,
                                   views: views) +
        NSLayoutConstraint.constraints(withVisualFormat: "H:[okButton]-|",
                                       metrics: nil,
                                       views: views) +
        NSLayoutConstraint.constraints(withVisualFormat: "V:|-[picker]-[okButton]",
                                       metrics: nil,
                                       views: views) +
        NSLayoutConstraint.constraints(withVisualFormat: "H:|-[picker]-|",
                                       metrics: nil,
                                       views: views)
)
contentView.addConstraints(constraints)
window.makeKeyAndOrderFront(nil)

NSApplication.shared.run()
