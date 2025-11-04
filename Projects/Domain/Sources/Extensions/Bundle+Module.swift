//
//  Bundle+Module.swift
//
//  Copyright © 2025 JS. All rights reserved.
//

import Foundation

extension Foundation.Bundle {
  private class ModuleBundle {
  }

  static let module = Bundle(for: ModuleBundle.self)
}
