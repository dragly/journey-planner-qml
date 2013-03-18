import QtQuick 1.1
import com.nokia.meego 1.0
//import com.nokia.extras 1.0
import "constants.js" as UI

Item {
    id: travelStepListItem

    property int titleSize: UI.LIST_TILE_SIZE
    property int titleWeight: Font.Bold
    property color titleColor: theme.inverted ? UI.LIST_TITLE_COLOR_INVERTED : UI.LIST_TITLE_COLOR

    property int subtitleSize: UI.LIST_SUBTILE_SIZE
    property int subtitleWeight: Font.Light
    property color subtitleColor: theme.inverted ? UI.LIST_SUBTITLE_COLOR_INVERTED : UI.LIST_SUBTITLE_COLOR

    height: UI.TRAVELSTEP_DELEGATE_HEIGHT
    width: parent.width

    LineSeparator {
        anchors.bottom: parent.bottom
    }

    Item {
        anchors.margins: 10
        anchors.fill: parent
        Label {
            id: departureTimeText
            anchors {
                left: parent.left
                top: parent.top
            }

            text: Qt.formatDateTime(model.departureTime,"hh:mm")
            font.pixelSize: 20
            color: travelStepListItem.titleColor
        }
        Label {
            id: arrivalTimeText
            anchors {
                left: parent.left
                bottom: parent.bottom
            }
            text: Qt.formatDateTime(model.arrivalTime,"hh:mm")
            font.pixelSize: 20
            color: travelStepListItem.titleColor
        }
        Label {
            anchors {
                left: departureTimeText.right
                leftMargin: 20
                top: parent.top
            }

            text: model.departureName
            font.pixelSize: 20
            color: travelStepListItem.titleColor
        }
        Label {
            anchors {
                left: departureTimeText.right
                leftMargin: 20
                bottom: parent.bottom
            }
            text: model.arrivalName
            font.pixelSize: 20
            color: travelStepListItem.titleColor
        }

        LineNumber {
            id: lineNumber
            anchors {
                left: departureTimeText.right
                leftMargin: 20
                verticalCenter: parent.verticalCenter
            }
            lineNumber: model.lineName
        }
        Label {
            anchors {
                left: lineNumber.right
                verticalCenter: parent.verticalCenter
                leftMargin: 10
            }

            text: model.lineDestination
            font.pixelSize: 20
            color: travelStepListItem.titleColor
        }
    }
}
