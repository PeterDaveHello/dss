import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import Deepin.Widgets 1.0

Column {
    width: parent.width

    DBaseLine {
        MouseArea{
            z:-1
            anchors.fill:parent
            onClicked: {
                print("***********")
                print("Device:", dev[0])
                print("AccessPoint:", accessPoints[index][3])
                print("***********")
                nm.ActiveAccessPoint(dev[0], accessPoints[index][3])
            }
        }
        color: dconstants.contentBgColor

        leftLoader.sourceComponent: Row {
            height: childrenRect.height
            anchors.verticalCenter: parent.verticalCenter
            spacing: 4

            DImageButton {
                visible: accessPoints[index][4]
                normal_image: "img/check_1.png"
                hover_image: "img/check_2.png"
                onClicked: {
                    print("Try disconnect", dev[0])
                    nm.DisconnectDevice(dev[0])
                }
            }

            DLabel {
                verticalAlignment: Text.AlignVCenter
                text: accessPoints[index][0]
            }
        }

        rightLoader.sourceComponent: Row {
            height: childrenRect.height
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8

            Image {
                source: {
                    var power=  accessPoints[index][2]
                    var secure = accessPoints[index][1] ? "-secure": ""
                    if (power <= 5)
                        return "img/ap-signal-0" + secure + ".svg"
                    else if (power <= 25)
                        return "img/ap-signal-25" + secure + ".svg"
                    else if (power <= 50)
                        return "img/ap-signal-50" + secure + ".svg"
                    else if (power <= 75)
                        return "img/ap-signal-75" + secure + ".svg"
                    else if (power <= 100)
                        return "img/ap-signal-100" + secure + ".svg"
                }
            }

            DArrowButton {
                onClicked: {
                    stackView.push({
                        "item": Qt.resolvedUrl("WirelessProperties.qml"),
                        "properties": { "accessPoint": accessPoints[index]},
                        "destroyOnPop": true
                    })
                }
            }
        }
    }

    DBaseLine {
        id:password
        property string conn
        visible: false
        leftLoader.sourceComponent: DLabel {
            text: dsTr("PassWord")
        }
        rightLoader.sourceComponent: TextField {
            width: 200
            onAccepted: {
                print("Try Active...")
                visible= false
                nm.SetKey(password.conn,  text)
            }
        }

        Connections {
            target: nm
            onNeedSecrets: {
                //password.conn = nm.GetConnectionByAccessPoint(accessPoints[index][3])[1]
                //if (password.conn == arg0) {
                    //password.visible = true
                    //print("HAHAHAHAHAHAH", parent)
                //} else {
                    //print("HandleNeedMoreConfigure:", arg0, arg1, password.conn)
                //}
            }
        }
    }

    DSeparatorHorizontal{}
}