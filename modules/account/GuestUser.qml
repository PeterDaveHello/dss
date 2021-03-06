import QtQuick 2.1
import Deepin.Widgets 1.0

Column {
    id: root
    property int leftPadding
    property int rightPadding
    property int nameLeftPadding
    property bool expanded: expand_button.up
    
    Rectangle {
        id: guest_user
        color: dconstants.contentBgColor
        width: 310
        height: 100

        DRoundImage {
            id: round_image
            roundRadius: 30
            imageSource: "/var/lib/AccountsService/icons/guest.jpg"

            anchors.left: parent.left
            anchors.leftMargin: root.leftPadding + 40 - roundRadius
            anchors.verticalCenter: parent.verticalCenter
        }

        Column {
            spacing: 2

            DssH2 {
                id: user_name_text
                text: dsTr("Guest")
                color: dconstants.fgColor
                font.pixelSize: 14
            }

            DssH3 {
                text: ""
                color: dconstants.fgColor
                font.pixelSize: 10
            }

            anchors.left: parent.left
            anchors.leftMargin: root.nameLeftPadding
            anchors.verticalCenter: parent.verticalCenter
        }

        ExpandButton {
            id: expand_button

            up: false
            status: "normal"

            anchors.right: parent.right
            anchors.rightMargin: root.rightPadding
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            hoverEnabled: true
            anchors.fill: parent

            onEntered: {
                user_name_text.color = dconstants.hoverColor
                expand_button.status = "hover"
            }
            onExited: {
                user_name_text.color = dconstants.fgColor
                expand_button.status = "normal"
            }

            onClicked: {
                expand_button.up = !expand_button.up
                guest_settings.visible = expand_button.up
            }
        }
    }

    DSeparatorHorizontal { visible: guest_settings.visible }

    Column {
        id: guest_settings
        width: 310
        visible: false

        Rectangle {
            id: account_enabled_switch
            width: parent.width
            height: 38
            color: dconstants.contentBgColor

            DLabel {
                text: dsTr("Enable User")
                font.pixelSize: 12

                anchors.left: parent.left
                anchors.leftMargin: 40
                anchors.verticalCenter: parent.verticalCenter
            }

            DSwitchButton {
                checked: dbus_accounts.allowGuest

                onClicked: {
                    if (checkPolkitAuth()) {
                        dbus_accounts.AllowGuestAccount(checked)
                    } else {
                        checked = Qt.binding(function () {return dbus_accounts.allowGuest})
                    }
                }

                anchors.right: parent.right
                anchors.rightMargin: 15
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
