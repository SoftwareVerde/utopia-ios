
import Foundation

open class ChatroomMessage {
    open static func fromUtopiaChatroomMessage(_ chatroomMessage: ComSoftwareverdeUtopiaChatroom_Message) -> ChatroomMessage {
        return ChatroomMessage(chatroomMessage: chatroomMessage)
    }

    fileprivate let _chatroomMessage : ComSoftwareverdeUtopiaChatroom_Message

    fileprivate init(chatroomMessage: ComSoftwareverdeUtopiaChatroom_Message) {
        _chatroomMessage = chatroomMessage
    }

    open func toUtopiaChatroomMessage() -> ComSoftwareverdeUtopiaChatroom_Message {
        return _chatroomMessage
    }

    open func getId() -> String {
        return _chatroomMessage.getId()
    }

    open func getMessage() -> String {
        return _chatroomMessage.getMessage()
    }

    open func getDisplayName() -> String {
        return _chatroomMessage.getDisplayName()
    }

    open func getTimestamp() -> Int {
        return _chatroomMessage.getTimestamp().intValue / 1000
    }

}
