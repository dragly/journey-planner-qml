import QtQuick 1.1
import com.nokia.meego 1.0
//import com.nokia.extras 1.0
import "constants.js" as UI

Page {
    property real defaultMargin: UI.MARGIN_XLARGE

    id: positionPage
    tools: commonTools
    //    anchors.margins: UiConstants.DefaultMargin
    anchors.margins: defaultMargin

    Label {
        text: "Position search is not yet implemented. Sorry!"
        anchors.centerIn: parent
    }
}
