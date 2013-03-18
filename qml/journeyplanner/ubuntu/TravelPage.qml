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
    //        tools: commonTools
    //    anchors.margins: UiConstants.DefaultMargin
    //        anchors.margins: defaultMargin

    //        function updateDateTime() {
    //            var d = new Date(datePickerDialog.year, datePickerDialog.month - 1, datePickerDialog.day, timePickerDialog.hour, timePickerDialog.minute)
    //            console.log(d.getFullYear() + " " + d.getHours())
    //            datePickerButton.text = Qt.formatDateTime(d, "ddd dd MMM yyyy");
    //            timePickerButton.text = Qt.formatDateTime(d, "hh:mm");
    //            travelResultsPage.time = Qt.formatDateTime(d, "ddMMyyyyhhmm");
    //        }
    //        Component.onCompleted: {
    //            var d = new Date();
    //            datePickerDialog.year = d.getFullYear();
    //            datePickerDialog.month = d.getMonth() + 1;
    //            datePickerDialog.day = d.getDate();
    //            datePickerButton.text = Qt.formatDate(d, "ddd dd MMM yyyy");
    //            timePickerDialog.hour = d.getHours();
    //            timePickerDialog.minute = d.getMinutes();
    //            timePickerButton.text = Qt.formatTime(d, "hh:mm");
    //            updateDateTime()
    //        }


    //        TravelResultsPage{
    //            id: travelResultsPage
    //            toStation: "3010420"
    //            fromStation: "3012040"
    //        }

    //        TitleLabel {
    //            id: titleRect
    //            text: qsTr("Travel Search")
    //        }

    //    SearchPage {
    //        id: toSearchPage
    //        visible: false
    //        onSearchItemClicked: {
    //            toButton.text = stationName
    //            toStationID = stationId
    //            mainPageStack.pop()
    //        }
    //    }

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
                Button {
                    width: layoutColumn.width / 2
                    id: datePickerButton
                    text: "Pick date"
                    onClicked: {
                        datePickerDialog.open()
                    }
                }
                Button {
                    width: layoutColumn.width / 2
                    id: timePickerButton
                    text: "Pick time"
                    onClicked: {
                        timePickerSheet.open()
                    }
                }
            }
//            Button {
//                width: parent.width
//                text: "Search"
//                onClicked: {
//                    search()
//                }
//            }

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

    function search() {
        travelModel.clear()

        var xhr = new XMLHttpRequest;
        var url = "http://api.trafikanten.no/reisrest/Travel/GetTravelsByPlaces/?time=" + travelTime + "&toplace=" + toStationID + "&fromplace=" + fromStationID  + "&changeMargin=2&changePunish=10&walkingFactor=100&walkingDistance=2000&isAfter=True&proposals=12&transporttypes=Bus,AirportTrain,Boat,Train,Tram,Metro"
        console.log("Requesting " + url)
        xhr.open("GET", url);
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE) {
                Travels.setTravels(xhr.responseText, travelModel)
            }
        }
        xhr.send();
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
