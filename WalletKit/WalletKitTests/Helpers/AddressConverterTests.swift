import XCTest
import Cuckoo
import RealmSwift
@testable import WalletKit

class AddressConverterTests: XCTestCase {
    private var addressConverter: AddressConverter!

    override func setUp() {
        super.setUp()

        let mockWalletKit = MockWalletKit()

        addressConverter = AddressConverter(network: mockWalletKit.mockNetwork)
    }

    override func tearDown() {
        addressConverter = nil

        super.tearDown()
    }

    func testValidAddressConvert() {
        let address = "msGCb97sW9s9Mt7gN5m7TGmwLqhqGaFqYz"
        let keyHash = "80d733d7a4c02aba01da9370afc954c73a32dba5"
        do {
            let convertedData = try addressConverter.convert(address: address)
            XCTAssertEqual(convertedData, Data(hex: keyHash))
        } catch {
            XCTFail("Error Handled!")
        }
    }

    func testValidPubKeyConvert() {
        let address = "msGCb97sW9s9Mt7gN5m7TGmwLqhqGaFqYz"
        let keyHash = "80d733d7a4c02aba01da9370afc954c73a32dba5"
        do {
            let convertedAddress = try addressConverter.convert(keyHash: Data(hex: keyHash)!, type: .p2pkh)
            XCTAssertEqual(convertedAddress, address)
        } catch {
            XCTFail("Error Handled!")
        }
    }

    func testValidSHAddressConvert() {
        let address = "2NCRTejQCRReGuV4XpttwsMAxQTNRaYzrr1"
        let keyHash = "D259F4688599C8422F477166A0C89344AD9EE72F"
        do {
            let convertedData = try addressConverter.convert(address: address)
            XCTAssertEqual(convertedData, Data(hex: keyHash))
        } catch {
            XCTFail("Error Handled!")
        }
    }

    func testValidSHKeyConvert() {
        let address = "2NCRTejQCRReGuV4XpttwsMAxQTNRaYzrr1"
        let keyHash = "D259F4688599C8422F477166A0C89344AD9EE72F"
        do {
            let convertedAddress = try addressConverter.convert(keyHash: Data(hex: keyHash)!, type: .p2sh)
            XCTAssertEqual(convertedAddress, address)
        } catch {
            XCTFail("Error Handled!")
        }
    }

    func testAddressTooShort() {
        let address = "2NCRTejQCRReGuV4XpttwsMAxQTNRaYzrr12NCRTejQCRReGuV4XpttwsMAxQTNRaYzrr1"

        var caught = false
        do {
            let _ = try addressConverter.convert(address: address)
        } catch let error as ConversionError {
            caught = true
            XCTAssertEqual(error, ConversionError.invalidAddressLength)
        } catch {
            XCTFail("Invalid Error thrown!")
        }
        XCTAssertEqual(caught, true)
    }

    func testAddressTooLong() {
        let address = "2NCRTejQC"

        do {
            let _ = try addressConverter.convert(address: address)
            XCTFail("No error thrown!")
        } catch let error as ConversionError {
            XCTAssertEqual(error, ConversionError.invalidAddressLength)
        } catch {
            XCTFail("Invalid Error thrown!")
        }
    }

    func testInvalidChecksum() {
        let address = "msGCb97sW9s9Mt7gN5m7TGmwLqhqGaFqYzz"

        do {
            let _ = try addressConverter.convert(address: address)
            XCTFail("No error thrown!")
        } catch let error as ConversionError {
            XCTAssertEqual(error, ConversionError.invalidChecksum)
        } catch {
            XCTFail("Invalid Error thrown!")
        }
    }

    func testUnknownAddressType() {
        let keyHash = "80d733d7a4c02aba01da9370afc954c73a32dba5"

        do {
            let _ = try addressConverter.convert(keyHash: Data(hex: keyHash)!, type: .unknown)
            XCTFail("No error thrown!")
        } catch let error as ConversionError {
            XCTAssertEqual(error, ConversionError.unknownAddressType)
        } catch {
            XCTFail("Invalid Error thrown!")
        }
    }

}