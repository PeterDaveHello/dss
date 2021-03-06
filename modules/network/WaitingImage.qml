import QtQuick 2.0

Image {
    id: container
    property bool on: false

    visible: container.on
    source: "images/waiting.svg";
    NumberAnimation on rotation {
        running: container.on;
        from: 0;
        to: 360;
        loops: Animation.Infinite;
        duration: 800
    }
}
