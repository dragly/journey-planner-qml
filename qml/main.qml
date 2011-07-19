import QtQuick 1.0
import com.nokia.meego 1.0
import com.nokia.extras 1.1
import "constants.js" as UI

PageStackWindow {
    id: appWindow

    initialPage: searchPage

//    Page {
//        id: tabPage
////        tools: commonTools
//        TabGroup {
//            id: tabGroup

//            currentTab: tab1

//            PageStack {
//                id: tab1
//            }
//            PageStack {
//                id: tab2
//            }
//            Page {
//                id: tab3
//                Column {
//                    spacing: 10

//                    Text {
//                        text: "This is a single page"
//                    }
//                }
//            }
//        }

//        Component.onCompleted: {
//            tab1.push(searchPage);
//            tab2.push(routePage);
//        }
//    }

    SearchPage{id: searchPage}
    TravelPage{id: routePage}
    PositionPage{id: positionPage}

    Component.onCompleted: {theme.inverted = !theme.inverted}

    //    ToolBarLayout {
    //        id: commonTools
    //        visible: true
    //        ToolIcon { iconId: "toolbar-back-dimmed"; onClicked: {pageStack.pop()}}
    //        ToolIcon { iconId: "toolbar-search"; onClicked: {pageStack.clear(); pageStack.push(searchPage)} }
    //        ToolIcon { iconId: "toolbar-callhistory"; onClicked: {pageStack.clear(); pageStack.push(routePage)} }
    //        ToolIcon { platformIconId: "toolbar-view-menu";
    //            anchors.right: parent===undefined ? undefined : parent.right
    //            onClicked: (myMenu.status == DialogStatus.Closed) ? myMenu.open() : myMenu.close()
    //        }
    //    }

    ToolBarLayout {
        id: commonTools
        ToolIcon {
            iconId: "toolbar-back-dimmed";
            onClicked: {
                if(tabGroup.currentTab == tab1 || tabGroup.currentTab == tab2) {
                    tabGroup.currentTab.pop()
                } else {
                    console.log("Not PageStack, so not popping.")
                }
            }
        }
        ButtonRow {
            platformStyle: TabButtonStyle { }
            TabButton {
                iconSource: "image://theme/icon-m-toolbar-search-white"
                onClicked: {pageStack.clear(); pageStack.push(searchPage)}
            }
            TabButton {
                iconSource: "image://theme/icon-m-toolbar-callhistory-white"
                onClicked: {pageStack.clear(); pageStack.push(routePage)}
            }
            TabButton {
                iconSource: "image://theme/icon-s-status-gps"
                onClicked: {pageStack.clear(); pageStack.push(positionPage)}

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
