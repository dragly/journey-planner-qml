import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import Ubuntu.Components.Popups 0.1

Rectangle {
    id: sheet

    width: parent.width
    height: parent.height - units.gu(10)

    signal closed()
    signal opened()

    z: 999

    function open() {
        state = "open"
    }
    function close() {
        state = "closed"
    }

    states: [
        State {
            name: "open"
            PropertyChanges {
                target: sheet
                y: units.gu(10)
            }
        },
        State {
            name: "closed"
            PropertyChanges {
                target: sheet
                y: parent.height
            }
        }
    ]

    transitions: Transition {
        PropertyAnimation {
            properties: "y"
            easing.type: Easing.InOutQuad
        }
    }

    Button {
        text: "Close"
        height: units.gu(4)
        anchors.right: parent.right
        anchors.top: parent.top

        anchors.margins: units.gu(2)
        onClicked: sheet.close()
    }

    onStateChanged: {
        if(state === "closed") {
            closed()
        } else {
            opened()
        }
    }

    state: "closed"
}
