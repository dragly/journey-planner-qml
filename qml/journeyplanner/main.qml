import QtQuick 1.1
import com.nokia.meego 1.0
import org.dragly 1.0
//import com.nokia.extras 1.0
import "constants.js" as UI

PageStackWindow {
    id: appWindow

    initialPage: searchPage

    SearchPage{id: searchPage}
    TravelSearchPage{id: routePage}
    PositionPage{id: positionPage}

    Component.onCompleted: {
        //theme.inverted = !theme.inverted
    }

    Settings {
        id: settings
    }

    ToolBarLayout {
        id: commonTools
        ToolIcon {
            iconId: "toolbar-back-dimmed";
            onClicked: {
                console.log("Stop clicking backwards! You are already on the first page!")
            }
        }
        ButtonRow {
            platformStyle: TabButtonStyle { }
            TabButton {
                iconSource: "image://theme/icon-m-toolbar-search"
                onClicked: {
                    pageStack.clear(); pageStack.push(searchPage)
                    console.log(settings.value("test"))
                }
            }
            TabButton {
                iconSource: "image://theme/icon-m-toolbar-callhistory"
                onClicked: {pageStack.clear(); pageStack.push(routePage)}
            }
            TabButton {
                iconSource: "image://theme/icon-m-toolbar-callhistory"
                onClicked: {
                    pageStack.clear(); pageStack.push(positionPage)
                    settings.setValue("test","45")
                }
            }
        }
        ToolIcon {
            iconId: "toolbar-view-menu"
            onClicked: (myMenu.status == DialogStatus.Closed) ? myMenu.open() : myMenu.close()
            anchors.right: parent==undefined ? undefined : parent.right
        }
    }

    Menu {
        id: myMenu
        visualParent: pageStack
        MenuLayout {
            MenuItem { text: "Sample menu item" }
        }
    }
}
// aaaaaaa
