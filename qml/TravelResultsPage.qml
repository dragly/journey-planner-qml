import QtQuick 1.0
import com.nokia.meego 1.0
import com.nokia.extras 1.0
import "constants.js" as UI
import "travels.js" as Travels

Page {
    property real defaultMargin: UI.MARGIN_XLARGE
    id: travelResultsPage
    property string toStation: "3012036"
    property string fromStation: "3010453"
    property string time: "201107231500"

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

    ListModel {
        id: travelModel

        signal loadCompleted()
    }
    ListView {
        id: listview

        anchors.fill: parent
        anchors.margins: defaultMargin

        model: travelModel
        delegate:
            ListDelegate {
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
                var a = JSON.parse(xhr.responseText);
                Travels.setTravels(a)
            }
        }
        xhr.send();
    }
}
