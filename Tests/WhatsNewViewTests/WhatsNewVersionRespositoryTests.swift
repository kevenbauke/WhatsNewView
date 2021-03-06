import XCTest
@testable import WhatsNewView

final class WhatsNewVersionRespositoryTests: XCTestCase {

	override class func setUp() {
		WhatsNewVersionRepository.lastKnownVersion = nil
	}

	override class func tearDown() {
		WhatsNewVersionRepository.lastKnownVersion = nil
	}

	func testLastKnownVersion() {
		WhatsNewVersionRepository.lastKnownVersion = "1.2.3"
		XCTAssertEqual("1.2.3", WhatsNewVersionRepository.lastKnownVersion)
	}

	func testSetCurrentVersion() {
		WhatsNewVersionRepository.setCurrentVersion()
		XCTAssertEqual(WhatsNewVersionRepository.bundleVersion, WhatsNewVersionRepository.lastKnownVersion)
	}

	func testIsInitialStart() {
		XCTAssertTrue(WhatsNewVersionRepository.isInitialStart)
		WhatsNewVersionRepository.lastKnownVersion = "1.0"
		XCTAssertFalse(WhatsNewVersionRepository.isInitialStart)
	}

	func testIsNewVersion() {
		WhatsNewVersionRepository.lastKnownVersion = "1.0"
		XCTAssertTrue(WhatsNewVersionRepository.isNewVersion)

		WhatsNewVersionRepository.lastKnownVersion = nil
		XCTAssertTrue(WhatsNewVersionRepository.isNewVersion)
	}
}
