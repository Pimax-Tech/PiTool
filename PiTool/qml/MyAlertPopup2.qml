﻿import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2 as Control12

Window {
    property var message: "";
    width:txt.width+40;
    height: txt.height+30;
    flags: Qt.SubWindow | Qt.FramelessWindowHint;
    color:"#00000000"
    id:alertPopup
    visible: false;
    x: mainWindow.x+mainWindow.width-width-10;
    y:mainWindow.y+mainWindow.height-height-10;
//    x:{
//        var posX = mainWindow.x+(mainWindow.width-width)/2;
//        if(posX<0){
//            posX =0;
//        }else if(posX+width>Screen.width){
//            posX = Screen.width-width;
//        }
//        return posX;
//    }
//    y:{
//        var posY = mainWindow.y+(mainWindow.height-height)/2;
//        if(posY<0){
//            posY = 0;
//        }else if(posY+height>Screen.height){
//            posY = Screen.height-height;
//        }
//        return posY;
//    }
    RectangularGlow{
        anchors.fill: alertBG;
        glowRadius: 5;
        cornerRadius:10;
        spread: 0.4;color:"#7F000000";
    }
    Rectangle{
        id:alertBG;
        width:parent.width;height: parent.height
        radius: 5;
        opacity: 0.85;
        border.width: 1;
        border.color:gray

        ImageButton {//Close Button
            id: btnClose
            anchors.right: parent.right;
            image_normal: "qrc:/resource/quit-n.png"
            mouseArea.onClicked: {
                closeTimer.stop();
                closeAnimate.start();
            }
        }
        MyLabel{
            id:txt
            text:message
            anchors.centerIn: parent;
        }
    }

    onVisibleChanged: {
        console.log("MyAlertPopup2 onVisibleChanged,",visible);
        if(visible){
            alertBG.opacity = 0.85;
            closeTimer.start();
        }
    }

    OpacityAnimator{
        id:closeAnimate;
        target: alertBG;
        from: 0.85;
        to: 0;
        duration: 300
        running: false;
        onStopped: {
            alertPopup.visible=false;
            alertPopup.close();
        }
    }
    function closeWindow(){
        closeAnimate.stop();
        closeTimer.stop();
        visible=false;
    }

    Timer{
        id:closeTimer;
        interval: 2000;
        repeat: false;
        triggeredOnStart: false;
        onTriggered: {
            closeAnimate.start();
        }
    }
    Control12.Action{
        shortcut: "Escape"
        onTriggered: {
            closeAnimate.start();
        }
    }
}
