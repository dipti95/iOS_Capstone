//
//  FileManager.swift
//  ShoppingApp
//
//  Created by Dipti Yadav on 11/13/23.
//

import Foundation

public extension FileManager {
  static var documentsDirectoryURL: URL {
    `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
}
