//
//  Toast.swift
//  DemoProject
//
//  Created by Arun Kumar on 12/06/25.
//

import Foundation

struct Toast: Equatable {
  var type: ToastStyle
  var title: String
  var message: String
  var duration: Double = 3
}
