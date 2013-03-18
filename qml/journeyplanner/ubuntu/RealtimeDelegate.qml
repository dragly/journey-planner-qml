import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import "../constants.js" as UI

ListItem.Empty {
    id: listItem

//    signal clicked
    property alias pressed: mouseArea.pressed

    property int titleSize: UI.LIST_TILE_SIZE
    property int titleWeight: Font.Normal
    property color titleColor: UI.LIST_TITLE_COLOR

    property int subtitleSize: UI.LIST_SUBTILE_SIZE
    property int subtitleWeight: Font.Light
    property color subtitleColor: UI.LIST_SUBTITLE_COLOR

    height: UI.REALTIME_DELEGATE_HEIGHT
    width: parent.width

    BorderImage {
        id: background
        anchors.fill: parent
        // Fill page porders
        anchors.leftMargin: -UI.MARGIN_XLARGE
        anchors.rightMargin: -UI.MARGIN_XLARGE
        visible: mouseArea.pressed
//        source: "image://theme/meegotouch-list-background-pressed-center"
    }

    Row {
        anchors.fill: parent
        spacing: UI.LIST_ITEM_SPACING

        Column {
            anchors.verticalCenter: parent.verticalCenter

            Label {
                text: model.lineName + " " + model.destination
//                font.weight: listItem.titleWeight
//                font.pixelSize: listItem.titleSize
                color: listItem.titleColor
            }
        }
    }
    Label {
        id: timeText
        text: model.timeLeft
//        font.weight: Font.Bold
//        font.pixelSize: UI.LIST_TILE_SIZE
        anchors.right: parent.right

        anchors.verticalCenter: parent.verticalCenter
    }
    MouseArea {
        id: mouseArea;
        anchors.fill: parent
        onClicked: {
            listItem.clicked(mouse);
        }
    }
}

