import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import "../travels.js" as Travels

Item {
    id: searchForm

    property alias searchFieldText: searchField.text

    signal searchItemClicked(string stationId, string stationName)

    ListModel {
        id: searchModel
        //        ListElement {
        //            title: "Test"
        //        }
        signal loadCompleted()
    }

    Flickable {
        contentHeight: column2.height
        anchors.fill: parent
        Column {
            id: column2
            width: parent.width
            Rectangle {
                //                                id: filler
                height: units.gu(2)
                width: parent.width
                color: "transparent"
            }
            TextField {
                id: searchField
                height: units.gu(4)
                anchors.left: parent.left
                anchors.right: parent.right
                font.pixelSize: FontUtils.sizeToPixels("large")
                anchors.margins: units.gu(2)

                text: i18n.tr("Search")
                onActiveFocusChanged: {
                    if(activeFocus && text === i18n.tr("Search")) {
                        text = "";
                    }
                }
//                Keys.onReturnPressed: {
//                    searchForm.search(true);
//                }
                Keys.onPressed: {
                    Travels.findStations(true, searchModel);
                }
            }
            ListView {
                id: listView
                interactive: false
                width: parent.width
                height: units.gu(7) * count
                //                            contentHeight: units.gu(5) * count

                model: searchModel

                Component {
                    id: listDelegate
                    ListItem.Standard {
                        id: delegateItem
                        text: title
                        progression: true
                        onClicked: {
                            searchItemClicked(stationId, title)
                        }
                    }
                }

                delegate: listDelegate
            }
        }
    }
}
