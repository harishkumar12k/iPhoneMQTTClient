//
//  MQTTService.swift
//  MQTTClient
//
//  Created by Harish Kumar on 06/05/26.
//

import Foundation
import CocoaMQTT

protocol MQTTServiceDelegate: AnyObject {
    func didConnect()
    func didDisconnect()
    func didReceiveMessage(_ text: String)
}

class MQTTService: NSObject {
    
    private var mqtt: CocoaMQTT?
    weak var delegate: MQTTServiceDelegate?
    private var yourName: String = ""
    private var friendName: String = ""

    func connect(host: String, yourName: String, friendName: String) {
        self.yourName = yourName
        self.friendName = friendName
        
        mqtt = CocoaMQTT(clientID: "IPhone_User", host: host, port: 1883)
        mqtt?.delegate = self
        mqtt?.autoReconnect = true
        let _ = mqtt?.connect()
    }
    
    func disconnect() {
        mqtt?.disconnect()
    }
    
    func send(_ text: String, to receiverId: String) {
        let topic = "chat/\(self.friendName)/inbox"
        mqtt?.publish(topic, withString: text)
    }
    
}

extension MQTTService: CocoaMQTTDelegate {
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        if ack == .accept {
            mqtt.subscribe([("chat/\(self.yourName)/inbox", .qos1)])
            delegate?.didConnect()
        }
    }
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        delegate?.didDisconnect()
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        let text = message.string ?? ""
        delegate?.didReceiveMessage(text)
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print("didPublishMessage")
    }
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        print("didPublishAck")
    }
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopics success: NSDictionary, failed: [String]) {
        print("didSubscribeTopics: \(success)")
    }
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopics topics: [String]) {
        print("didUnsubscribeTopics")
    }
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        print("mqttDidPing")
    }
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        print("mqttDidReceivePong")
    }
}
