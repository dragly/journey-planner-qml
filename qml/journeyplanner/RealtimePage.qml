import QtQuick 1.1
import com.nokia.meego 1.0
//import com.nokia.extras 1.0
import "constants.js" as UI
import "helpers.js" as Helper

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
        ToolIcon {
            platformIconId: "toolbar-view-menu";
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
                            var arrivalTime = Helper.parseDate(o.ExpectedArrivalTime)
                            var currentTime = Helper.parseDate(o.RecordedAtTime)
                            var timeDifference = arrivalTime.getTime() - currentTime.getTime()
                            var timeDifferenceMinutes = timeDifference / 60000
                            realtimeModel.append({
                                                     lineName: o.PublishedLineName,
                                                     destination: o.DestinationName,
                                                     arrivalTime: arrivalTime,
                                                     timeLeft: timeDifferenceMinutes.toFixed(0) + " min",
                                                     subtitle: Qt.formatDateTime(arrivalTime, "yyyy-MM-dd hh:mm:ss"),
                                                     platform: o.DirectionRef,
                                                     selected: false
                                                 });
                        }
                        var swapped = true; // let's perform a bubble sort! :D
                        while(swapped) {
                            swapped = false;
                            for(var i = 0; i < realtimeModel.count - 1; i++) {
                                if(realtimeModel.get(i).arrivalTime > realtimeModel.get(i + 1).arrivalTime) {
                                    realtimeModel.move(i,i+1,1);
                                    swapped = true;
                                }
                            }
                        }
                        realtimeModel.loadCompleted()
                    }
                }
        xhr.send();
    }


    TitleLabel {
        id: titleRect
        text: qsTr(stationName)
    }

    ListView {
        id: listview
        interactive: true
        anchors {
            left: parent.left
            right: parent.right
            top: titleRect.bottom
            bottom: parent.bottom
        }

        clip: true

        model: realtimeModel
        delegate: RealTimeDelegate {}

    }
}
