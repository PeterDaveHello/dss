import QtQuick 2.0

Canvas {
    id: canvas
    width: 320
    height: 280
    antialiasing: true

    // need init
    property int radius: 4
    property int lineWidth: 0
    property real alpha: 1.0
    property int shadowWidth: 0
    property real arrowPosition: 0.9
    property int arrowWidth: 11
    property int arrowHeight: 6

    property bool fill: true
    property color fillStyle: "#b4b4b4"

    property bool stroke: true
    property color strokeStyle: "black"
    // need init

    property int rectx: shadowWidth + lineWidth
    property int rectWidth: width - 2*rectx
    property int recty: shadowWidth + 2 * lineWidth + arrowHeight
    property int rectHeight: height - rectx - recty

    onArrowPositionChanged:requestPaint();
    onFillChanged:requestPaint();
    onStrokeChanged:requestPaint();
    onRadiusChanged:requestPaint();

    onPaint: {
        var ctx = getContext("2d");
        ctx.save();
        ctx.clearRect(0,0,canvas.width, canvas.height);
        ctx.strokeStyle = canvas.strokeStyle;
        ctx.lineWidth = canvas.lineWidth
        ctx.fillStyle = canvas.fillStyle
        ctx.globalAlpha = canvas.alpha
        ctx.beginPath();
        ctx.moveTo(rectx+radius,recty);                 // top side
        //draw top arrow
        ctx.lineTo(rectx+arrowPosition*rectWidth-arrowWidth/2, recty);
        ctx.lineTo(rectx+arrowPosition*rectWidth, recty-arrowHeight);
        ctx.lineTo(rectx+arrowPosition*rectWidth+arrowWidth/2, recty);

        ctx.lineTo(rectx+rectWidth-radius,recty);
        // draw top right corner
        ctx.arcTo(rectx+rectWidth,recty,rectx+rectWidth,recty+radius,radius);
        ctx.lineTo(rectx+rectWidth,recty+rectHeight-radius);    // right side
        // draw bottom right corner
        ctx.arcTo(rectx+rectWidth,recty+rectHeight,rectx+rectWidth-radius,recty+rectHeight,radius);
        ctx.lineTo(rectx+radius,recty+rectHeight);              // bottom side
        // draw bottom left corner
        ctx.arcTo(rectx,recty+rectHeight,rectx,recty+rectHeight-radius,radius);
        ctx.lineTo(rectx,recty+radius);                 // left side
        // draw top left corner
        ctx.arcTo(rectx,recty,rectx+radius,recty,radius);
        ctx.closePath();
        if (canvas.fill)
            ctx.fill();
        if (canvas.stroke)
            ctx.stroke();
        ctx.restore();
    }
}
