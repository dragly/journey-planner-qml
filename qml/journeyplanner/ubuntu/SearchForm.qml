import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

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
                Keys.onReturnPressed: {
                    searchForm.search(true);
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

    function search(realtime) {
        console.log("Wee!")

        var xhr = new XMLHttpRequest;
        var url
        if(realtime) {
            url = "http://services.epi.trafikanten.no/RealTime/FindMatches/" +  searchField.text
        } else {
            //                    url = "http://services.epi.trafikanten.no/Place/FindMatches/" +  searchField.text
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
}
