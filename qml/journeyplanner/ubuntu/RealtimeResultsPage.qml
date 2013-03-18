import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import "../constants.js" as UI
import "../helpers.js" as Helper

Tabs {
    id: realtimePage
    property real defaultMargin: UI.MARGIN_XLARGE
    property string stationId
    property string stationName
    Tab {
        title: stationName
        page: Page {

            tools: ToolbarActions {
                Action {
                    objectName: "action"

//                            iconSource: Qt.resolvedUrl("avatar.png")
                    text: i18n.tr("Favorite")

                    onTriggered: {
                        console.log("Favorites are not yet implemented...")
                    }
                }
            }
            anchors.margins: defaultMargin

            ListModel {
                id: realtimeModel

                signal loadCompleted()
            }

            ListView {
                id: listview
                interactive: true
                anchors.fill: parent

                model: realtimeModel
                delegate: RealtimeDelegate{

                }

            }
        }
    }


    function refresh() {
        console.log("Wee!")
        //                realtimeModel.clear()

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
                    var timeLeft = "";
                    if(timeDifferenceMinutes < 1) {
                        timeLeft = i18n.tr("now");
                    } else {
                        timeLeft = timeDifferenceMinutes.toFixed(0) + i18n.tr(" min");
                    }
                    realtimeModel.append({
                                             lineName: o.PublishedLineName,
                                             destination: o.DestinationName,
                                             arrivalTime: arrivalTime,
                                             timeLeft: timeLeft,
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
}
