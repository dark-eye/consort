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
import Ubuntu.Components 1.3
import QtQuick.Controls 2.2 as QC2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import Qt.labs.settings 1.0

import "./components"
import Consort 1.0

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'consort.darkeye'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

	MainSections {
		id:mainSections
		bottomHideEnabled:true
		z:1
		menuModel:[
			{
				text:i18n.tr("Settings"),
				iconName:"settings",
				pageUrl:"pages/SettingsPage.qml",
			},
			{
				text:i18n.tr("Info"),
				iconName:"info",
				pageUrl:"pages/InfoPage.qml",
			},
		]

		model:[
			{
				text:i18n.tr("Settings"),
				iconName:"settings",
				pageUrl:"pages/SettingsPage.qml",
			},
			{
				text:i18n.tr("Info"),
				iconName:"info",
				pageUrl:"pages/InfoPage.qml",

			},
		]
		layer {
			enabled:!mainSections.isBottom
			effect:DropShadow {
				transparentBorder:true
				radius:7
			}
		}

		onMenuClicked: {
			console.log(itemData)
				if(itemData) {
					mainAdaptiveLayout.addPageToNextColumn(mainPage,Qt.resolvedUrl(itemData) );
				}
		}
		onSectionClicked: {
			console.log(itemData)
			if(itemData) {
				mainAdaptiveLayout.addPageToCurrentColumn(mainPage,Qt.resolvedUrl(itemData) );
			}
		}
	}

	AdaptivePageLayout {
		id:mainAdaptiveLayout
		anchors.leftMargin: mainSections.isBottom ? 0 : mainSections.width + mainSections.anchors.leftMargin
		anchors.fill:parent
 		layouts: [
			PageColumnsLayout {
				when: width > units.gu(90) && mainAdaptiveLayout.columns > 1
				PageColumn {
					fillWidth: true
				}
				PageColumn {
                    minimumWidth: units.gu(0)
                    maximumWidth: units.gu(60)
                    preferredWidth: units.gu(40)
				}
			},
			PageColumnsLayout {
				when:  width <= units.gu(90)
				PageColumn {
					fillWidth: true
				}
			},
			PageColumnsLayout {
				when: true
				PageColumn {
					fillWidth: true
				}
				PageColumn {
                    maximumWidth: units.gu(0)
                    preferredWidth: units.gu(00)
				}
			}
		]
		asynchronous:true
		primaryPage: Page {
			id:mainPage
			anchors.fill: parent

			header: PageHeader {
				id: header
				title: i18n.tr('Consort')
			}

			Item {
				anchors {
					top: header.bottom
					bottom: parent.bottom
					left: parent.left
					right: parent.right
				}

				Label {
					anchors.centerIn: parent
					text: i18n.tr('Hello World!')
				}
			}
		}
	}

    Component.onCompleted: Consort.speak()
}
