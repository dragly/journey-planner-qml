/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components project.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
** $QT_END_LICENSE$
**
****************************************************************************/

#ifndef MDATETIMEHELPER_H
#define MDATETIMEHELPER_H

#include <QObject>
#include <QtQuick>

class MDateTimeHelper : public QObject
{
    Q_OBJECT
    Q_ENUMS(TimeUnit HourMode)

public:
    explicit MDateTimeHelper(QObject *parent = 0);
    virtual ~MDateTimeHelper();

    Q_INVOKABLE static QString shortMonthName(int month);
    Q_INVOKABLE static bool isLeapYear(int year);
    Q_INVOKABLE static int daysInMonth(int year, int month);
    Q_INVOKABLE static int currentYear();
    Q_INVOKABLE static QString amText();
    Q_INVOKABLE static QString pmText();
    Q_INVOKABLE static int hourMode();

    enum TimeUnit {
        Hours = 1,
        Minutes = 2,
        Seconds = 4,
        All = 7
    };

    enum HourMode {
        TwelveHours = 1,
        TwentyFourHours = 2
    };

private:
    Q_DISABLE_COPY(MDateTimeHelper)
};

QML_DECLARE_TYPE(MDateTimeHelper)
#endif // MDATETIMEHELPER_H
