import Foundation

public enum SwoirBackendError: Error, Equatable {
    case errorProving(String)
    case errorVerifying(String)
    case errorExecuting(String)
    case networkError(String)
    case memoryLimitExceeded
    case invalidBytecode
    case emptyBytecode
    case emptyWitnessMap
    case emptyProofData
    case emptyVerificationKey
    case emptyProofType
    case errorSettingUpSRS
    case nonPositiveCircuitSize
    case errorGettingVerificationKey
}

public protocol SwoirBackendProtocol {
    static func setup_srs(circuit_size: UInt32, srs_path: String?) throws -> UInt32
    static func setup_srs_from_bytecode(bytecode: Data, srs_path: String?) throws -> UInt32
    static func prove(bytecode: Data, witnessMap: [String], proof_type: String, vkey: Data, low_memory_mode: Bool?) throws -> Data
    static func verify(proof: Data, vkey: Data, proof_type: String) throws -> Bool
    static func execute(bytecode: Data, witnessMap: [String]) throws -> [String]
    static func get_verification_key(bytecode: Data, proof_type: String, low_memory_mode: Bool?) throws -> Data
}
