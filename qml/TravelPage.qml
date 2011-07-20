import QtQuick 1.0
import com.nokia.meego 1.0
import com.nokia.extras 1.0
import "constants.js" as UI

Page {
    property real defaultMargin: UI.MARGIN_XLARGE

    property bool isTo

    id: routePage
    tools: commonTools
    //    anchors.margins: UiConstants.DefaultMargin
    anchors.margins: defaultMargin

    function updateDateTime() {
        var d = new Date(datePickerDialog.year, datePickerDialog.month - 1, datePickerDialog.day, timePickerDialog.hour, timePickerDialog.minute)
        console.log(d.getFullYear() + " " + d.getHours())
        datePickerButton.text = Qt.formatDateTime(d, "ddd dd MMM yyyy");
        timePickerButton.text = Qt.formatDateTime(d, "hh:mm");
        travelResultsPage.time = Qt.formatDateTime(d, "ddMMyyyyhhmm");
    }
    Component.onCompleted: {
        var d = new Date();
        datePickerDialog.year = d.getFullYear();
        datePickerDialog.month = d.getMonth() + 1;
        datePickerDialog.day = d.getDate();
        datePickerButton.text = Qt.formatDate(d, "ddd dd MMM yyyy");
        timePickerDialog.hour = d.getHours();
        timePickerDialog.minute = d.getMinutes();
        timePickerButton.text = Qt.formatTime(d, "hh:mm");
        updateDateTime()
    }


    TravelResultsPage{
        id: travelResultsPage
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
                if(text != "Select")
                    searchForm.searchField.text = text
                else
                    searchForm.searchField.text = ""
                searchForm.searchModel.clear()
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
            height: 50
            onClicked: {
                isTo = true
                if(text != "Select")
                    searchForm.searchField.text = text
                else
                    searchForm.searchField.text = ""
                searchForm.searchModel.clear()
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
            width: parent.width
            text: "Search"
            onClicked: {
                travelResultsPage.search()
                pageStack.push(travelResultsPage)
            }
        }
    }

    DatePickerDialog {
        id: datePickerDialog
        titleText: "Travel date"
        onAccepted: {
            updateDateTime()
        }
    }
    TimePickerDialog {
        id: timePickerDialog
        titleText: "Travel Time"
        onAccepted: {
            updateDateTime()
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
        realTime: false
        anchors.fill: parent
        anchors.margins: defaultMargin
        listDelegate: SearchDelegate {
            onClicked:  {
                if(isTo) {
                    travelResultsPage.toStation = stationId
                    toButton.text = title
                } else {
                    travelResultsPage.fromStation = stationId
                    fromButton.text = title
                }
                searchSheet.close()
            }
        }
    }

}
