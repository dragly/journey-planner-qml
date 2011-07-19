import QtQuick 1.0
import com.nokia.meego 1.0
import com.nokia.extras 1.1
import "constants.js" as UI

Page {
    property real defaultMargin: UI.MARGIN_XLARGE

    property string toStation: "3012036"
    property string fromStation: "3010453"

    property bool isTo

    id: routePage
    tools: commonTools
    //    anchors.margins: UiConstants.DefaultMargin
    anchors.margins: defaultMargin

    Component.onCompleted: {
        var d = new Date();
        datePickerDialog.year = d.getFullYear();
        datePickerDialog.month = d.getMonth() + 1;
        datePickerDialog.day = d.getDate();
        datePickerButton.text = Qt.formatDate(d, "ddd dd MMM yyyy");
        timePickerDialog.hour = d.getHours();
        timePickerDialog.minute = d.getMinutes();
        timePickerButton.text = Qt.formatTime(d, "hh:mm");
    }

    Column {
        id: col
        width: parent.width
        spacing: defaultMargin
        Label {
            text: "From:"
        }
        Button {
            id: fromButton
            text: "Select"
            width: parent.width
            onClicked: {
                isTo = false
                searchForm.searchField.text = ""
                searchForm.searchModel.clear()
                searchForm.searchField.focus = true
                searchSheet.open()
            }
        }
        Label {
            text: "To:"
        }
        Button {
            id: toButton
            text: "Select"
            width: parent.width
            onClicked: {
                isTo = true
                searchForm.searchField.text = ""
                searchForm.searchModel.clear()
                searchForm.searchField.focus = true
                searchSheet.open()
            }
        }
        Row {
            Button {
                width: col.width / 2
                id: datePickerButton
                text: "Pick date"
                onClicked: {
                    datePickerDialog.open()
                }
            }
            Button {
                width: col.width / 2
                id: timePickerButton
                text: "Pick time"
                onClicked: {
                    timePickerDialog.open()
                }
            }
        }
        Button {
            text: "Search"
            onClicked: {
                search()
            }
        }
    }
    ListModel {
        id: travelModel

        signal loadCompleted()
    }

    function search() {
        travelModel.clear()

        var xhr = new XMLHttpRequest;
        var url = "http://services.epi.trafikanten.no/Travel/GetTravelsAdvanced/?fromStops=" +  fromStation + "&toStops=" + toStation
        console.log("Requesting " + url)
        xhr.open("GET", url);
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE) {
                var a = JSON.parse(xhr.responseText);
                for (var b in a) {
                    var travel = a[b];
                    console.log(travel.DepartureTime)
                    console.log(travel.ArrivalTime)
                    for (var c in travel.TravelStages) {
                        var stage = travel.TravelStages[c]
                        console.log(stage.DepartureStop.Name)
                    }

//                    travelModel.append({
//                                       departureStop: o.DepartureStop[0],
//                                       departureTime: o.DepartureTime,
//                                       arrivalStop: o.ArrivalStop,
//                                       arrivalTime: o.ArrivalTime,
//                                       selected: false});
                }
                travelModel.loadCompleted()
            }
        }
        xhr.send();
    }

    DatePickerDialog {
        id: datePickerDialog
        titleText: "Travel date"
        onAccepted: {
            var d = new Date(datePickerDialog.year, datePickerDialog.month - 1, datePickerDialog.day, timePickerDialog.hour, timePickerDialog.minute)
            console.log(d.getMonth())
            datePickerButton.text = Qt.formatDateTime(d, "ddd dd MMM yyyy");
        }
    }
    TimePickerDialog {
        id: timePickerDialog
        titleText: "Travel Time"
        onAccepted: {
            var d = new Date(datePickerDialog.year, datePickerDialog.month - 1, datePickerDialog.day, timePickerDialog.hour, timePickerDialog.minute)
            console.log(d.getFullYear() + " " + d.getHours())
            timePickerButton.text = Qt.formatDateTime(d, "hh:mm");
        }
    }
    Sheet {
        id: searchSheet
        rejectButtonText: "Cancel"
        anchors.margins: defaultMargin
        content: searchForm
    }
    SearchForm {
        id: searchForm
        anchors.fill: parent
        anchors.margins: defaultMargin
        listDelegate: SearchDelegate {
            onClicked:  {
                if(isTo) {
                    toStation = stationId
                    toButton.text = title
                } else {
                    fromStation = stationId
                    fromButton.text = title
                }
                searchSheet.close()
            }
        }
    }

}
