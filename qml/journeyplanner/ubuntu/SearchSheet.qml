import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import Ubuntu.Components.Popups 0.1
import "../constants.js" as UI

Sheet {
    id: searchSheet

    signal searchItemClicked(string stationId, string stationName)

    property alias searchFieldText: searchForm.searchFieldText

//    onOpened: {
//        searchForm.searchText
//    }

    Column {
        anchors.margins: units.gu(2)
        anchors.fill: parent

        Button {
            text: "Close"
            height: units.gu(4)
            anchors.right: parent.right
            onClicked: searchSheet.close()
        }

        SearchForm {
            id: searchForm

            width: parent.width
            height: 200
            onSearchItemClicked: {
                searchSheet.searchItemClicked(stationId, stationName)
                searchSheet.close()
            }
        }
    }
}
