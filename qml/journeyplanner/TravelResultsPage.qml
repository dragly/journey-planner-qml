import QtQuick 1.1
import com.nokia.meego 1.0
//import com.nokia.extras 1.0
import "constants.js" as UI
import "travels.js" as Travels

Page {
    property real defaultMargin: UI.MARGIN_XLARGE
    id: travelResultsPage
    property string toStation: "3012036"
    property string fromStation: "3010453"
    property string time: "201107231500"

    anchors.margins: defaultMargin

    tools: ToolBarLayout {
        ToolIcon {
            iconId: "toolbar-back";
            onClicked: pageStack.pop()
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

    ListModel {
        id: travelModel

        signal loadCompleted()
    }


    TitleLabel {
        id: titleRect
        text: qsTr("Travel Search Results")
    }

    ListView {
        id: listview

        anchors {
            top: titleRect.bottom
            bottom: parent.bottom
            right: parent.right
            left: parent.left
        }

        clip: true
        model: travelModel
        delegate: TravelDelegate {
        }
    }

    function search() {
        travelModel.clear()

        var xhr = new XMLHttpRequest;
        var url = "http://services.epi.trafikanten.no/Travel/GetTravelsAfter/?from=" +  fromStation + "&to=" + toStation + "&time=" + time
        console.log("Requesting " + url)
        xhr.open("GET", url);
        xhr.onreadystatechange = function() {
                    if (xhr.readyState == XMLHttpRequest.DONE) {
                        Travels.setTravels(xhr.responseText)
                    }
                }
        xhr.send();
    }
}
