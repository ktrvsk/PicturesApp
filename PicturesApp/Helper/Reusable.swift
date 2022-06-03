//
//  Reusable.swift
//  PicturesApp
//
//  Created by Ksusha on 02.06.2022.
//

import UIKit

public protocol Reusable: AnyObject {
  static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
      }
}
