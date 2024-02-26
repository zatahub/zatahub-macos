//
//  MockFileManager.swift
//  ZataHubTests
//
//  Created by Macbook on 09/02/2024.
//

import Foundation
import ZIPFoundation

final class MockFileManager: FileManager {
    var existedPaths: [String] = []
    var contentsInDirectory: [String] = []
    var removeItemIsCalled = false
    var zipItemIsCalled = false
    var createDirectoryIsCalled = false
    var createDirectoryAt: URL?
    var createDirectoryWithIntermediateDirectories: Bool?
    var copyItemAt: [URL] = []
    var copyItemTo: [URL] = []
    var contentData: [String: Data] = [:]

    override func fileExists(atPath path: String) -> Bool {
        return existedPaths.contains(path)
    }

    override func removeItem(at URL: URL) throws {
        removeItemIsCalled = true
    }

    override func subpathsOfDirectory(atPath path: String) throws -> [String] {
        zipItemIsCalled = true
        return try super.subpathsOfDirectory(atPath: path)
    }

    override func contentsOfDirectory(atPath path: String) throws -> [String] {
        return contentsInDirectory
    }

    override func createDirectory(at url: URL, withIntermediateDirectories createIntermediates: Bool, attributes: [FileAttributeKey : Any]? = nil) throws {
        createDirectoryIsCalled = true
        createDirectoryAt = url
        createDirectoryWithIntermediateDirectories = createIntermediates
    }

    override func copyItem(at srcURL: URL, to dstURL: URL) throws {
        copyItemAt.append(srcURL)
        copyItemTo.append(dstURL)
    }

    override func contents(atPath path: String) -> Data? {
        return contentData[path]
    }
}
