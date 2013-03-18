# Add more folders to ship with the application, here
folder_01.source = qml/journeyplanner
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

#QT+= declarative
symbian:TARGET.UID3 = 0xE607C744

DEFINES += QMLJSDEBUGGER

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

# Allow network access on Symbian
symbian:TARGET.CAPABILITY += NetworkServices

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
CONFIG += qdeclarative-boostable

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    settings.cpp


OTHER_FILES += \
    trafikanten.desktop \
    trafikanten.svg \
    trafikanten.png \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/manifest.aegis \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/manifest.aegis \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog

RESOURCES += \
    resources.qrc

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

HEADERS += \
    settings.h

DEFINES += OS_UBUNTU

OTHER_FILES += \
    qml/journeyplanner/ubuntu/TravelSearchPage.qml

OTHER_FILES += \
    qml/journeyplanner/ubuntu/TravelPage.qml

OTHER_FILES += \
    qml/journeyplanner/ubuntu/RealtimeResultsPage.qml

OTHER_FILES += \
    qml/journeyplanner/ubuntu/SearchForm.qml

HEADERS += \
    mdatetimehelper.h

SOURCES += \
    mdatetimehelper.cpp
