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

import "./MainPane/"

Item {
	id:_mainSections


	signal sectionClicked(var itemData)
	signal menuClicked(var itemData)

	property int minimumLeftPanelWidth: helperFunctions.pxToGrid(40)
	property int hiddenSize: helperFunctions.pxToGrid(4)
	property int bottomHeight: helperFunctions.pxToGrid(8)
	property int leftWidth: helperFunctions.pxToGrid(20)
	property bool hidden:false
	property bool bottomHideEnabled:false

	property bool isBottom:false

	property alias menuModel:_menuList.model
	property alias model:_sectionsList.model
	property alias sectionsListView:_sectionsList
	property alias hideShowBtn:_hideShowBtn
	
    property var currentSection: null



	states:[
		State {
			name:"hidden_anchors_left"
			when: parent.width > parent.height && hidden && parent.width > minimumLeftPanelWidth
			extend:"anchors_left"
			PropertyChanges { target: _mainSections; anchors.leftMargin:-(width-hiddenSize) }
		},
		State {
			name:"hidden_anchors_bottom"
			when: (parent.width < parent.height || parent.width <= minimumLeftPanelWidth) && hidden && bottomHideEnabled
			extend:"anchors_bottom"
			PropertyChanges { target: _mainSections; anchors.bottomMargin:-(height) }
		},
		State {
			when:parent.width < parent.height || parent.width <= minimumLeftPanelWidth
			name:"anchors_bottom"
			PropertyChanges { target: _mainSections; anchors.bottom:parent.bottom }
			PropertyChanges { target: _mainSections; anchors.left:parent.left }
			PropertyChanges { target: _mainSections; anchors.right:parent.right }
			PropertyChanges { target: _mainSections; anchors.top:undefined }
			PropertyChanges { target: _mainSections; height:bottomHeight }
			PropertyChanges { target: _mainSections; isBottom:true }

		},
		State {
			name:"anchors_left"
			when:parent.width > parent.height && parent.width > minimumLeftPanelWidth
			PropertyChanges { target: _mainSections; anchors.left:parent.left  }
			PropertyChanges { target: _mainSections; anchors.bottom:undefined }
			PropertyChanges { target: _mainSections; anchors.top:parent.top }
			PropertyChanges { target: _mainSections; anchors.right:undefined }
			PropertyChanges { target: _mainSections; height:parent.height }
			PropertyChanges { target: _mainSections; width:leftWidth }
			PropertyChanges { target: _mainSections; isBottom:false }
		}
	]

	Behavior on anchors.leftMargin { NumberAnimation {} }
	Behavior on anchors.bottomMargin { NumberAnimation {} }
	Behavior on width { NumberAnimation { duration:100} }


	Rectangle {
		id:_bkgRect
		anchors.fill:parent
		color:Kirigami.Theme.backgroundColor
	}


	MainPaneListView {
		id:_sectionsList
		anchors.fill:parent
		anchors.topMargin: isBottom ? helperFunctions.pxToGrid(0.1) : _menuListWrapper.height + _menuListWrapper.anchors.bottomMargin
		anchors.leftMargin: isBottom ? _menuListWrapper.width + _menuListWrapper.anchors.rightMargin : 0
		
		orientation:  _mainSections.state == 'anchors_left' || _mainSections.state == 'hidden_anchors_left' ? ListView.Vertical : ListView.Horizontal
		hidden:_mainSections.hidden

		delegate:MainPaneListItem {
                vertical: _sectionsList.orientation == ListView.Vertical
                hidden: _sectionsList.hidden
                parentList:_sectionsList
                highlighted : currentSection == modelData.text
                 
                onClicked: {
                    parentList.itemClicked(modelData)
                }
        }
		
		onItemClicked:{
			_mainSections.sectionClicked(itemData)
		}
	}

	Item {
		id:_menuListWrapper
		anchors.top:parent.top
		anchors.margins:helperFunctions.pxToGrid(0.25)
		states:[
			State {
				name:"left"
				when: (_mainSections.state == 'anchors_left' || _mainSections.state == 'hidden_anchors_left')
				PropertyChanges { target: _menuListWrapper; anchors.bottom:undefined }
				PropertyChanges { target: _menuListWrapper; anchors.topMargin:0}
				PropertyChanges { target: _menuListWrapper; anchors.bottomMargin:helperFunctions.pxToGrid(2)}
				PropertyChanges { target: _menuListWrapper; anchors.rightMargin:helperFunctions.pxToGrid(8) }
				PropertyChanges { target: _menuListWrapper; anchors.left:_bkgRect.left }
				PropertyChanges { target: _menuListWrapper; anchors.right:_hideShowBtn.left }
				PropertyChanges { target: _menuListWrapper; height: _hideShowBtn.height}

			},
			State {
				name:"bottom"
				when: !(_mainSections.state == 'anchors_left' || _mainSections.state == 'hidden_anchors_left')
				PropertyChanges { target: _menuListWrapper; anchors.left:undefined }
				PropertyChanges { target: _menuListWrapper; anchors.right:undefined }
				PropertyChanges { target: _menuListWrapper; anchors.rightMargin:helperFunctions.pxToGrid(2) }
				PropertyChanges { target: _menuListWrapper; height: _bkgRect.height - helperFunctions.pxToGrid(2) }
				PropertyChanges { target: _menuListWrapper; width: helperFunctions.pxToGrid(4) }

			}
		]
		MainPaneListView {
			id:_menuList
			anchors.fill:parent
			orientation: !(_mainSections.state == 'anchors_left' || _mainSections.state == 'hidden_anchors_left') ? 
                                ListView.Vertical : 
                                ListView.Horizontal

			onItemClicked:{
				_mainSections.menuClicked(itemData)
			}

		}
	}

	QC2.ToolButton {
		id:_hideShowBtn
		anchors.top: parent.top
		visible:state == "left" || bottomHideEnabled
		property alias icon:_icon
		anchors.topMargin: state == "bottom" ?  -height : 0;

		states:[
			State {
				name:"left"
				when: _mainSections.state == 'anchors_left' || _mainSections.state == 'hidden_anchors_left'
				PropertyChanges { target: _hideShowBtn; anchors.horizontalCenter:undefined }
				PropertyChanges { target: _hideShowBtn; anchors.right:_mainSections.right }
				PropertyChanges { target: _hideShowBtn; width: hidden ? hiddenSize : helperFunctions.pxToGrid(4) }
				PropertyChanges { target: _hideShowBtn; height:helperFunctions.pxToGrid(4) }
				PropertyChanges { target: _hideShowBtn; icon.source:hidden ? "image://theme/contextual-menu" : "image://theme/back" }

			},
			State {
				name:"bottom"
				when: _mainSections.state == 'anchors_bottom' || _mainSections.state == 'hidden_anchors_bottom'
				PropertyChanges { target: _hideShowBtn; anchors.right:undefined }
				PropertyChanges { target: _hideShowBtn; anchors.horizontalCenter:_mainSections.horizontalCenter }
				PropertyChanges { target: _hideShowBtn; width: helperFunctions.pxToGrid(8) }
				PropertyChanges { target: _hideShowBtn; height:hiddenSize/2 }
				PropertyChanges { target: _hideShowBtn; icon.source:hidden ? "image://theme/up" : "image://theme/down" }
			}
		]


		Behavior on height { NumberAnimation {} }
		Behavior on width { NumberAnimation {} }

		Kirigami.Icon {
			id:_icon
			anchors.centerIn:parent
			width:helperFunctions.pxToGrid(2)
			height:width
		}

		onClicked: { hidden = !hidden }
	}
}

