import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick3D 6.5





Rectangle {
    id : window
    width: 740
    height: 500
    color: "#0019191d"
    signal quitSignal
    property point lastMousePos: Qt.point(0, 0)

    MouseArea {
        anchors.fill: parent
        onPressed: controller.handle_mouse_press(mouse.x, mouse.y)
        onPositionChanged: controller.handle_mouse_move(mouse.x, mouse.y)
        onReleased: controller.handle_mouse_release()
    }

    Rectangle {
        id: rectangle3
        x: 70
        y: 9
        width: 50
        height: 51
        color: "#1fc9d5"
        rotation: 45
    }

    

    Item {
        id: __materialLibrary__
    }

    Rectangle {
        id: rectangle2
        x: 69
        y: 441
        width: 50
        height: 50
        color: "#d54eff"
        rotation: 45
    }


    Rectangle {
        id: rectangle
        x: 0
        y: 35
        width: 740
        height: 431
        color: "#19191d"

        Image {
            id: image2
            x: 115
            y: -9
            width: 719
            height: 459
            opacity: 0.5
            source: "Assets/Image1.png"
            rotation: -18
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: image4
            x: -447
            y: 99
            width: 719
            height: 459
            opacity: 0.5
            source: "Assets/Image1.png"
            rotation: 170
            fillMode: Image.PreserveAspectFit
        }

        Rectangle {
            id: rectangle10
            x: 458
            y: 363
            width: 112
            height: 41
            visible: true
            color: "#00ffffff"
            radius: 20
            border.color: "#ae88f0"
            border.width: 2

            Text {
                id: text4
                x: 31
                y: 10
                color: "#ba85f1"
                text: qsTr("Cancel")
                font.pixelSize: 16
                font.bold: true
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    controller.quit_application();
                }
            }
        }

        Rectangle {
            id: rectangle4
            x: 583
            y: 362
            width: 133
            height: 42
            color: "#ffffff"
            radius: 20
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#45bdfa"
                }

                GradientStop {
                    position: 1
                    color: "#db7bfa"
                }
                orientation: Gradient.Horizontal
            }

            Image {
                id: image3
                x: 103
                y: 8
                width: 26
                height: 26
                source: "Assets/icons8-double-droite-64 (1).png"
                fillMode: Image.PreserveAspectFit
            }

            Text {
                id: text3
                x: 15
                y: 10
                color: "#ffffff"
                text: qsTr("Get Started")
                font.pixelSize: 16
                verticalAlignment: Text.AlignVCenter
                font.bold: true
            }
            MouseArea {
                anchors.fill: parent
                onClicked: controller.open_new_application()
            }
        }











        Rectangle {
            id: rectangle1
            x: 95
            y: -35
            width: 222
            height: 501
            opacity: 1
            color: "#19c704"
            gradient: Gradient {
                GradientStop {
                    position: 0.94737
                    color: "#d67ef2"
                }

                GradientStop {
                    position: 0
                    color: "#37d0d6"
                }

                orientation: Gradient.Vertical
                GradientStop {
                    position: 0
                    color: "#37d0d6"
                }
            }
        }

        Image {
            id: image1
            x: 329
            y: 1
            width: 82
            height: 76
            source: "Assets/icone.png"
            rotation: 180
            fillMode: Image.PreserveAspectFit
        }

        Text {
            id: text2
            x: 473
            y: 21
            width: 32
            height: 29
            color: "#ba70e7"
            text: qsTr("ID")
            font.pixelSize: 23
            verticalAlignment: Text.AlignVCenter
            font.italic: false
            font.bold: true
        }

        Text {
            id: text1
            x: 405
            y: 21
            width: 72
            height: 29
            color: "#37d0d6"
            text: qsTr("Vision")
            font.pixelSize: 23
            verticalAlignment: Text.AlignVCenter
            font.italic: false
            font.bold: true
        }

        Rectangle {
            id: rectangle5
            x: 499
            y: 40
            width: 10
            height: 10
            color: "#c575df"
            radius: 5
        }


    }


}
