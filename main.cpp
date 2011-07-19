#include <QtGui/QApplication>
#include <QtDeclarative>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QDeclarativeView view;
    view.setSource(QUrl("qrc:/qml/main.qml"));
#ifdef Q_OS_LINUX
    view.show();
#else
    view.showFullScreen();
#endif
    return app.exec();
}
