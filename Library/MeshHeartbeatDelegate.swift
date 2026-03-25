//
//  File.swift
//  NordicMesh
//
//  Created by LE BRIS Loris on 25/03/2026.
//

import Foundation

/// Public representation of a received Bluetooth Mesh Heartbeat.
public struct MeshHeartbeat {
    public let source: Address
    public let destination: Address
    public let initialTtl: UInt8
    public let receivedTtl: UInt8?
    public let hops: UInt8
    public let featuresRaw: UInt16
    public let ivIndex: UInt32
    public let timestamp: Date
}

public protocol MeshHeartbeatDelegate: AnyObject {
    func meshNetworkManager(
        _ manager: MeshNetworkManager,
        didReceiveHeartbeat heartbeat: MeshHeartbeat
    )
}

extension MeshHeartbeatDelegate {
    public func meshNetworkManager(
        _ manager: MeshNetworkManager,
        didReceiveHeartbeat heartbeat: MeshHeartbeat
    ) {
        // Default no-op.
    }
}
