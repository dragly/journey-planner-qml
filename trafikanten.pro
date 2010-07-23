# -------------------------------------------------
# Project created by QtCreator 2010-05-29T13:11:08
# -------------------------------------------------
QT += core \
    gui \
    network \
    xml \
    maemo5
TARGET = trafikanten
TEMPLATE = app
TRANSLATIONS = trafikanten_nb_NO.ts
SOURCES += main.cpp \
    trafikantenwindow.cpp \
    departureswindow.cpp \
    travelsearchwindow.cpp \
    aboutdialog.cpp \
    searchdialog.cpp \
    travelinfodialog.cpp \
    recentwindow.cpp
HEADERS += trafikantenwindow.h \
    departureswindow.h \
    travelsearchwindow.h \
    common.h \
    aboutdialog.h \
    searchdialog.h \
    travelinfodialog.h \
    recentwindow.h
FORMS += trafikantenwindow.ui \
    departureswindow.ui \
    travelsearchwindow.ui \
    aboutdialog.ui \
    searchdialog.ui \
    travelinfodialog.ui \
    recentwindow.ui
RESOURCES += trafikanten.qrc
CONFIG += mobility
MOBILITY = location
symbian { 
    TARGET.UID3 = 0xe9d84f35
    
    # TARGET.CAPABILITY +=
    TARGET.EPOCSTACKSIZE = 0x14000
    TARGET.EPOCHEAPSIZE = 0x020000 \
        0x800000
}
unix { 
    # VARIABLES
    isEmpty(PREFIX):PREFIX = /usr
    BINDIR = $$PREFIX/bin
    DATADIR = $$PREFIX/share
    DEFINES += DATADIR=\"$$DATADIR\" \
        PKGDATADIR=\"$$PKGDATADIR\"
    
    # MAKE INSTALL
    INSTALLS += target \
        desktop \
        iconscalable \
        icon26 \
        icon48 \
        icon64 \
        backup \
        translation \
        locale
    target.path = $$BINDIR
    desktop.path = $$DATADIR/applications/hildon
    desktop.files += ../debian/hildon/applications/hildon/$${TARGET}.desktop
    iconscalable.path = $$DATADIR/icons/hicolor/scalable/apps
    iconscalable.files += ../debian/hildon/icons/hicolor/scalable/apps/$${TARGET}.png
    icon26.path = $$DATADIR/icons/hicolor/26x26/apps
    icon26.files += ../debian/hildon/icons/hicolor/26x26/apps/$${TARGET}.png
    icon48.path = $$DATADIR/icons/hicolor/48x48/apps
    icon48.files += ../debian/hildon/icons/hicolor/48x48/apps/$${TARGET}.png
    icon64.path = $$DATADIR/icons/hicolor/64x64/apps
    icon64.files += ../debian/hildon/icons/hicolor/scalable/apps/$${TARGET}.png
    backup.path = /etc/osso-backup/applications
    backup.files += ../debian/hildon/osso-backup/applications/$${TARGET}.conf
    translation.path = $$DATADIR/$${TARGET}/translations
    translation.files += $${TARGET}_*.qm
    locale.path = $$DATADIR/locale/no_NO/LC_MESSAGES/
    locale.files += ../debian/hildon/locale/no_NO/LC_MESSAGES/trafikanten.mo
}
OTHER_FILES +=  debian/control \
    debian/hildon/applications/hildon/trafikanten.desktop \
    debian/changelog
