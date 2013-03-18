import QtQuick 1.1
import com.nokia.meego 1.0
//import com.nokia.extras 1.0
import "constants.js" as UI
import "travels.js" as Travels
import "helpers.js" as Helpers

Item {
    id: travelListItem

    signal clicked
    property alias pressed: mouseArea.pressed

    property int titleSize: UI.LIST_TILE_SIZE
    property int titleWeight: Font.Bold
    property color titleColor: theme.inverted ? UI.LIST_TITLE_COLOR_INVERTED : UI.LIST_TITLE_COLOR

    property int subtitleSize: UI.LIST_SUBTILE_SIZE
    property int subtitleWeight: Font.Light
    property color subtitleColor: theme.inverted ? UI.LIST_SUBTITLE_COLOR_INVERTED : UI.LIST_SUBTITLE_COLOR

    property bool selected: false

    height: UI.TRAVEL_DELEGATE_HEIGHT
    width: parent.width
    clip: true

    Component.onCompleted: {
        var myTravelStages = JSON.parse(model.travelStages)
        for(var i in myTravelStages) {
            var travelStage = myTravelStages[i]
            travelStepModel.append({
                                       departureName: travelStage.DepartureStop.Name,
                                       arrivalName: travelStage.ArrivalStop.Name,
                                       lineName: travelStage.LineName,
                                       lineDestination: travelStage.Destination,
                                       transportation: travelStage.transportation,
                                       departureTime: Helpers.parseDate(travelStage.DepartureTime),
                                       arrivalTime: Helpers.parseDate(travelStage.ArrivalTime)
                                   })
        }
    }

    ListModel {
        id: travelStepModel

        signal loadCompleted()
    }

    BorderImage {
        id: background
        anchors.fill: parent
        // Fill page porders
        anchors.leftMargin: -UI.MARGIN_XLARGE
        anchors.rightMargin: -UI.MARGIN_XLARGE
        visible: mouseArea.pressed
        source: "image://theme/meegotouch-list-background-pressed-center"
    }

    Behavior on height {
        NumberAnimation {
            duration: 500
            easing.type: Easing.InOutCubic
        }
    }


    Column {
        id: delegateColumn
        anchors {
            top: parent.top
            left: parent.left
        }

        Label {
            id: mainText
            text: Qt.formatDateTime(departureTime, "hh:mm") + "    " + Qt.formatDateTime(arrivalTime, "hh:mm")
            font.weight: travelListItem.titleWeight
            font.pixelSize: travelListItem.titleSize
            color: travelListItem.titleColor
        }

        Label {
            id: subText
            text: "Travel time: " + travelTime + " min"
            font.weight: travelListItem.subtitleWeight
            font.pixelSize: travelListItem.subtitleSize
            color: travelListItem.subtitleColor

            visible: text != ""
        }
    }

    Image {
        id: drillImage
        source: "image://theme/icon-m-common-drilldown-arrow" + (theme.inverted ? "-inverse" : "")
        anchors.right: parent.right;

        anchors.verticalCenter: delegateColumn.verticalCenter

        Behavior on rotation {
            NumberAnimation {
                duration: 300
            }
        }
    }
    Row {
        anchors.right: drillImage.left
        anchors.rightMargin: 10
        anchors.verticalCenter: drillImage.verticalCenter
        spacing: 10
        LineNumber {
            lineNumber: travelStage0
            visible: travelStageType0 !== ""
        }

        LineNumber {
            lineNumber: travelStage1
            visible: travelStageType1 !== ""
        }

        LineNumber {
            lineNumber: travelStage2
            visible: travelStageType2 !== ""
        }

        LineNumber {
            lineNumber: travelStage3
            visible: travelStageType3 !== ""
        }
    }


    LineSeparator {
        id: lineSeparator
        anchors.top: delegateColumn.bottom
        anchors.topMargin: UI.TRAVEL_DELEGATE_LIST_VIEW_MARGIN
    }
    ListView {
        id: travelStepView

        anchors {
            top: lineSeparator.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        model: travelStepModel
        delegate: TravelStepDelegate {}
    }
    MouseArea {
        id: mouseArea;
        anchors.fill: parent
        onClicked: {
            travelListItem.clicked();
            if(selected) {
                travelListItem.height = UI.TRAVEL_DELEGATE_HEIGHT
                selected = false
                drillImage.rotation = 0
            } else {
                travelListItem.height = UI.TRAVEL_DELEGATE_HEIGHT + UI.TRAVEL_DELEGATE_LIST_VIEW_MARGIN + travelStepModel.count * UI.TRAVELSTEP_DELEGATE_HEIGHT
                selected = true
                drillImage.rotation = -90
            }
        }
    }

}
