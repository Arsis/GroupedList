//
//  Notification.swift
//  View
//
//  Created by Dmitry Fedorov on 9/8/18.
//  Copyright © 2018 Lab. All rights reserved.
//

import UIKit

//struct NotificationDescriptor<A> {
//    let name: Notification.Name
//    let convert: (Notification)->A
//}
//
//class NotificationToken {
//    let token: NSObjectProtocol
//    let notificationCenter: NotificationCenter
//    
//    init(token: NSObjectProtocol, notificationCenter: NotificationCenter) {
//        self.token = token
//        self.notificationCenter = notificationCenter
//    }
//    
//    deinit {
//        notificationCenter.removeObserver(token)
//    }
//}
//
//struct KeyboardStateChangePayload {
//    let height: CGFloat
//    let animationCurve: UIView.AnimationOptions
//    let duration: TimeInterval
//}
//
//extension KeyboardStateChangePayload {
//    init(notification: Notification) {
//        height = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGFloat
//        animationCurve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UIView.AnimationOptions
//        duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
//    }
//}
//
//extension NotificationCenter {
//    func addObserver<A>(forDescriptor descriptor: NotificationDescriptor<A>, using block: @escaping (A) -> ()) -> NotificationToken {
//        return NotificationToken(token: addObserver(forName: descriptor.name, object: nil, queue: nil, using: { note in
//            block(descriptor.convert(note))
//        }), notificationCenter: self)
//    }
//}

