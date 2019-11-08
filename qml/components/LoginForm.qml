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
import QtQuick.Controls 2.2 as QC2

Item {
    Column {
        id:loginFormFields
        Column {            
            QC2.Label {
                text:i18n.tr("User name / Email")
            }
            TextInput {
                id:userInput
            }
        }
        Column {
            QC2.Label {
                text:i18n.tr("Password")
            }
            TextInput {
                id:passInput
                echoMode:TextInput.Password 
            }
        }
        Column {
            QC2.Button {
                text:i18n.tr("Login")
            }
            //TODO add registeration
        }
   }    
}
