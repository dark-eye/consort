/*
 * <one line to give the program's name and a brief idea of what it does.>
 * Copyright (C) 2019  Eran <darkeye@librem.one>
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
import org.kde.kirigami 2.5 as Kirigami
import QtQuick.Controls 2.2 as QC2
QC2.ToolButton {
    id:sectionsItem
    anchors.margins:helperFunctions.pxToGrid(0.5)
    
    property bool vertical:true
    property bool hidden: false
    property int maxItemHeight:helperFunctions.pxToGrid(10)
    property int maxItemWidth:helperFunctions.pxToGrid(25)
    property var parentList: null
    
    clip:true
//     transitions: Transition  { AnchorAnimation {duration:100} }
    states:[
        State {
            name:"left_hidden"
            when: vertical && hidden
            extend: "left"
            PropertyChanges { target: sectionsItemIcon; anchors.left:undefined}
            PropertyChanges { target: sectionsItemIcon; anchors.right:sectionsItem.right}
            PropertyChanges { target: sectionsItemLabel; visible:false}
        },
        State {
            name:"left"
            when: vertical && !hidden
            PropertyChanges { target: sectionsItem; width:Math.min(parentList.width,maxItemWidth) }
            PropertyChanges { target: sectionsItem; height:Math.min(parentList.height / parentList.model.length ,maxItemHeight) }
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
            PropertyChanges { target: sectionsItemLabel; visible:true}

        },
        State {
            name:"bottom_no_text"
            when: !vertical && !( sectionsItem.width  >= units.dp(9) * sectionsItemLabel.text.length)
            extend:"bottom"
            PropertyChanges { target: sectionsItemIcon; anchors.top:undefined }
            PropertyChanges { target: sectionsItemIcon; anchors.verticalCenter:sectionsItem.verticalCenter}
            PropertyChanges { target: sectionsItemLabel; visible:false}

        },
        State {
            name:"bottom"
            when: !vertical
            PropertyChanges { target: sectionsItem; width:Math.min(parentList.width / parentList.model.length, maxItemWidth)  }
            PropertyChanges { target: sectionsItem; height:Math.min(parentList.height, maxItemHeight) }
            PropertyChanges { target: sectionsItemIcon; anchors.left:undefined}
            PropertyChanges { target: sectionsItemIcon; anchors.verticalCenter:undefined}
            PropertyChanges { target: sectionsItemIcon; anchors.top:sectionsItem.top }
            PropertyChanges { target: sectionsItemIcon; anchors.horizontalCenter:sectionsItem.horizontalCenter}
            PropertyChanges { target: sectionsItemLabel; anchors.verticalCenter:undefined}
            PropertyChanges { target: sectionsItemLabel; anchors.right:undefined}
            PropertyChanges { target: sectionsItemLabel; anchors.horizontalCenter:sectionsItem.horizontalCenter}
            PropertyChanges { target: sectionsItemLabel; anchors.top:sectionsItemIcon.bottom}
            PropertyChanges { target: sectionsItemLabel; visible:true}

        }
    ]
    
    Kirigami.Icon {
        id:sectionsItemIcon
        anchors.top:sectionsItem.top
        anchors.margins:helperFunctions.pxToGrid(0.75)
        width:Math.min(helperFunctions.pxToGrid(2.5),sectionsItem.width,sectionsItem.height)
        height:width
        source: modelData.iconName  ? "image://theme/%1".arg( modelData.iconName ) : ""
        color:"white"
        transitions: Transition  { AnchorAnimation {duration:2000} }
    }
    
    QC2.Label {
        id:sectionsItemLabel
        anchors.margins:helperFunctions.pxToGrid(0.5)
        text: modelData.text
    }
}
