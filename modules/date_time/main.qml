import QtQuick 2.2
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0
import Deepin.Widgets 1.0
import DBus.Com.Deepin.Daemon.DateAndTime 1.0
import "calendar_core.js" as CalendarCore

Item {
    id: dateTimeModule
    anchors.fill: parent

    FontLoader { id: fixedFont; source: "MavenProLight-200.otf" }
    property var gDate: DateAndTime {
        onCurrentTimezoneChanged: {
            Date.timeZoneUpdated()
            globalDate = new Date()
        }
    }
    property var dconstants: DConstants {}
    property string lang: 'en'
    property var locale: Qt.locale()

    property var globalDate: new Date()
    
    Component.onCompleted: {
        lang = dsslocale.lang
    }

    Timer {
        running: true
        repeat: true
        interval: 500
        onTriggered: { 
            dateTimeModule.globalDate= new Date()
        }
    }

    Column {
        id: beforeTimeZoneArea
        anchors.top: parent.top
        width: parent.width
        height: childrenRect.height

        DssTitle { text: dsTr("Date & Time") }

        DSeparatorHorizontal {}

        TimeBox {
            use24Hour: twentyFourHourSetBox.active
            editable: !gDate.autoSetTime
        }

        DSeparatorHorizontal {}

        DSwitchButtonHeader {
            id: autoSetTimeBox
            text: dsTr("Auto-sync datetime")
            width: parent.width
            active: gDate.autoSetTime

            onClicked: {
                gDate.autoSetTime = active
            }
        }

        DSeparatorHorizontal {}

        DSwitchButtonHeader {
            id: twentyFourHourSetBox
            text: dsTr("24 Hour")
            active: gDate.use24HourDisplay

            onClicked: {
                gDate.use24HourDisplay = active
            }
        }

        DSeparatorHorizontal {}
    }

    TimezoneArea {
        id: timeZoneArea
        anchors.top: beforeTimeZoneArea.bottom
        listAreaMaxHeight: parent.height - beforeTimeZoneArea.height - afterTimeZoneArea.height - 32
    }

    Column {
        id: afterTimeZoneArea
        anchors.top: timeZoneArea.bottom

        DSeparatorHorizontal {}

        DBaseLine {
            id: dateBoxTitle
            width: parent.width
            rightMargin: 10

            leftLoader.sourceComponent: DLabel {
                font.pixelSize: 13
                text: dsTr("Date")
            }

            rightLoader.sourceComponent: DTextButton {
                text: dsTr("Change Date")
                visible: opacity != 0
                opacity: calendarObj.isToday ? 0 : 1

                Behavior on opacity {
                    PropertyAnimation { duration: 200 }
                }

                onClicked: {
                    gDate.SetDate(CalendarCore.dateToString(calendarObj.clickedDateObject))
                }
            }
        }

        DSeparatorHorizontal {}

        Calendar { 
            id: calendarObj 
        }

        DSeparatorHorizontal {}

        DSwitchButtonHeader {
            text: dsTr("假期安排提示")
            onClicked: {
            }
        }
        DSeparatorHorizontal {}
    }
}
