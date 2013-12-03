import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

Rectangle {
    property string text: "untitled"
    signal toggled
    id: header
    width: parent.width
    height: 32 
    color: bgColor
    ColumnLayout {
	width: parent.width
	anchors.verticalCenter: header.verticalCenter
	RowLayout {
	    anchors.left:parent.left
	    anchors.leftMargin: 10
	    spacing: parent.width - label.width - toggle_.width - anchors.leftMargin
	    width: header.width
	    Label {
		id:label
		text: header.text
		color: fgColor
	    }
	    DSwitcherButton {
		id: toggle_
		onClicked: {
		    toggled()
		}
	    }
	}
    }
}