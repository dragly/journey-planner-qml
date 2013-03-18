//#include <QtGui/QApplication>
//#include <QtDeclarative>
#include "settings.h"
#include "mdatetimehelper.h"
#include <QtQml/qqml.h>
#include <QtGui/QGuiApplication>
#include <QScopedPointer>
#include "qtquick2applicationviewer.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    qmlRegisterType<Settings>("org.dragly", 1, 0, "Settings");
    qmlRegisterType<MDateTimeHelper>("org.dragly", 1, 0, "DateTime");

    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;
//    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
#ifdef OS_UBUNTU
    viewer.setMainQmlFile(QLatin1String("qml/journeyplanner/ubuntu/main.qml"));
#else
    viewer.setMainQmlFile(QLatin1String("qml/journeyplanner/main.qml"));
#endif
    viewer.showExpanded();

    return app.exec();
}
