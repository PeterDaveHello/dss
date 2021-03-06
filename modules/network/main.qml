import QtQuick 2.1
import QtQuick.Window 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import DBus.Com.Deepin.Daemon.Network 1.0
import Deepin.Widgets 1.0
import DGui 1.0

Column{
    id: networkModule
    anchors.fill: parent

    property var dbusNetwork: NetworkManager{}
    property var activeConnections: dbusNetwork.activeConnections

    signal needSecretsEmit(string path, string encryptionName, string accessPointName)

    property bool inPasswordInputting: false

    property bool inAllConnectionPage: stackView.depth == 1
    property var allConnectionPage: ListConnections {}

    property var stackViewPages: {
        "allConnectionPage": Qt.resolvedUrl("ListConnections.qml"),
        "infoPage": Qt.resolvedUrl("Info.qml"),
        "wirelessPropertiesPage": Qt.resolvedUrl("WirelessProperties.qml"),
        "wiredPropertiesPage": Qt.resolvedUrl("WiredProperties.qml")
    }

    function resetConnectionSession(){
        if(stackView.currentItemId == "wirelessPropertiesPage"){
            stackView.currentItem.connectionSessionObject.Close()
        }
    }

    Connections{
        target: rootWindow

        onModuleStartChange: {
            resetConnectionSession()
        }

        onPanelHided: {
            resetConnectionSession()
            stackView.reset()
        }
    }

    Component {
        id: connectionSession
        ConnectionSession {}
    }

    DssTitle {
        id:header
        height: 48
        text: dsTr("Network Settings")
        rightLoader.sourceComponent: Row {
            height: header.height
            spacing: 4

            DssAddButton{
                anchors.verticalCenter: parent.verticalCenter
            }

            DTextButton {
                text: "Info"
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    stackView.push(stackViewPages["infoPage"])
                    stackView.currentItemId = "infoPage"
                }
            }
        }
    }

    DSeparatorHorizontal{}

    StackView {
        id:stackView
        width: parent.width
        height: parent.height - header.height - 2
        property string currentItemId: ""

        function reset(){
            stackView.pop(null)
            stackView.currentItemId = "allConnectionPage"
        }

        Component.onCompleted: {
            stackView.push(stackViewPages["allConnectionPage"])
            stackView.currentItemId = "allConnectionPage"
        }
    }
}
