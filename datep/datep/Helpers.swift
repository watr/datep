//
//  Helpers.swift
//  datep
//
//  Created by hashimoto wataru on 2018/06/20.
//  Copyright © 2018年 HASHIMOTO Wataru. All rights reserved.
//

import Foundation
import Cocoa

protocol Apply { }

extension Apply {
    func apply(closure:(Self) -> ()) -> Self {
        closure(self)
        return self
    }
}

extension NSObject: Apply { }

class AppDelegate: NSObject, NSApplicationDelegate {
    var datepicker: NSDatePicker!
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    @objc func ok() {
        let formatter = DateFormatter().apply {
            $0.locale = Locale(identifier: "en_US_POSIX")
            $0.dateFormat = "yyyy-MM-dd HH:mm:ss"
            $0.timeZone = TimeZone.current
        }
            
        let date = self.datepicker.dateValue
        print(formatter.string(from: date))
        NSApplication.shared.mainWindow?.close()
    }
}
