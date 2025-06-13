//
//  View_toastView.swift
//  DemoProject
//
//  Created by Arun Kumar on 12/06/25.
//

import Foundation
import SwiftUI

extension View {

  func toastView(toast: Binding<Toast?>) -> some View {
    self.modifier(ToastModifier(toast: toast))
  }
}
