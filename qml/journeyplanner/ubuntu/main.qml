import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

/*!
    \brief MainView with Tabs element.
           First Tab has a single Label and
           second Tab has a single ToolbarAction.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "rssreader"

    width: units.gu(50)
    height: units.gu(75)

    PageStack {
        id: mainPageStack
        __showHeader: false
        anchors.fill: parent
        Component.onCompleted: mainPageStack.push(tabs)

        RealtimeResultsPage {
            id: realtimePage
            visible: false
            anchors.fill: parent
        }

        Tabs {
            id: tabs
            anchors.fill: parent

            // First tab begins here
            Tab {
                id: realtimeSearchTab
                objectName: "realtimeTab"

                title: i18n.tr("Realtime")

                // Tab content begins here
                page: SearchForm {
                    anchors.fill: parent
                    onSearchItemClicked: {
                        realtimePage.stationId = stationId
                        realtimePage.stationName = stationName
                        realtimePage.refresh()
                        mainPageStack.push(realtimePage)
                    }
                }
            }
            Tab {
                id: travelSearchPage
                objectName: "travelTab"

                title: i18n.tr("Travel")

                page: TravelPage {
                    id: travelPage
                    anchors.fill: parent
                }
            }
            Tab {
                id: positionSearchPage
                objectName: "positionTab"

                title: i18n.tr("Position")

                page: PositionPage {
                    anchors.fill: parent
                }
            }
        }
    }
}
