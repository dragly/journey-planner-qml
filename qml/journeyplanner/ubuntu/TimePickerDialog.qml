import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import Ubuntu.Components.Popups 0.1
import org.dragly 1.0
import "TumblerIndexHelper.js" as TH

Sheet {
    id: root
    property int hour: (new Date()).getHours()
    property int minute: (new Date()).getMinutes()
    Tumbler {
        id: tumbler
        height: units.gu(30)
        width: parent.width
        anchors.centerIn: parent

        columns: [hourColumn, minuteColumn]

        TumblerColumn {
            id: hourColumn
            items: ListModel {
                id: hourList
            }
            label: "HOUR"
            selectedIndex: root.hour
        }
        TumblerColumn {
            id: minuteColumn
            items: ListModel {
                id: minuteList
            }
            label: "MINUTE"
            selectedIndex: root.minute
        }
    }

    onHourChanged: {
        hourColumn.selectedIndex = hour
    }

    onMinuteChanged: {
        minuteColumn.selectedIndex = minute
    }

    onClosed: {
        hour = hourColumn.selectedIndex
        minute = minuteColumn.selectedIndex
    }

    Component.onCompleted: {
        for(var i = 0; i < 24; i++) {
            hourList.append({"value": i})
        }
        for(var i = 0; i < 60; i++) {
            minuteList.append({"value": i})
        }
    }
}
