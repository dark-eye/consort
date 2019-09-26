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
import Ubuntu.Components 1.3
import QtQuick.Controls 2.2 as QC2

ListView {
		id:_sectionsList

		signal itemClicked(string itemData)

		property bool vertical: true
		property bool hidden: false


		spacing:units.gu(0.5)
		boundsBehavior:Flickable.StopAtBounds
		orientation:  vertical ? ListView.Vertical : ListView.Horizontal

		delegate:QC2.ToolButton {
				id:sectionsItem
				anchors.margins:units.gu(0.5)
				clip:true
				states:[
					State {
						name:"left_hidden"
						when: vertical && hidden
						extend: "left"
						PropertyChanges { target: sectionsItemIcon; anchors.left:undefined}
						PropertyChanges { target: sectionsItemIcon; anchors.right:sectionsItem.right}
					},
					State {
						name:"left"
						when: vertical && !hidden
						PropertyChanges { target: sectionsItem; width:_sectionsList.width }
						PropertyChanges { target: sectionsItem; height:_sectionsList.height / model.length  }
						PropertyChanges { target: sectionsItemIcon; anchors.top:undefined }
						PropertyChanges { target: sectionsItemIcon; anchors.horizontalCenter:undefined}
						PropertyChanges { target: sectionsItemIcon; anchors.right:undefined}
						PropertyChanges { target: sectionsItemIcon; anchors.left:sectionsItem.left}
						PropertyChanges { target: sectionsItemIcon; anchors.verticalCenter:sectionsItem.verticalCenter}
						PropertyChanges { target: sectionsItemLabel; anchors.horizontalCenter:undefined}
						PropertyChanges { target: sectionsItemLabel; anchors.top:undefined}
						PropertyChanges { target: sectionsItemLabel; anchors.verticalCenter:sectionsItem.verticalCenter}
						PropertyChanges { target: sectionsItemLabel; anchors.left:sectionsItemIcon.right}
						PropertyChanges { target: sectionsItemLabel; anchors.leftMargin:sectionsItemIcon.width + sectionsItemIcon.anchors.margins}

					},
					State {
						name:"bottom"
						when: !vertical
						PropertyChanges { target: sectionsItem; width:_sectionsList.width / 2  }
						PropertyChanges { target: sectionsItem; height:_sectionsList.height }
						PropertyChanges { target: sectionsItemIcon; anchors.left:undefined}
						PropertyChanges { target: sectionsItemIcon; anchors.top:sectionsItem.top }
						PropertyChanges { target: sectionsItemIcon; anchors.horizontalCenter:sectionsItem.horizontalCenter}
						PropertyChanges { target: sectionsItemLabel; anchors.verticalCenter:undefined}
						PropertyChanges { target: sectionsItemLabel; anchors.right:undefined}
						PropertyChanges { target: sectionsItemLabel; anchors.horizontalCenter:sectionsItem.horizontalCenter}
						PropertyChanges { target: sectionsItemLabel; anchors.top:sectionsItemIcon.bottom}

					}
				]
				Label {
					id:sectionsItemLabel
					anchors.margins:units.gu(0.5)
					visible: !hidden && vertical || sectionsItem.width - sectionsItemIcon.width >= units.dp(12) * text.length
					text: modelData.text
				}
				Icon {
					id:sectionsItemIcon
					anchors.margins:units.gu(0.75)
					width:Math.min(units.gu(2.5),sectionsItem.width,sectionsItem.height)
					height:width
					name: modelData.iconName ? modelData.iconName : ""
				}

				onClicked: {
					_sectionsList.itemClicked(modelData.pageUrl)
				}
			}
	}
