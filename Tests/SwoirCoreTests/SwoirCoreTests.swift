import XCTest
@testable import SwoirCore

final class SwoirCoreTests: XCTestCase {

    class MockSwoirBackend: SwoirBackendProtocol {
        static func setup_srs(circuit_size: UInt32, srs_path: String? = nil) throws -> UInt32 {
            if circuit_size == 0 { throw SwoirBackendError.nonPositiveCircuitSize }
            return 0
        }

        static func setup_srs_from_bytecode(bytecode: Data, srs_path: String? = nil) throws -> UInt32 {
            if bytecode.isEmpty { throw SwoirBackendError.emptyBytecode }
            return 0
        }

        static func prove(bytecode: Data, witnessMap: [String], proof_type: String, vkey: Data, low_memory_mode: Bool? = false) throws -> Data {
            if bytecode.isEmpty { throw SwoirBackendError.emptyBytecode }
            if witnessMap.isEmpty { throw SwoirBackendError.emptyWitnessMap }
            if proof_type.isEmpty { throw SwoirBackendError.emptyProofType }
            return Data("foo".utf8)
        }
        static func verify(proof: Data, vkey: Data, proof_type: String) throws -> Bool {
            if proof.isEmpty { throw SwoirBackendError.emptyProofData }
            if vkey.isEmpty { throw SwoirBackendError.emptyVerificationKey }
            if proof_type.isEmpty { throw SwoirBackendError.emptyProofType }
            return true
        }

        static func execute(bytecode: Data, witnessMap: [String]) throws -> [String] {
            if bytecode.isEmpty { throw SwoirBackendError.emptyBytecode }
            if witnessMap.isEmpty { throw SwoirBackendError.emptyWitnessMap }
            return witnessMap
        }

        static func get_verification_key(bytecode: Data, proof_type: String, low_memory_mode: Bool? = false) throws -> Data {
            if bytecode.isEmpty { throw SwoirBackendError.emptyBytecode }
            return Data("bar".utf8)
        }
    }

    func testErrorCases() throws {
        let bytecode = Data([0x01])
        let witnessMap = ["1", "2"]
        let emptyBytecode = Data()
        let emptyWitnessMap = [String]()
        let emptyProof = Data()
        let emptyVKey = Data()
        let nonEmptyProof = Data("foo".utf8)
        let nonEmptyVKey = Data("bar".utf8)

        XCTAssertThrowsError(try MockSwoirBackend.prove(bytecode: emptyBytecode, witnessMap: witnessMap, proof_type: "honk", vkey: nonEmptyVKey, low_memory_mode: false)) { error in
            XCTAssertEqual(error as? SwoirBackendError, .emptyBytecode)
        }
        XCTAssertThrowsError(try MockSwoirBackend.prove(bytecode: bytecode, witnessMap: emptyWitnessMap, proof_type: "honk", vkey: nonEmptyVKey, low_memory_mode: false)) { error in
            XCTAssertEqual(error as? SwoirBackendError, .emptyWitnessMap)
        }
        XCTAssertThrowsError(try MockSwoirBackend.verify(proof: emptyProof, vkey: nonEmptyVKey, proof_type: "honk")) { error in
            XCTAssertEqual(error as? SwoirBackendError, .emptyProofData)
        }
        XCTAssertThrowsError(try MockSwoirBackend.verify(proof: nonEmptyProof, vkey: emptyVKey, proof_type: "honk")) { error in
            XCTAssertEqual(error as? SwoirBackendError, .emptyVerificationKey)
        }
        XCTAssertThrowsError(try MockSwoirBackend.prove(bytecode: bytecode, witnessMap: witnessMap, proof_type: "", vkey: nonEmptyVKey, low_memory_mode: false)) { error in
            XCTAssertEqual(error as? SwoirBackendError, .emptyProofType)
        }
        XCTAssertThrowsError(try MockSwoirBackend.execute(bytecode: emptyBytecode, witnessMap: witnessMap)) { error in
            XCTAssertEqual(error as? SwoirBackendError, .emptyBytecode)
        }
        XCTAssertThrowsError(try MockSwoirBackend.execute(bytecode: bytecode, witnessMap: emptyWitnessMap)) { error in
            XCTAssertEqual(error as? SwoirBackendError, .emptyWitnessMap)
        }
        XCTAssertThrowsError(try MockSwoirBackend.setup_srs(circuit_size: 0)) { error in
            XCTAssertEqual(error as? SwoirBackendError, .nonPositiveCircuitSize)
        }
        XCTAssertThrowsError(try MockSwoirBackend.setup_srs_from_bytecode(bytecode: emptyBytecode)) { error in
            XCTAssertEqual(error as? SwoirBackendError, .emptyBytecode)
        }
        XCTAssertThrowsError(try MockSwoirBackend.get_verification_key(bytecode: emptyBytecode, proof_type: "honk", low_memory_mode: false)) { error in
            XCTAssertEqual(error as? SwoirBackendError, .emptyBytecode)
        }
    }
}
