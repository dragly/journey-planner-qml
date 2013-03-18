// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0

Rectangle {
    property string lineNumber: "xx"
    width: units.gu(4)
    height: units.gu(4)
    radius: units.gu(1)
    smooth: true
    gradient: Gradient {
        GradientStop{ position: 0.0; color: "#c8d0e0" }
        GradientStop{ position: 0.05; color: "#f7f7f9" }
        GradientStop{ position: 1.0; color: "#c0ccd4" }
    }
    border {
        color: "#999999"
        width: 1
    }

    Text {
        font.pixelSize: 20
//        font.bold: true
        text: lineNumber
        color: "#808080"
        anchors.centerIn: parent
    }
}
