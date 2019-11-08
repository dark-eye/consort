/*
 * Copyright (C) 2019  Eran "DarkEye" Uzan
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * ubuntu-calculator-app is distributed in the hope that it will be useful,
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
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import Qt.labs.settings 1.0

import "./components"
import Consort 1.0

Kirigami.ApplicationWindow  {
    id: root
    objectName: 'mainView'
//     applicationName: 'consort.darkeye'

    width: helperFunctions.pxToGrid(45)
    height: helperFunctions.pxToGrid(75)

    
//     header: Kirigami.ApplicationHeader {}
    
    Settings {
        id:appSettings
        property var currentInstance
        property var instances
    }
    
    
	MainSections {
		id:mainSections
		bottomHideEnabled:false
		z:1
		menuModel:[
			{
				text:"Settings",
				iconName:"settings",
				pageUrl:"pages/SettingsPage.qml",
			},
			{
				text:"Info",
				iconName:"info",
				pageUrl:"pages/InfoPage.qml",
			},
		]

		model:[
			{
				text:"Settings",
				iconName:"settings",
				pageUrl:"pages/SettingsPage.qml",
			},
			{
				text:"Info",
				iconName:"info",
				pageUrl:"pages/InfoPage.qml",

			},
            {
// 				text:"Main Page",
				iconName:"external-link",
				pageUrl:"pages/MainPage.qml",

			},
		]
		layer {
			enabled:!(mainSections.isBottom && mainSections.bottomHideEnabled)
			effect:DropShadow {
				transparentBorder:true
				radius:5
			}
		}

		onMenuClicked: {
            if(itemData) {
                pageStack.push( Qt.resolvedUrl(itemData.pageUrl) );
            }
		}
		onSectionClicked: {
			if(itemData) {
				pageStack.push(Qt.resolvedUrl(itemData.pageUrl) );
                mainSections.currentSection = itemData.text
			}
		}
	}
	pageStack.initialPage: Qt.resolvedUrl("pages/MainPage.qml")
    
    QtObject { 
        id:helperFunctions
        
        function pxToGrid(px) {
            return Kirigami.Units.gridUnit * px;
        }
    }

    Component.onCompleted: Consort.speak()
}
