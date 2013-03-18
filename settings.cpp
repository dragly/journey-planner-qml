#include "settings.h"

//#include <QSystemLocale>

Settings::Settings(QObject *parent) :
    QSettings("dragly", "JourneyPlanner", parent)
{
}

void Settings::setValue(QString key, QVariant value)
{
    QSettings::setValue(key, value);
}

QVariant Settings::value(QString key, QVariant defaultValue)
{
    return QSettings::value(key, defaultValue);
}
