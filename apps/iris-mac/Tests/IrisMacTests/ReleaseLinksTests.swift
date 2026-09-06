import Foundation
@testable import IrisMac
import XCTest

@MainActor
final class ReleaseLinksTests: XCTestCase {
    func testUpdateLinksUseTransferredRepository() {
        XCTAssertEqual(
            IrisAppState.releaseAPIURL.absoluteString,
            "https://api.github.com/repos/advaitpaliwal/iris/releases/latest"
        )
        XCTAssertEqual(
            IrisAppState.releaseDownloadsURL.absoluteString,
            "https://github.com/advaitpaliwal/iris/releases/latest"
        )
    }

    func testSiteKeepsItsPinnedReleaseUnderNewOwner() throws {
        let macRoot = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
        let site = try String(
            contentsOf: macRoot.appendingPathComponent("../iris-site/src/pages/index.astro"),
            encoding: .utf8
        )
        XCTAssertTrue(site.contains(
            "https://github.com/advaitpaliwal/iris/releases/download/iris-macos-v0.1.0-20260531/Iris-macOS-arm64.zip"
        ))
        XCTAssertTrue(site.contains("const repoUrl = \"https://github.com/advaitpaliwal/iris\";"))
        XCTAssertFalse(site.contains("companion-inc/iris"))
    }
}
