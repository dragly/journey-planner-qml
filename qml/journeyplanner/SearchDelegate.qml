import QtQuick 1.1
import com.nokia.meego 1.0
//import com.nokia.extras 1.0
import "constants.js" as UI

ListDelegate {
    id: searchDelegate
    Image {
        source: "image://theme/icon-m-common-drilldown-arrow" + (theme.inverted ? "-inverse" : "")
        anchors.right: parent.right;

        anchors.verticalCenter: parent.verticalCenter
    }
}
