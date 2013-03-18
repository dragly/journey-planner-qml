import QtQuick 2.0
import org.dragly 1.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import Ubuntu.Components.Popups 0.1
import "../constants.js" as UI
import "../travels.js" as Travels

Page {
    id: travelPage
    //        property real defaultMargin: UI.MARGIN_XLARGE

    property bool isTo
    property string fromStationID: "3010200"
    property string toStationID: "3012040"
    property string travelTime

    signal fromButtonClicked

    anchors.fill: parent

    SearchSheet {
        id: fromSearchSheet

        onSearchItemClicked: {
            travelPage.fromStationID = stationId
            fromButton.text = stationName
            search()
        }
    }

    SearchSheet {
        id: toSearchSheet

        onSearchItemClicked: {
            travelPage.toStationID = stationId
            toButton.text = stationName
            search()
        }
    }

    DatePickerDialog {
        id: datePickerDialog

        maximumYear: (new Date()).getFullYear() + 2
        minimumYear: (new Date()).getFullYear()

        onClosed: {
            refreshTravelTime()
            search()
        }

        Component.onCompleted: {
            refreshTravelTime()
        }
    }

    TimePickerDialog {
        id: timePickerSheet

        onClosed: {
            refreshTravelTime()
            search()
        }

        Component.onCompleted: {
            refreshTravelTime()
        }
    }

    function search() {
        Travels.findTravels(fromStationID, toStationID, travelTime, travelModel)
    }

    function refreshTravelTime() {
        console.log("Refreshing!")
        var d = new Date(datePickerDialog.year, datePickerDialog.month - 1, datePickerDialog.day, timePickerSheet.hour, timePickerSheet.minute)
        console.log(d)
        travelTime = Qt.formatDateTime(d, "ddMMyyyyhhmm");
        console.log(travelTime)
        datePickerButton.text = Qt.formatDateTime(d, "yyyy-MM-dd");
        console.log(Qt.formatDateTime(d, "yyyy-MM-dd"))
        timePickerButton.text = Qt.formatDateTime(d, "hh:mm");
        console.log(Qt.formatDateTime(d, "hh:mm"))
    }

    Flickable {
        anchors.fill: parent
        contentHeight: layoutColumn.height
        Column {
            id: layoutColumn
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: units.gu(2)
            spacing: units.gu(1)

            //            spacing: defaultMargin
            Label {
                text: "From:"
            }
            Button {
                id: fromButton
                text: "Select"
                width: parent.width
                //                width: parent.width
                onClicked: {
                    fromSearchSheet.open()
                }
            }
            Label {
                text: "To:"
            }
            Button {
                id: toButton
                text: "Select"
                width: parent.width
                //            height: 50
                onClicked: {
                    toSearchSheet.open()
                }
            }

            Row {
                spacing: units.gu(1)
                Button {
                    width: layoutColumn.width / 2 - parent.spacing / 2
                    id: datePickerButton
                    text: "Pick date"
                    onClicked: {
                        datePickerDialog.open()
                    }
                }
                Button {
                    width: layoutColumn.width / 2 - parent.spacing / 2
                    id: timePickerButton
                    text: "Pick time"
                    onClicked: {
                        timePickerSheet.open()
                    }
                }
            }

            ListView {
                id: travelSearchResultsListView
                interactive: false
                model: travelModel

                width: parent.width

                height: count * units.gu(10)

                delegate: TravelDelegate {

                }
            }
        }
    }

    ListModel {
        id: travelModel

        signal loadCompleted()

        onLoadCompleted: {
            console.log("Model load completed " + count)
        }
    }

    //        DatePickerDialog {
    //            id: datePickerDialog
    //            titleText: "Travel date"
    //            onAccepted: {
    //                updateDateTime()
    //            }
    //        }
    //        TimePickerDialog {
    //            id: timePickerDialog
    //            titleText: "Travel Time"
    //            onAccepted: {
    //                updateDateTime()
    //            }
    //        }

    //        Sheet {
    //            id: searchSheet
    //            rejectButtonText: "Cancel"
    //            anchors.margins: defaultMargin
    //            content: searchForm
    //        }
    //        SearchForm {
    //            id: searchForm
    //            realTime: false
    //            anchors.fill: parent
    //            anchors.margins: defaultMargin
    //            listDelegate: SearchDelegate {
    //                onClicked:  {
    //                    if(isTo) {
    //                        travelResultsPage.toStation = stationId
    //                        toButton.text = title
    //                    } else {
    //                        travelResultsPage.fromStation = stationId
    //                        fromButton.text = title
    //                    }
    //                    searchSheet.close()
    //                }
    //            }
    //        }

}
