// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1


Item {
    id: titleRect
    property string text
    anchors.leftMargin: -defaultMargin
    anchors.rightMargin: -defaultMargin
    anchors.topMargin: -defaultMargin
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    height: 80
    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        gradient: Gradient {
            GradientStop {position: 0; color: "#CCC" }
            GradientStop {position: 1; color: "#BBB" }
        }

        height: 60
        Text {
            anchors.margins: defaultMargin
            anchors.fill: parent
            color: "white"
            text: titleRect.text
            font.pixelSize: 32
        }
        Rectangle {
            height: 1
            color: "white"
            anchors {
                right: parent.right
                left: parent.left
                bottom: parent.bottom
            }
        }
        BorderImage {
            anchors.fill: parent
            anchors { leftMargin: 0; topMargin: 0; rightMargin: 0; bottomMargin: -10 }
            border { left: 10; top: 10; right: 10; bottom: 10 }
            source: "qrc:images/shadow.png"; smooth: true
            z: -99
        }
    }
}
