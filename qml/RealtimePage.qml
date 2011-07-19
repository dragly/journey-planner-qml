import QtQuick 1.0
import com.nokia.meego 1.0
import com.nokia.extras 1.1
import "constants.js" as UI

Page {
    property real defaultMargin: UI.MARGIN_XLARGE
    property string stationId
    property string stationName

    id: realtimePage
    tools: ToolBarLayout {
        ToolIcon {
            iconId: "toolbar-back";
            onClicked: {pageStack.pop()}
        }
        ToolIcon {
            iconId: "toolbar-favorite-unmark";
            onClicked: console.log("Favorites not implemented...")
        }
        ToolIcon { platformIconId: "toolbar-view-menu";
            anchors.right: parent===undefined ? undefined : parent.right
            onClicked: (myMenu.status == DialogStatus.Closed) ? myMenu.open() : myMenu.close()
        }
    }
    anchors.margins: defaultMargin

    ListModel {
        id: realtimeModel

        signal loadCompleted()
    }

    function refresh() {
        realtimeModel.clear()

        var xhr = new XMLHttpRequest;
        xhr.open("GET", "http://services.epi.trafikanten.no/RealTime/GetRealTimeData/" +  stationId);
        console.log("http://services.epi.trafikanten.no/RealTime/GetRealTimeData/" +  stationId)
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE) {
                var a = JSON.parse(xhr.responseText);
                for (var b in a) {
                    var o = a[b]
                    var substrLength = o.ExpectedArrivalTime.indexOf("+")-6
                    console.log(substrLength)
                    var dateTime = new Date(parseInt(o.ExpectedArrivalTime.substr(6,substrLength)))
                    var currentTime = new Date(parseInt(o.RecordedAtTime.substr(6,substrLength)))
                    var timeDifference = dateTime.getTime() - currentTime.getTime()
                    var timeDifferenceMinutes = timeDifference / 60000
                    console.log(dateTime.getDate())
                    console.log(Qt.formatDateTime(dateTime, "yyyy-MM-dd hh:mm:ss"))
                    console.log("Logging finished")
                    realtimeModel.append({
                                         title: o.PublishedLineName + " " + o.DestinationName,
                                         timeLeft: timeDifferenceMinutes.toFixed(0) + " min",
                                         subtitle: Qt.formatDateTime(dateTime, "yyyy-MM-dd hh:mm:ss"),
                                         platform: o.DirectionRef,
                                         selected: false
                });
                }
                realtimeModel.loadCompleted()
            }
        }
        xhr.send();
    }

    ListView {
        id: listview
        interactive: true
        anchors.fill: parent
        clip: true

        header: Column {
            id: col
            spacing: defaultMargin
            width: parent.width

            Label {
                text: stationName
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: UI.LIST_TILE_SIZE + 4
            }
        }

        model: realtimeModel
        delegate: ListDelegate {
            onClicked:  {}
            Label {
                id: timeText
                text: model.timeLeft
                font.weight: Font.Bold
                font.pixelSize: UI.LIST_TILE_SIZE
                anchors.right: parent.right

                anchors.verticalCenter: parent.verticalCenter
            }
        }

    }
}
