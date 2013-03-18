import QtQuick 1.1
import com.nokia.meego 1.0
//import com.nokia.extras 1.0
import "constants.js" as UI

Item {
    property alias listDelegate: listview.delegate
    property alias searchModel: searchModel
    property alias searchField: searchField
    property bool realTime: true
    ListModel {
        id: searchModel

        signal loadCompleted()
    }

    RealtimePage{
        id: realtimePage
    }
    function search() {

        var xhr = new XMLHttpRequest;
        var url
        if(realTime) {
            url = "http://services.epi.trafikanten.no/RealTime/FindMatches/" +  searchField.text
        } else {
            url = "http://services.epi.trafikanten.no/Place/FindMatches/" +  searchField.text
        }
        console.log("Requesting " + url)
        xhr.open("GET", url);

        xhr.onreadystatechange = function() {
                    if (xhr.readyState == XMLHttpRequest.DONE) {
                        var a = JSON.parse(xhr.responseText);
                        searchModel.clear()
                        for (var b in a) {
                            var o = a[b];
                            if(o.Type == "0") // we don't want areas yet
                                searchModel.append({title: o.Name, subtitle: o.District, stationId: o.ID, selected: false});
                            console.log(o.ID)
                        }

                        searchModel.loadCompleted()
                    }
                }
        xhr.send();
    }

    Column {
        id: col
        width: parent.width
        TextField {
            id: searchField
            width: parent.width
            height: 50

            Keys.onReturnPressed: {
                parent.focus = true;
            }
            onTextChanged: {
                search()
            }

            inputMethodHints: Qt.ImhNoPredictiveText
            Image {
                id: clearButton
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                source: "image://theme/icon-m-input-clear"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        searchField.text = ""
                    }
                }
            }

        }
    }

    ListView {
        id: listview

        anchors.top: col.bottom
        anchors.topMargin: defaultMargin
        anchors.bottom: parent.bottom

        width: parent.width
        clip: true

        model: searchModel
    }
}
