/*
 * Copyright 2013 Svenn-Arne Dragly
 *
 * This program is licensed under the terms and conditions of the
 * GPL, version 3 or later.  The full text of the GPL Licence is at
 * http://www.gnu.org/licenses/gpl.html
 *
 * Some functions are (C) Intel Corporation under the LGPL license.
 *
 */

var dateTime = new Date();

function currentYear() {
    return dateTime.getFullYear();
}

function daysInMonth(mm, yyyy) {
    return 32 - new Date(yyyy, mm, 32).getDate();
}
