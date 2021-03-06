import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import Deepin.Widgets 1.0

Column{
    id: wiredDevicesItem
    width: parent.width
    height: childrenRect.height

    property int wiredDevicesSignal: dbusNetwork.wiredDevices[index][1]

    function activateThisConnection(){
        dbusNetwork.ActivateConnection(dbusNetwork.wiredConnections[index], dbusNetwork.wiredDevices[index][0])
    }

    function goToEditConnection(){
        stackView.push({
            "item": stackViewPages["wiredPropertiesPage"],
            "properties": { "uuid": dbusNetwork.wiredConnections[index]},
            "destroyOnPop": true
        })
        stackView.currentItemId = "wiredPropertiesPage"
    }

    DBaseLine {
        id: wiredLine

        property bool hovered: false
        property bool selected: false
        color: dconstants.contentBgColor

        MouseArea{
            z:-1
            anchors.fill:parent
            hoverEnabled: true

            onEntered: {
                parent.hovered = true
            }

            onExited: {
                parent.hovered = false
            }

            onClicked: {
                if (wiredDevicesSignal == 100){
                    goToEditConnection()
                }
                else{
                    activateThisConnection()
                }
            }
        }

        leftLoader.sourceComponent: Row{
            height: parent.height
            spacing: 8

            DImageButton {
                anchors.verticalCenter: parent.verticalCenter
                normal_image: "img/check_1.png"
                hover_image: "img/check_2.png"
                visible: wiredDevicesSignal == 100
                onClicked: {
                    dbusNetwork.DeactivateConnection(dbusNetwork.wiredDevices[index][0])
                }

                Connections{
                    target: wiredDevicesItem
                    onWiredDevicesSignalChanged:{
                        parent.visible = (wiredDevicesSignal == 100)
                    }
                }
            }

            DLabel {
                anchors.verticalCenter: parent.verticalCenter
                text: dsTr("Wired Conection %1").arg(index+1)
                font.pixelSize: 12
                color: {
                    if(wiredLine.selected){
                        return dconstants.activeColor
                    }
                    else if(wiredLine.hovered){
                        return dconstants.hoverColor
                    }
                    else{
                        return dconstants.fgColor
                    }
                }
            }
        }

        rightLoader.sourceComponent: DArrowButton {
            onClicked: {
                goToEditConnection()
            }
        }
    }
    
    DSeparatorHorizontal{}
}
