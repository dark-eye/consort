/*
 * <one line to give the program's name and a brief idea of what it does.>
 * Copyright (C) 2019  eran <email>
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import org.kde.kirigami 2.4 as Kirigami
import QtQuick.Controls 2.2 as QC2

Kirigami.AboutPage {

	aboutData: {
        "displayName" : "KirigamiApp",
        "productName" : "kirigami/app",
        "componentName" : "kirigamiapp",
        "shortDescription" : "A Kirigami example",
        "homepage" : "",
        "bugAddress" : "submit@bugs.kde.org",
        "version" : "5.14.80",
        "otherText" : "",
        "authors" : [
            {
                "name" : "...",
                "task" : "",
                "emailAddress" : "somebody@kde.org",
                "webAddress" : "",
                "ocsUsername" : ""
            }
        ],
        "credits" : [],
        "translators" : [],
        "licenses" : [
            {
                "name" : "GPL v2",
                "text" : "long, boring, license text",
                "spdx" : "GPL-2.0"
            }
        ],
        "copyrightStatement" : "© 2010-2018 Plasma Development Team",
        "desktopFileName" : "org.kde.kirigamiapp"
    }

	QC2.Label {
		anchors.centerIn: parent
		text: i18n.tr('Info Page')
	}
}
