// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    property string lineNumber: "xx"
    width: 40
    height: 40
    radius: 4
    gradient: Gradient {
        GradientStop{ position: 0.0; color: Qt.rgba(0.1,0.2,0.9,1) }
        GradientStop{ position: 0.45; color: Qt.rgba(0.1,0.2,0.9,1) }
        GradientStop{ position: 0.55; color: Qt.rgba(0.1,0.2,1.0,1) }
        GradientStop{ position: 1.0; color: Qt.rgba(0.1,0.2,1.0,1) }
    }

    Text {
        font.pixelSize: 20
        font.bold: true
        text: lineNumber
        color: "white"
        anchors.centerIn: parent
    }
}
