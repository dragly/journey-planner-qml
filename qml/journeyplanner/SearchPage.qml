import QtQuick 1.1
import com.nokia.meego 1.0
//import com.nokia.extras 1.0
import "constants.js" as UI

Page {
    property real defaultMargin: UI.MARGIN_XLARGE

    id: searchPage
    tools: commonTools
    //    anchors.margins: UiConstants.DefaultMargin
    anchors.margins: defaultMargin


    TitleLabel {
        id: searchHeader
        text: qsTr("Search")
    }

    SearchForm {
        realTime: true
        anchors {
            top: searchHeader.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        listDelegate: SearchDelegate {
            onClicked:  {
                pageStack.push(realtimePage)
                realtimePage.stationId = stationId
                realtimePage.stationName = title
                realtimePage.refresh()
            }
        }
    }
}
