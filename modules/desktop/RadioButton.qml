import QtQuick 2.1
import QtGraphicalEffects 1.0

Rectangle {
    id: select_button
    radius: 3
    width: listview.width
    height: listview.height + 1
    color: Qt.rgba(0, 0, 0, 0)

    property int fontSize: 12
    property int leftRightPadding: 10
    property int buttonHeight: 22

    property color selectedMaskColor: Qt.rgba(1, 1, 1, 0.3)
    property color selectedFontColor: "#19A9F9"
    property color unselectedFontColor: Qt.rgba(1, 1, 1, 1)

    property var buttonModels: []
	
    Rectangle {
        id: bg
        radius: 3
        clip: true
        width: listview.width
        height: listview.height
        color: "#1B1B1B"

        border.width: 1
        border.color: Qt.rgba(0, 0, 0, 0.7)

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#191919"}
            GradientStop { position: 0.2; color: "#1e1e1e"}
            GradientStop { position: 1.0; color: "#1e1e1e"}
        }

        anchors.top: parent.top
    }

    DropShadow {
        anchors.fill: bg
        radius: 1
        samples: 16
        horizontalOffset: 0
        verticalOffset: 1
        color: Qt.rgba(1, 1, 1, 0.15)
        source: bg
    }
	
    InnerShadow {
        anchors.fill: bg
        radius: 2
        samples: 16
        horizontalOffset: -2
        verticalOffset: -2
        color: Qt.rgba(0, 0, 0, 0.3)
        source: bg
    }
	
    ListView {
        id: listview
        focus: true
        orientation: ListView.Horizontal

        property alias buttonModels: select_button.buttonModels

        property alias fontSize: select_button.fontSize
        property alias leftRightPadding: select_button.leftRightPadding
        property alias buttonHeight: select_button.buttonHeight

        property alias selectedMaskColor: select_button.selectedMaskColor
        property alias selectedFontColor: select_button.selectedFontColor
        property alias unselectedFontColor: select_button.unselectedFontColor

        model: ListModel {
            Component.onCompleted: {
                for (var i = 0; i < listview.buttonModels.length; i++) {
                    append(listview.buttonModels[i])
                }
            }
        }

        delegate: RadioButtonDelegate {}

        highlight: RadioButtonHighlight {}

        signal itemSelected (int idx)

        onCurrentIndexChanged: {
            itemSelected(currentIndex)
        }

        onWidthChanged: {
            select_button.width = width
        }
        onHeightChanged: {
            select_button.height = height + 1
        }

        anchors.top: parent.top
    }
}