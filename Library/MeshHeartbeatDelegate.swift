/*
 * Copyright (c) 2026, Nordic Semiconductor
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice, this
 *    list of conditions and the following disclaimer in the documentation and/or
 *    other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its contributors may
 *    be used to endorse or promote products derived from this software without
 *    specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

//  Created by LE BRIS Loris on 25/03/2026.

import Foundation

/// Public representation of a received Bluetooth Mesh Heartbeat.
public struct MeshHeartbeat {
    /// The Unicast Address of the originating Node.
    ///
    /// The `source` is given as an Address, instead of an Node, because
    /// the message may be sent by an unknown Node.
    public let source: Address
    /// The destination Address.
    ///
    /// This can be either a Unicast or a Group Address.
    public let destination: Address
    /// Initial Time To Live (TTL) used when sending the message.
    ///
    /// When the heartbeat message travels across the mesh network it may be relayed
    /// by Relay Nodes. Each relay decrements the TTL and before retransmitting the message.
    /// This property contains the initial TTL value with which the message was sent by the
    /// originating Node.
    ///
    /// The received TTL is given in ``receivedTtl`` and number of hops in ``hops``.
    public let initialTtl: UInt8
    /// The Time To Live (TTL) value with which the Heartbeat message was received.
    public let receivedTtl: UInt8
    /// Number of hops that this message went through.
    ///
    /// This is calculated using the following formula: `initialTtl - receivedTtl + 1`.
    ///
    /// If the initial TTL was 5 and the message is received with TTL 3, it means that the message went through
    /// 3 hops: from the source Node to the first relay (TTL 4), from the first relay to the second relay (TTL 3),
    /// and from the second relay to the receiving Node (TTL 3).
    ///
    /// If the initial TTL is equal to the received TTL, it means that the message was sent directly from the
    /// source Node to the receiving Node, meaning there was only 1 hop.
    public let hops: UInt8
    /// Currently active features of the Node.
    ///
    /// - If the Relay feature is set, the Relay feature of a Node is in use.
    /// - If the Proxy feature is set, the GATT Proxy feature of a Node is in use.
    /// - If the Friend feature is set, the Friend feature of a Node is in use.
    /// - If the Low Power feature is set, the Node has active relationship with a Friend
    ///   Node.
    public let features: NodeFeatures
    /// The timestamp at which the Heartbeat message was received.
    public let timestamp: Date
}

/// Delegate protocol to receive Bluetooth Mesh Heartbeat messages.
public protocol MeshHeartbeatDelegate: AnyObject {
    
    /// Called when a Bluetooth Mesh Heartbeat message is received.
    func meshNetworkManager(_ manager: MeshNetworkManager, didReceiveHeartbeat heartbeat: MeshHeartbeat)
}
