import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id : window
    width: 1080
    height: 720
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
        id: rectangle
        x: 0
        y: 0
        width: 1080
        height: 720
        color: "#0b1218"
        radius: 25
        border.width: 0
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        

        Rectangle {
            id: aboutdev
            x: 90
            y: 0
            width: 990
            height: 720
            color: "#111a25"
            radius: 25
            visible: false

            Rectangle {
                id: rectangle81
                x: -8
                y: 498
                width: 22
                height: 22
                color: "#111a25"
                radius: 3
                border.width: 0
                rotation: 45
            }

            Text {
                id: text111
                x: 35
                y: 12
                color: "#e4e4e4"
                text: qsTr("About Us")
                font.pixelSize: 26
                verticalAlignment: Text.AlignVCenter
                font.bold: true
            }

            Rectangle {
                id: rectangle93
                x: 35
                y: 68
                width: 454
                height: 386
                color: "#1a2431"
                radius: 13
                Image {
                    id: image48
                    x: 8
                    y: 8
                    width: 31
                    height: 32
                    source: "Assets/icons8-planning-a-new-software-programing-strategy-presentation-48.png"
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    id: text139
                    x: 47
                    y: 12
                    color: "#e7e7e7"
                    text: qsTr("About Devs")
                    font.pixelSize: 14
                    font.bold: true
                }

                Rectangle {
                    id: rectangle94
                    x: 135
                    y: 22
                    width: 300
                    height: 2
                    color: "#c983ef"
                }

                Text {
                    id: text112
                    x: 27
                    y: 60
                    width: 400
                    height: 121
                    color: "#c1c1c1"
                    text: "This iris recognition project was a collaborative effort by Rabiai Mehdi Ayoub and Zahaf Boualem Nadjib, alongside Barca Fateh Ahmed and Limani Mohamed Amine. In this innovative project, we explored three different methodologies to achieve accurate iris recognition software with a stunning interface. These methods are:"
                    font.pixelSize: 14
                    lineHeight: 1.1
                    wrapMode: Text.WordWrap
                    font.bold: true
                }

                Text {
                    id: text113
                    x: 47
                    y: 193
                    width: 280
                    height: 25
                    color: "#c1c1c1"
                    text: "Traditional Method Using Database (SIFT)"
                    font.pixelSize: 14
                    wrapMode: Text.WordWrap
                    font.bold: true
                }

                Text {
                    id: text114
                    x: 47
                    y: 216
                    width: 280
                    height: 25
                    color: "#c1c1c1"
                    text: "Convolutional Neural Network (CNN)"
                    font.pixelSize: 14
                    wrapMode: Text.WordWrap
                    font.bold: true
                }

                Text {
                    id: text115
                    x: 47
                    y: 238
                    width: 280
                    height: 25
                    color: "#c1c1c1"
                    text: "Gabor Filter + Neural Network"
                    font.pixelSize: 14
                    wrapMode: Text.WordWrap
                    font.bold: true
                }

                Rectangle {
                    id: rectangle29
                    x: 29
                    y: 197
                    width: 12
                    height: 12
                    color: "#00ffffff"
                    radius: 3
                    border.color: "#ffffff"
                    border.width: 2
                }

                Rectangle {
                    id: rectangle30
                    x: 29
                    y: 220
                    width: 12
                    height: 12
                    color: "#00ffffff"
                    radius: 3
                    border.color: "#ffffff"
                    border.width: 2
                }

                Rectangle {
                    id: rectangle74
                    x: 29
                    y: 243
                    width: 12
                    height: 12
                    color: "#00ffffff"
                    radius: 3
                    border.color: "#ffffff"
                    border.width: 2
                }

                Text {
                    id: text116
                    x: 27
                    y: 265
                    width: 400
                    height: 69
                    color: "#c1c1c1"
                    text: "This project highlights the effectiveness of combining modern and traditional methods for iris recognition and demonstrates the collaborative and innovative approach."
                    font.pixelSize: 14
                    lineHeight: 1.1
                    wrapMode: Text.WordWrap
                    font.bold: true
                }

                Text {
                    id: text117
                    x: 351
                    y: 345
                    width: 60
                    height: 23
                    color: "#c1c1c1"
                    text: "Enjoy ;)"
                    font.pixelSize: 14
                    lineHeight: 1.1
                    wrapMode: Text.WordWrap
                    font.bold: true
                }
            }

            AnimatedImage {
                id: animatedImage6
                x: 832
                y: 116
                width: 80
                height: 89
                source: "Assets/icons8-chatbot-94.png"
                fillMode: Image.Stretch
            }

            Rectangle {
                id: rectangle96
                x: 508
                y: 129
                width: 308
                height: 74
                opacity: 1
                color: "#c681ec"
                radius: 8
                Rectangle {
                    id: rectangle97
                    x: 297
                    y: 26
                    width: 16
                    height: 16
                    color: "#c983ef"
                    radius: 4
                    rotation: 45
                }

                Text {
                    id: text140
                    x: 7
                    y: 9
                    width: 293
                    height: 57
                    color: "#ffffff"
                    text: qsTr("Oww.. it's a goodbye! It was a pleasure working with you. Don’t hesitate to call on me again — I'm always here to help!")
                    font.pixelSize: 13
                    wrapMode: Text.WordWrap
                    font.bold: true
                }
            }

            Rectangle {
                id: selectaboutdev
                x: -63
                y: 488
                width: 40
                height: 40
                opacity: 1
                color: "#c983ef"
                radius: 10
                rotation: 45
            }

            Rectangle {
                id: rectangle95
                x: 35
                y: 480
                width: 908
                height: 204
                color: "#1a2431"
                radius: 13
                Image {
                    id: image49
                    x: 8
                    y: 8
                    width: 37
                    height: 35
                    source: "Assets/icons8-bibliology-64.png"
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    id: text141
                    x: 51
                    y: 12
                    height: 18
                    color: "#e7e7e7"
                    text: qsTr("Library")
                    font.pixelSize: 14
                    font.bold: true
                }

                Rectangle {
                    id: rectangle98
                    x: 130
                    y: 22
                    width: 753
                    height: 2
                    color: "#c983ef"
                }

                Image {
                    id: image45
                    x: 43
                    y: 49
                    width: 64
                    height: 58
                    source: "Assets/icons8-qt-100.png"
                    sourceSize.width: 100
                    sourceSize.height: 100
                    fillMode: Image.PreserveAspectFit
                }

                Image {
                    id: image51
                    x: 221
                    y: 49
                    width: 55
                    height: 58
                    source: "Assets/Qtforpython.png"
                    fillMode: Image.PreserveAspectFit
                }

                Image {
                    id: image52
                    x: 318
                    y: 133
                    width: 48
                    height: 49
                    source: "Assets/icons8-ouvrir-cv-96.png"
                    fillMode: Image.PreserveAspectFit
                }

                Image {
                    id: image53
                    x: 130
                    y: 133
                    width: 48
                    height: 49
                    source: "Assets/icons8-numpy-96.png"
                    fillMode: Image.PreserveAspectFit
                }

                Image {
                    id: image54
                    x: 397
                    y: 58
                    width: 48
                    height: 49
                    source: "Assets/Tensorflow_logo.png"
                    fillMode: Image.PreserveAspectFit
                }

                Image {
                    id: image55
                    x: 492
                    y: 133
                    width: 48
                    height: 49
                    source: "Assets/matplotlib-seeklogo.svg"
                    sourceSize.height: 120
                    sourceSize.width: 120
                    fillMode: Image.PreserveAspectFit
                }

                Image {
                    id: image56
                    x: 683
                    y: 133
                    width: 49
                    height: 49
                    source: "Assets/image-removebg-preview (1).png"
                    sourceSize.height: 120
                    sourceSize.width: 120
                    fillMode: Image.PreserveAspectFit
                }

                Image {
                    id: image57
                    x: 580
                    y: 46
                    width: 70
                    height: 65
                    source: "Assets/68747470733a2f2f7261772e67697468756275736572636f6e74656e742e636f6d2f7363696b69742d6c6561726e2f7363696b69742d6c6561726e2f6d61696e2f646f632f6c6f676f732f7363696b69742d6c6561726e2d6c6f676f2e706e67.png"
                    sourceSize.width: 120
                    sourceSize.height: 120
                    fillMode: Image.PreserveAspectFit
                }

                Image {
                    id: image58
                    x: 779
                    y: 49
                    width: 62
                    height: 58
                    source: "Assets/icons8-github-80.png"
                    sourceSize.width: 120
                    sourceSize.height: 120
                    fillMode: Image.PreserveAspectFit
                }
            }

            Rectangle {
                id: rectangle99
                x: 508
                y: 237
                width: 435
                height: 217
                color: "#1a2431"
                radius: 13
                Image {
                    id: image50
                    x: 8
                    y: 8
                    width: 31
                    height: 32
                    source: "Assets/icons8-github-80.png"
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    id: text142
                    x: 45
                    y: 14
                    height: 18
                    color: "#e7e7e7"
                    text: qsTr("Profile")
                    font.pixelSize: 14
                    font.bold: true
                }

                Rectangle {
                    id: rectangle100
                    x: 101
                    y: 23
                    width: 303
                    height: 2
                    color: "#c983ef"
                }

                Text {
                    id: text118
                    x: 80
                    y: 70
                    width: 224
                    height: 21
                    color: "#c0c0c0"
                    text: qsTr("https://github.com/boua112")
                    font.pixelSize: 14
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                }

                Text {
                    id: text119
                    x: 80
                    y: 138
                    width: 224
                    height: 21
                    color: "#c0c0c0"
                    text: qsTr("https://github.com/rabiai-mehdi-ayoub")
                    font.pixelSize: 14
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                }

                Image {
                    id: image62
                    x: 17
                    y: 53
                    width: 47
                    height: 54
                    source: "Assets/icons8-github-80.png"
                    fillMode: Image.PreserveAspectFit
                }

                Image {
                    id: image63
                    x: 17
                    y: 121
                    width: 47
                    height: 54
                    source: "Assets/icons8-github-80.png"
                    fillMode: Image.PreserveAspectFit
                }
            }
        }

        Rectangle {
            id: classification
            x: 90
            y: 0
            width: 990
            height: 720
            color: "#111a25"
            radius: 25
            visible: false

            Rectangle {
                id: rectangle80
                x: -8
                y: 424
                width: 22
                height: 22
                color: "#111a25"
                radius: 3
                border.width: 0
                rotation: 45
            }

            Text {
                id: text105
                x: 35
                y: 12
                color: "#e4e4e4"
                text: qsTr("Classification")
                font.pixelSize: 26
                verticalAlignment: Text.AlignVCenter
                font.bold: true
            }

            Rectangle {
                id: rectangle87
                x: 35
                y: 276
                width: 908
                height: 427
                color: "#1a2431"
                radius: 13
                Image {
                    id: image46
                    x: 8
                    y: 8
                    width: 31
                    height: 32
                    source: "Assets/image.png"
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    id: text136
                    x: 45
                    y: 12
                    color: "#e7e7e7"
                    text: qsTr("Visualization")
                    font.pixelSize: 14
                    font.bold: true
                }

                Rectangle {
                    id: rectangle88
                    x: 135
                    y: 22
                    width: 738
                    height: 2
                    color: "#c983ef"
                }

                Rectangle {
                    id: rectangle89
                    x: 98
                    y: 57
                    width: 689
                    height: 280
                    color: "#00ffffff"
                    border.width: 0
                    clip: true

                    Image {
                        id: image61
                        x: 8
                        y: 8
                        width: 690
                        height: 281
                        source: "Assets/grid2"
                        clip: true
                        fillMode: Image.TileVertically
                        transformOrigin: Item.Center
                        smooth: true
                        property real zoomFactor: 1.0
                        function changeZoom(factor) {
                            zoomFactor *= factor;
                            // Assurez-vous que le zoom ne devient pas trop petit ou trop grand
                            zoomFactor = Math.min(5.0, Math.max(0.1, zoomFactor));
                            // Mettez à jour le facteur de zoom pour l'image
                            scale = zoomFactor;
                        }
                        MouseArea {
                            anchors.fill: parent
                            anchors.rightMargin: 15
                            clip: true
                            // Gestion du zoom/dézoom lorsque la molette de la souris est déplacée
                            onWheel: {
                                if (wheel.angleDelta.y > 0) {
                                    // Zoom in
                                    image61.changeZoom(1.1);
                                } else {
                                    // Zoom out
                                    image61.changeZoom(0.9);
                                }
                            }
                        }
                        Image {
                            id: image44
                            x: 0
                            y: 0
                            width: 690
                            height: 281
                            source: visualizationclassification
                            clip: true
                            fillMode: Image.PreserveAspectFit
                            scale: 1
                            autoTransform: true
                            focus: true
                            activeFocusOnTab: true
                            MouseArea {
                                anchors.fill: parent
                                anchors.leftMargin: -5
                                anchors.bottomMargin: 26
                                drag.target: image44

                                onPressed: {
                                    drag.active = true
                                    drag.origin.x = image44.x
                                    drag.origin.y = image44.y
                                }

                                onPositionChanged: {
                                    // Déplacer l'image en fonction du mouvement de la souris
                                    if (drag.active) {
                                        image44.x = drag.origin.x + (mouseX - drag.startX)
                                        image44.y = drag.origin.y + (mouseY - drag.startY)
                                    }
                                }

                                onReleased: {
                                    drag.active = false
                                }
                            }

                        }
                    }
                }

                Rectangle {
                    id: rectangle77
                    x: 104
                    y: 57
                    width: 689
                    height: 286
                    color: "#00ffffff"
                    border.color: "#c681ec"
                    border.width: 2
                    clip: true
                }

                Rectangle {
                    id: rectangle78
                    x: 738
                    y: 363
                    width: 135
                    height: 43
                    radius: 22
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: "#33bcff"
                        }

                        GradientStop {
                            position: 1
                            color: "#e86efb"
                        }
                        orientation: Gradient.Horizontal
                    }

                    Text {
                        id: text120
                        x: 25
                        y: 12
                        color: "#d8dadc"
                        text: qsTr("Try Again")
                        font.pixelSize: 14
                        font.bold: true
                    }

                    Image {
                        id: image64
                        x: 94
                        y: 7
                        width: 31
                        height: 30
                        source: "Assets/icons8-rendez-vous-périodique-64.png"
                        fillMode: Image.PreserveAspectFit
                    }

                    MouseArea {
                        id: resetall
                        x: 8
                        y: 0
                        width: 117
                        height: 43
                        onClicked: {
                            controller.reset_all(startpreprocessing,startclassification,preprocessingsiftrect,preprocessingcnnrect,preprocessinggaborrect)
                            controller.switchmenu("aboutdev",dashboard,config,preprocess,classification,aboutdev)
                        }
                    }
                }
            }

            AnimatedImage {
                id: animatedImage5
                x: 814
                y: 89
                width: 80
                height: 89
                source: "Assets/icons8-chatbot-94.png"
                fillMode: Image.Stretch
            }

            Rectangle {
                id: rectangle90
                x: 490
                y: 102
                width: 308
                height: 74
                opacity: 1
                color: "#c681ec"
                radius: 8
                Rectangle {
                    id: rectangle91
                    x: 297
                    y: 26
                    width: 16
                    height: 16
                    color: "#c983ef"
                    radius: 4
                    rotation: 45
                }

                Text {
                    id: text137
                    x: 7
                    y: 9
                    width: 293
                    height: 57
                    color: "#ffffff"
                    text: chatbotdisucssion
                    font.pixelSize: 12
                    wrapMode: Text.WordWrap
                    font.bold: true
                }
            }

            Rectangle {
                id: rectangle73
                x: 35
                y: 102
                width: 433
                height: 161
                color: "#1a2431"
                radius: 12

                Image {
                    id: image47
                    x: 8
                    y: 8
                    width: 31
                    height: 32
                    source: "Assets/image.png"
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    id: text138
                    x: 43
                    y: 12
                    color: "#e7e7e7"
                    text: qsTr("Classification")
                    font.pixelSize: 14
                    font.bold: true
                }

                Rectangle {
                    id: rectangle92
                    x: 135
                    y: 22
                    width: 290
                    height: 2
                    color: "#c983ef"
                }

                Text {
                    id: text103
                    x: 28
                    y: 53
                    width: 54
                    height: 19
                    opacity: 0.9
                    color: "#b6b6b6"
                    text: qsTr("Model :")
                    font.pixelSize: 14
                    font.bold: true
                }

                Text {
                    id: text108
                    x: 86
                    y: 53
                    width: 138
                    height: 19
                    color: "#ff00dd"
                    text: modeltitle
                    font.pixelSize: 14
                    font.bold: true
                }

                Text {
                    id: text106
                    x: 28
                    y: 85
                    width: 48
                    height: 19
                    opacity: 0.9
                    color: "#b6b6b6"
                    text: qsTr("Class :")
                    font.pixelSize: 14
                    font.bold: true
                }

                Text {
                    id: text107
                    x: 28
                    y: 117
                    width: 144
                    height: 19
                    opacity: 0.9
                    color: "#b6b6b6"
                    text: qsTr("Time :")
                    font.pixelSize: 14
                    scale: 1
                    font.bold: true
                }

                Text {
                    id: text109
                    x: 75
                    y: 85
                    color: "#ffffff"
                    text: classpredicted
                    font.pixelSize: 14
                    font.bold: true
                }

                Text {
                    id: text110
                    x: 75
                    y: 117
                    color: "#ffffff"
                    text: timepredicted
                    font.pixelSize: 14
                    font.bold: true
                }

            }

            Rectangle {
                id: selectclassification
                x: -63
                y: 414
                width: 40
                height: 40
                opacity: 1
                color: "#c983ef"
                radius: 10
                rotation: 45
            }
        }

        Rectangle {
            id: preprocess
            x: 90
            y: 0
            width: 990
            height: 720
            color: "#111a25"
            radius: 25
            visible:false

            Rectangle {
                id: rectangle79
                x: -8
                y: 352
                width: 22
                height: 22
                color: "#111a25"
                radius: 3
                border.width: 0
                rotation: 45
            }

            Text {
                id: text104
                x: 35
                y: 12
                color: "#e4e4e4"
                text: qsTr("Pre-Processing")
                font.pixelSize: 26
                verticalAlignment: Text.AlignVCenter
                font.bold: true
            }

            Rectangle {
                id: rectangle32
                x: 35
                y: 86
                width: 387
                height: 599
                color: "#1a2431"
                radius: 13

                Image {
                    id: image42
                    x: 8
                    y: 8
                    width: 31
                    height: 32
                    source: "Assets/integration-de-donnees.png"
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    id: text72
                    x: 45
                    y: 12
                    color: "#e7e7e7"
                    text: qsTr("Preprocess")
                    font.pixelSize: 14
                    font.bold: true
                }

                Rectangle {
                    id: rectangle60
                    x: 122
                    y: 22
                    width: 252
                    height: 2
                    color: "#c983ef"
                }

                Rectangle {
                    id: rectangle35
                    x: 277
                    y: 553
                    width: 97
                    height: 38
                    radius: 19
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

                    Text {
                        id: textstep
                        x: 1
                        y: 8
                        width: 78
                        height: 19
                        color: "#e7e7e7"
                        text: textsteppreprocess
                        font.pixelSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignTop
                        font.bold: true
                    }

                    Image {
                        id: image41
                        x: 70
                        y: 6
                        width: 26
                        height: 25
                        source: "Assets/icons8-double-droite-64 (1).png"
                        fillMode: Image.PreserveAspectFit
                    }

                    MouseArea {
                        id: startpreprocessing
                        x: 0
                        y: 0
                        width: 96
                        height: 38
                        visible:true
                        onClicked:{
                            startFadeOutAnimation4()
                            fadeInTimer.start()
                            startchatTimer.start()
                            startpreprocesstimer.start()
                        }
                    }
                    MouseArea {
                        id: startclassification
                        x: 0
                        y: 0
                        width: 96
                        height: 38
                        visible: false
                        onClicked:{
                            controller.start_classification(preprocess,classification)
                        }
                    }
                    Timer {
                        id : startpreprocesstimer
                        interval : 4000
                        repeat : false
                        onTriggered : controller.startpreprocess(startpreprocessing,startclassification)
                    }
                    Timer {
                        id: fadeInTimer
                        interval: 2000 // 2 secondes
                        repeat: false
                        onTriggered: startFadeInAnimation4()
                    }
                    Timer {
                        id: startchatTimer
                        interval: 1000 // 2 secondes
                        repeat: false
                        onTriggered: controller.start_chat()
                    }
                }

                Text {
                    id: text73
                    x: 111
                    y: 52
                    width: 155
                    height: 26
                    opacity: 0.6
                    color: "#ffffff"
                    text: steponepreprocessing
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    font.bold: true
                }

                Text {
                    id: text74
                    x: 111
                    y: 158
                    width: 155
                    height: 26
                    opacity: 0.6
                    color: "#ffffff"
                    text: steptwopreprocessing
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    font.bold: true
                }

                Text {
                    id: text75
                    x: 110
                    y: 277
                    width: 155
                    height: 26
                    opacity: 0.6
                    color: "#ffffff"
                    text: stepthreepreprocessing
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    font.bold: true
                }

                Text {
                    id: text76
                    x: 110
                    y: 395
                    width: 156
                    height: 26
                    opacity: 0.6
                    color: "#ffffff"
                    text: stepfourpreprocessing
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    font.bold: true
                }

                Text {
                    id: text77
                    x: 8
                    y: 106
                    color: "#a1a5aa"
                    text: qsTr("Processing time :")
                    font.pixelSize: 12
                    font.bold: true
                }

                Rectangle {
                    id: rectangle63
                    x: 8
                    y: 62
                    width: 108
                    height: 1
                    opacity: 0.5
                    color: "#969ba0"
                }

                Rectangle {
                    id: rectangle64
                    x: 266
                    y: 62
                    width: 108
                    height: 1
                    opacity: 0.5
                    color: "#969ba0"
                }

                Rectangle {
                    id: rectangle65
                    x: 8
                    y: 170
                    width: 108
                    height: 1
                    opacity: 0.5
                    color: "#969ba0"
                }

                Rectangle {
                    id: rectangle66
                    x: 266
                    y: 170
                    width: 108
                    height: 1
                    opacity: 0.5
                    color: "#969ba0"
                }

                Rectangle {
                    id: rectangle67
                    x: 8
                    y: 288
                    width: 108
                    height: 1
                    opacity: 0.5
                    color: "#969ba0"
                }

                Rectangle {
                    id: rectangle68
                    x: 266
                    y: 288
                    width: 108
                    height: 1
                    opacity: 0.5
                    color: "#969ba0"
                }

                Rectangle {
                    id: rectangle69
                    x: 8
                    y: 405
                    width: 108
                    height: 1
                    opacity: 0.5
                    color: "#969ba0"
                }

                Rectangle {
                    id: rectangle70
                    x: 266
                    y: 405
                    width: 108
                    height: 1
                    opacity: 0.5
                    color: "#969ba0"
                }

                Text {
                    id: text78
                    x: 8
                    y: 78
                    color: "#a1a5aa"
                    text: qsTr("Status :")
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    id: text79
                    x: 8
                    y: 134
                    color: "#a1a5aa"
                    text: qsTr("Visualization :")
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    id: text80
                    x: 8
                    y: 217
                    color: "#a1a5aa"
                    text: qsTr("Processing time :")
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    id: text81
                    x: 8
                    y: 189
                    color: "#a1a5aa"
                    text: qsTr("Status :")
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    id: text82
                    x: 8
                    y: 245
                    color: "#a1a5aa"
                    text: qsTr("Visualization :")
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    id: text83
                    x: 8
                    y: 335
                    color: "#a1a5aa"
                    text: qsTr("Processing time :")
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    id: text84
                    x: 8
                    y: 307
                    color: "#a1a5aa"
                    text: qsTr("Status :")
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    id: text85
                    x: 8
                    y: 363
                    color: "#a1a5aa"
                    text: qsTr("Visualization :")
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    id: text86
                    x: 8
                    y: 450
                    color: "#a1a5aa"
                    text: qsTr("Processing time :")
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    id: text87
                    x: 8
                    y: 422
                    color: "#a1a5aa"
                    text: qsTr("Status :")
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    id: text88
                    x: 8
                    y: 478
                    color: "#a1a5aa"
                    text: qsTr("Visualization :")
                    font.pixelSize: 12
                    font.bold: true
                }

                Rectangle {
                    id: rectangle71
                    x: 8
                    y: 512
                    width: 360
                    height: 1
                    opacity: 0.5
                    color: "#969ba0"
                }

                Text {
                    id: text89
                    x: 8
                    y: 526
                    color: "#a1a5aa"
                    text: qsTr("Result :")
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    id: text90
                    x: 55
                    y: 526
                    width: 199
                    height: 16
                    color:resultpreprocessingcolor
                    text: resultpreprocessing
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    id: text91
                    x: 55
                    y: 78
                    width: 94
                    height: 16
                    color: steponestatuscolor
                    text: steponestatus
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    id: text92
                    x: 110
                    y: 106
                    width: 78
                    height: 16
                    color: "#ffffff"
                    text: steponetime
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    id: text93
                    x: 93
                    y: 134
                    width: 131
                    height: 16
                    color: "#00d138"
                    text: steponevisualization
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    id: text94
                    x: 55
                    y: 189
                    width: 94
                    height: 16
                    color: steptwostatuscolor
                    text: steptwostatus
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    id: text95
                    x: 110
                    y: 217
                    width: 78
                    height: 16
                    color: "#ffffff"
                    text: steptwotime
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    id: text96
                    x: 93
                    y: 245
                    width: 131
                    height: 16
                    color: "#00d138"
                    text: steptwovisualization
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    id: text97
                    x: 55
                    y: 307
                    width: 78
                    height: 16
                    color: stepthreestatuscolor
                    text: stepthreestatus
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    id: text98
                    x: 110
                    y: 335
                    width: 78
                    height: 16
                    color: "#ffffff"
                    text: stepthreetime
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    id: text99
                    x: 93
                    y: 363
                    width: 131
                    height: 16
                    color: "#00d138"
                    text: stepthreevisualization
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    id: text100
                    x: 55
                    y: 422
                    width: 78
                    height: 16
                    color: stepfourstatuscolor
                    text: stepfourstatus
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    id: text101
                    x: 110
                    y: 450
                    width: 78
                    height: 16
                    color: "#ffffff"
                    text: stepfourtime
                    font.pixelSize: 12
                    font.bold: true
                }

                Text {
                    id: text102
                    x: 93
                    y: 478
                    width: 131
                    height: 16
                    color: stepfourvisualizationcolor
                    text: stepfourvisualization
                    font.pixelSize: 12
                    font.bold: true
                }
            }

            Rectangle {
                id: rectangle33
                x: 445
                y: 221
                width: 495
                height: 464
                color: "#1a2431"
                radius: 13

                Image {
                    id: image40
                    x: 8
                    y: 8
                    width: 31
                    height: 32
                    source: "Assets/image.png"
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    id: text69
                    x: 45
                    y: 12
                    color: "#e7e7e7"
                    text: qsTr("Visualization")
                    font.pixelSize: 14
                    font.bold: true
                }

                Rectangle {
                    id: rectangle34
                    x: 135
                    y: 22
                    width: 338
                    height: 2
                    color: "#c983ef"
                }

                Rectangle {
                    id: rectangle72
                    x: 39
                    y: 57
                    width: 420
                    height: 391
                    color: "#00ffffff"
                    border.width: 2
                    clip: true

                    Image {
                        id: image43
                        x: 0
                        y: 0
                        width: 412
                        height: 391
                        source: "Assets/Black White Simple Minimalist Grid Paper Notepad (4)"
                        clip: true
                        fillMode: Image.PreserveAspectCrop
                        transformOrigin: Item.Center
                        smooth: true
                        property real zoomFactor: 1.0
                        function changeZoom(factor) {
                            zoomFactor *= factor;
                            // Assurez-vous que le zoom ne devient pas trop petit ou trop grand
                            zoomFactor = Math.min(5.0, Math.max(0.1, zoomFactor));
                            // Mettez à jour le facteur de zoom pour l'image
                            scale = zoomFactor;
                        }
                        MouseArea {
                            anchors.fill: parent
                            anchors.rightMargin: 15
                            clip: true
                            // Gestion du zoom/dézoom lorsque la molette de la souris est déplacée
                            onWheel: {
                                if (wheel.angleDelta.y > 0) {
                                    // Zoom in
                                    image43.changeZoom(1.1);
                                } else {
                                    // Zoom out
                                    image43.changeZoom(0.9);
                                }
                            }
                        }
                        Image {
                            id: image60
                            x: 13
                            y: 20
                            width: 386
                            height: 352
                            source: visualizationpreprocessing
                            fillMode: Image.PreserveAspectFit
                            clip: true
                            focus: true
                            scale: 1
                            MouseArea {
                                anchors.fill: parent
                                anchors.leftMargin: -5
                                anchors.bottomMargin: 26
                                drag.target: image60

                                onPressed: {
                                    drag.active = true
                                    drag.origin.x = image60.x
                                    drag.origin.y = image60.y
                                }

                                onPositionChanged: {
                                    // Déplacer l'image en fonction du mouvement de la souris
                                    if (drag.active) {
                                        image60.x = drag.origin.x + (mouseX - drag.startX)
                                        image60.y = drag.origin.y + (mouseY - drag.startY)
                                    }
                                }

                                onReleased: {
                                    drag.active = false
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    id: rectangle76
                    x: 32
                    y: 52
                    width: 433
                    height: 404
                    color: "#00ffffff"
                    border.width: 3
                }
            }

            AnimatedImage {
                id: animatedImage4
                x: 814
                y: 89
                width: 80
                height: 89
                source: "Assets/icons8-chatbot-94.png"
                fillMode: Image.Stretch
            }

            Rectangle {
                id: rectangle61
                x: 490
                y: 102
                width: 308
                height: 74
                opacity: 1
                color: "#c681ec"
                radius: 8
                Rectangle {
                    id: rectangle62
                    x: 297
                    y: 26
                    width: 16
                    height: 16
                    color: "#c983ef"
                    radius: 4
                    rotation: 45
                }

                Text {
                    id: text71
                    x: 7
                    y: 8
                    width: 293
                    height: 57
                    color: "#ffffff"
                    text: robotchat
                    font.pixelSize: 12
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WordWrap
                    font.bold: true
                }
            }

            Rectangle {
                id: selectpreprocess
                x: -63
                y: 342
                width: 40
                height: 40
                opacity: 1
                color: "#c983ef"
                radius: 10
                rotation: 45
            }
        }

        Rectangle {
            id: config
            x: 90
            y: 0
            width: 990
            height: 720
            color: "#111a25"
            radius: 25
            border.width: 0
            visible:false
            
            Rectangle {
                id: rectangle57
                x: -8
                y: 279
                width: 22
                height: 22
                color: "#111a25"
                radius: 3
                border.width: 0
                rotation: 45
            }
            
            Text {
                id: text70
                x: 35
                y: 12
                color: "#e4e4e4"
                text: qsTr("Configuration")
                font.pixelSize: 26
                verticalAlignment: Text.AlignVCenter
                font.bold: true
            }
            
            Rectangle {
                id: rectangle1
                x: 35
                y: 90
                width: 909
                height: 197
                color: "#1a2431"
                radius: 12
                
                Rectangle {
                    id: rectangle36
                    x: 127
                    y: 19
                    width: 769
                    height: 2
                    color: "#c983ef"
                }
                
                Text {
                    id: text36
                    x: 37
                    y: 9
                    color: "#f3f3f3"
                    text: qsTr("Initialization")
                    font.pixelSize: 14
                    font.bold: true
                }
                
                Image {
                    id: image26
                    x: 5
                    y: 5
                    width: 28
                    height: 29
                    source: "Assets/icons8-paramètres-48.png"
                    fillMode: Image.PreserveAspectFit
                }
                
                Text {
                    id: text40
                    x: 21
                    y: 53
                    width: 52
                    height: 22
                    color: "#ffffff"
                    text: qsTr("Image :")
                    font.pixelSize: 13
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    
                    Text {
                        id: text47
                        x: 54
                        y: 3
                        width: 81
                        height: 16
                        color: "#a5a5a5"
                        text: "Not Uploaded"
                        font.pixelSize: 12
                        font.bold: true
                    }
                }
                
                AnimatedImage {
                    id: animatedImage1
                    x: 821
                    y: 19
                    width: 80
                    height: 89
                    source: "Assets/icons8-chatbot-94.png"
                    fillMode: Image.Stretch
                }
                
                
                Rectangle {
                    id: rectangle41
                    x: 564
                    y: 38
                    width: 246
                    height: 59
                    opacity: 1
                    color: "#c681ec"
                    radius: 8
                    
                    
                    Rectangle {
                        id: rectangle42
                        x: 237
                        y: 21
                        width: 16
                        height: 16
                        color: "#c983ef"
                        radius: 4
                        rotation: 45
                    }
                    Text {
                        id: text41
                        x: 8
                        y: 4
                        width: 234
                        height: 51
                        color: "#ffffff"
                        text: qsTr("Hey, I'm at your service! Just upload an image, and select the model you'd like to use for prediction. Let's get started!")
                        font.pixelSize: 12
                        wrapMode: Text.WordWrap
                        font.bold: true
                    }
                }
                
                Text {
                    id: text42
                    x: 21
                    y: 88
                    width: 52
                    height: 22
                    color: "#ffffff"
                    text: qsTr("Model :")
                    font.pixelSize: 13
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                }
                
                
                
                
                MouseArea {
                    id: mouseaffichlist
                    x: 84
                    y: 84
                    width: 204
                    height: 36
                    onClicked: {
                        controller.afficherlist(listmodels)
                    }
                }

                Rectangle {
                    id: modelchoose
                    x: 84
                    y: 84
                    width: 204
                    height: 36
                    color: "#151c26"
                    radius: 12
                    
                    Text {
                        id: text43
                        x: 35
                        y: 9
                        width: 127
                        height: 16
                        color: "#efefef"
                        text: modelselected
                        font.pixelSize: 12
                        font.bold: true

                    }
                    
                    Image {
                        id: image30
                        x: 183
                        y: 11
                        width: 14
                        height: 14
                        source: "Assets/icons8-chevron-bas-64.png"
                        fillMode: Image.PreserveAspectFit
                    }
                    
                    Image {
                        id: image35
                        x: 8
                        y: 7
                        width: 21
                        height: 21
                        source: imagemodel
                        fillMode: Image.PreserveAspectFit
                    }
                }
                
                Rectangle {
                    id: listmodels
                    x: 84
                    y: 84
                    width: 204
                    height: 105
                    color: "#151c26"
                    radius: 12
                    visible: false

                    Rectangle {
                        id: choosensift
                        x: 8
                        y: 7
                        width: 161
                        height: 26
                        color: "#00150000"

                        Text {
                            id: text46
                            x: 27
                            y: 5
                            color: "#efefef"
                            text: qsTr("SIFT + Classification")
                            font.pixelSize: 12
                            font.bold: true
                        }

                        Image {
                            id: image33
                            x: 0
                            y: 3
                            width: 21
                            height: 21
                            source: "Assets/icons8-filtration-48.png"
                            fillMode: Image.PreserveAspectFit
                        }
                        MouseArea {
                            id:choosesift
                            anchors.fill: parent
                            onClicked: {
                                controller.choosenmodel("SIFT",listmodels)
                                image35.source = "Assets/icons8-filtration-48.png"
                            }
                        }
                    }

                    Rectangle {
                        id: choosencnn
                        x: 8
                        y: 40
                        width: 161
                        height: 26
                        color: "#00ffffff"

                        Text {
                            id: text45
                            x: 27
                            y: 5
                            color: "#efefef"
                            text: qsTr("Conv Neural Network")
                            font.pixelSize: 12
                            font.bold: true
                        }

                        Image {
                            id: image32
                            x: 0
                            y: 3
                            width: 21
                            height: 21
                            source: "Assets/icons8-algorithm-64.png"
                            fillMode: Image.PreserveAspectFit
                        }

                        MouseArea {
                            id:choosecnn
                            anchors.fill: parent
                            onClicked: {
                                controller.choosenmodel("CNN",listmodels)
                                image35.source = "Assets/icons8-algorithm-64.png"
                            }
                        }
                    }

                    Rectangle {
                        id: choosengabor
                        x: 8
                        y: 72
                        width: 173
                        height: 26
                        color: "#00ffffff"

                        Text {
                            id: text44
                            x: 27
                            y: 5
                            color: "#e6e6e6"
                            text: qsTr("Gabor + Neural Network")
                            font.pixelSize: 12
                            font.bold: true
                        }

                        Image {
                            id: image31
                            x: 0
                            y: 3
                            width: 20
                            height: 20
                            opacity: 0.7
                            source: "Assets/GABOR.png"
                            fillMode: Image.PreserveAspectFit
                        }

                        MouseArea {
                            id: choosegabor
                            anchors.fill: parent
                            width: 100
                            height: 100
                            onClicked: {
                                controller.choosenmodel("GABOR",listmodels)
                                image35.source = "Assets/GABOR.png"
                            }
                        }
                    }

                    Image {
                        id: image34
                        x: 183
                        y: 11
                        width: 14
                        height: 14
                        source: "Assets/icons8-chevron-bas-64.png"
                        rotation: 180
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Rectangle {
                    id: applybtn
                    x: 791
                    y: 155
                    width: 105
                    height: 34
                    color: "#c681ec"
                    radius: 17
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
                        id: image38
                        x: 72
                        y: 4
                        width: 23
                        height: 24
                        source: "Assets/icons8-approved-48.png"
                        fillMode: Image.PreserveAspectFit
                    }
                    
                    Text {
                        id: text49
                        x: 20
                        y: 7
                        color: "#ffffff"
                        text: qsTr("Apply")
                        font.pixelSize: 14
                        font.bold: true
                    }

                    MouseArea {
                        id: mouseapply
                        x: 8
                        y: 0
                        width: 97
                        height: 34
                        onClicked: {
                            controller.applyconfig(preprocessingsiftrect,preprocessingcnnrect,preprocessinggaborrect)
                            startFadeOutAnimation()
                            startFadeInAnimation2()
                            startFadeInAnimation3()
                        }
                    }


                }
                
                Rectangle {
                    id: uploadbtn
                    x: 680
                    y: 155
                    width: 105
                    height: 34
                    color: "#c681ec"
                    radius: 17
                    border.width: 0
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
                        id: image36
                        x: 72
                        y: 4
                        width: 24
                        height: 26
                        source: "Assets/icons8-upload-image-96.png"
                        fillMode: Image.PreserveAspectFit
                    }
                    
                    Text {
                        id: text48
                        x: 16
                        y: 7
                        color: "#f7f7f7"
                        text: qsTr("Upload")
                        font.pixelSize: 14
                        font.bold: true
                    }

                    MouseArea {
                        id: mouseupload
                        x: 0
                        y: 0
                        width: 97
                        height: 34
                        onClicked: {
                            controller.uploadimage()
                            text47.text = "Uploaded"
                            text47.color = "#14dc02"
                        }
                    }
                }

            }
            
            Rectangle {
                id: rectangle26
                x: 36
                y: 301
                width: 523
                height: 173
                color: "#1a2431"
                radius: 12
                
                Image {
                    id: image28
                    x: 5
                    y: 5
                    width: 35
                    height: 34
                    source: "Assets/integration-de-donnees.png"
                    fillMode: Image.PreserveAspectFit
                }
                
                Text {
                    id: text38
                    x: 44
                    y: 11
                    width: 84
                    height: 16
                    color: "#ffffff"
                    text: "Pre-Processing"
                    font.pixelSize: 14
                    font.bold: true
                }
                
                Rectangle {
                    id: rectangle39
                    x: 148
                    y: 22
                    width: 360
                    height: 2
                    color: "#fe1e1e"
                }
                
                
                Rectangle {
                    id: preprocessinggaborrect
                    x: 20
                    y: 45
                    width: 488
                    height: 115
                    color: "#00ffffff"
                    visible: false
                    Text {
                        id: text55
                        x: 34
                        y: 8
                        color: "#c8c8c8"
                        text: qsTr("Bounderies detection")
                        font.pixelSize: 12
                        font.bold: true
                    }
                    
                    Text {
                        id: text56
                        x: 34
                        y: 34
                        color: "#c8c8c8"
                        text: qsTr("Normalization")
                        font.pixelSize: 12
                        font.bold: true
                    }
                    
                    Text {
                        id: text57
                        x: 34
                        y: 60
                        color: "#c8c8c8"
                        text: qsTr("Enhancement")
                        font.pixelSize: 12
                        font.bold: true
                    }
                    
                    Text {
                        id: text58
                        x: 34
                        y: 86
                        color: "#c8c8c8"
                        text: qsTr("Gabor Filters")
                        font.pixelSize: 12
                        font.bold: true
                    }
                    
                    Rectangle {
                        id: rectangle49
                        x: 15
                        y: 11
                        width: 13
                        height: 13
                        color: "#00ffffff"
                        radius: 5
                        border.color: "#ffffff"
                        border.width: 2
                    }
                    
                    Rectangle {
                        id: rectangle50
                        x: 15
                        y: 36
                        width: 13
                        height: 13
                        color: "#00ffffff"
                        radius: 5
                        border.color: "#ffffff"
                        border.width: 2
                    }
                    
                    Rectangle {
                        id: rectangle51
                        x: 15
                        y: 62
                        width: 13
                        height: 13
                        color: "#00ffffff"
                        radius: 5
                        border.color: "#ffffff"
                        border.width: 2
                    }
                    
                    Rectangle {
                        id: rectangle52
                        x: 15
                        y: 88
                        width: 13
                        height: 13
                        color: "#00ffffff"
                        radius: 5
                        border.color: "#ffffff"
                        border.width: 2
                    }
                }
                
                Rectangle {
                    id: preprocessingcnnrect
                    x: 20
                    y: 45
                    width: 488
                    height: 115
                    color: "#00ffffff"
                    visible: false
                    Text {
                        id: text59
                        x: 34
                        y: 8
                        color: "#c8c8c8"
                        text: qsTr("Bounderies detection")
                        font.pixelSize: 12
                        font.bold: true
                    }
                    
                    Text {
                        id: text60
                        x: 34
                        y: 34
                        color: "#c8c8c8"
                        text: qsTr("Normalization")
                        font.pixelSize: 12
                        font.bold: true
                    }
                    
                    Text {
                        id: text61
                        x: 34
                        y: 60
                        color: "#c8c8c8"
                        text: qsTr("Enhancement")
                        font.pixelSize: 12
                        font.bold: true
                    }
                    
                    Text {
                        id: text62
                        x: 34
                        y: 86
                        color: "#c8c8c8"
                        text: qsTr("Feature Ectraction CNN")
                        font.pixelSize: 12
                        font.bold: true
                    }
                    
                    Rectangle {
                        id: rectangle53
                        x: 15
                        y: 11
                        width: 13
                        height: 13
                        color: "#00ffffff"
                        radius: 5
                        border.color: "#ffffff"
                        border.width: 2
                    }
                    
                    Rectangle {
                        id: rectangle54
                        x: 15
                        y: 36
                        width: 13
                        height: 13
                        color: "#00ffffff"
                        radius: 5
                        border.color: "#ffffff"
                        border.width: 2
                    }
                    
                    Rectangle {
                        id: rectangle55
                        x: 15
                        y: 62
                        width: 13
                        height: 13
                        color: "#00ffffff"
                        radius: 5
                        border.color: "#ffffff"
                        border.width: 2
                    }
                    
                    Rectangle {
                        id: rectangle56
                        x: 15
                        y: 88
                        width: 13
                        height: 13
                        color: "#00ffffff"
                        radius: 5
                        border.color: "#ffffff"
                        border.width: 2
                    }
                }
                
                Rectangle {
                    id: preprocessingsiftrect
                    x: 20
                    y: 45
                    width: 488
                    height: 115
                    color: "#00ffffff"
                    visible: false
                    Text {
                        id: text50
                        x: 34
                        y: 8
                        color: "#c8c8c8"
                        text: qsTr("Bounderies detection")
                        font.pixelSize: 12
                        font.bold: true
                    }
                    
                    Text {
                        id: text51
                        x: 34
                        y: 34
                        color: "#c8c8c8"
                        text: qsTr("Equalizer")
                        font.pixelSize: 12
                        font.bold: true
                    }
                    
                    Text {
                        id: text52
                        x: 34
                        y: 60
                        color: "#c8c8c8"
                        text: qsTr("Segmentation")
                        font.pixelSize: 12
                        font.bold: true
                    }
                    
                    Text {
                        id: text53
                        x: 34
                        y: 86
                        color: "#c8c8c8"
                        text: qsTr("KeyPoint Ectraction (SIFT)")
                        font.pixelSize: 12
                        font.bold: true
                    }
                    
                    Rectangle {
                        id: rectangle40
                        x: 15
                        y: 11
                        width: 13
                        height: 13
                        color: "#00ffffff"
                        radius: 5
                        border.color: "#ffffff"
                        border.width: 2
                    }
                    
                    Rectangle {
                        id: rectangle46
                        x: 15
                        y: 36
                        width: 13
                        height: 13
                        color: "#00ffffff"
                        radius: 5
                        border.color: "#ffffff"
                        border.width: 2
                    }
                    
                    Rectangle {
                        id: rectangle47
                        x: 15
                        y: 62
                        width: 13
                        height: 13
                        color: "#00ffffff"
                        radius: 5
                        border.color: "#ffffff"
                        border.width: 2
                    }
                    
                    Rectangle {
                        id: rectangle48
                        x: 15
                        y: 88
                        width: 13
                        height: 13
                        color: "#00ffffff"
                        radius: 5
                        border.color: "#ffffff"
                        border.width: 2
                    }
                }
                
                AnimatedImage {
                    id: animatedImage2
                    x: 464
                    y: 36
                    width: 49
                    height: 50
                    opacity: 0
                    source: "Assets/icons8-chatbot-94.png"
                    fillMode: Image.Stretch
                }
                
                Rectangle {
                    id: rectangle44
                    x: 216
                    y: 34
                    width: 237
                    height: 57
                    opacity: 0
                    color: "#c681ec"
                    radius: 8
                    
                    Rectangle {
                        id: rectangle45
                        x: 230
                        y: 23
                        width: 11
                        height: 11
                        color: "#c983ef"
                        radius: 3
                        rotation: 45
                    }
                    Text {
                        id: text54
                        x: 9
                        y: 4
                        width: 216
                        height: 51
                        color: "#ffffff"
                        text: qsTr("Here, you have access to all the preprocessing methods for your selected model. Let's explore them together!")
                        font.pixelSize: 11
                        wrapMode: Text.WordWrap
                        font.bold: true
                    }
                }
                
                
            }
            
            Rectangle {
                id: rectangle27
                x: 35
                y: 492
                width: 524
                height: 193
                color: "#1a2431"
                radius: 12
                
                Image {
                    id: image29
                    x: 8
                    y: 8
                    width: 32
                    height: 30
                    source: "Assets/visualisation-de-donnees.png"
                    fillMode: Image.PreserveAspectFit
                }
                
                Text {
                    id: text39
                    x: 46
                    y: 14
                    color: "#f3f3f3"
                    text: qsTr("Let's Start")
                    font.pixelSize: 14
                    font.bold: true
                }
                
                Rectangle {
                    id: rectangle38
                    x: 117
                    y: 23
                    width: 388
                    height: 2
                    color: "#00ff1e"
                }
                
                Rectangle {
                    id: uploadbtn1
                    x: 411
                    y: 151
                    width: 105
                    height: 34
                    color: "#c681ec"
                    radius: 17
                    border.width: 0
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: "#45bdfa"
                        }
                        
                        GradientStop {
                            position: 1
                            color: "#db7bfa"
                        }
                        
                        GradientStop {
                            position: 0
                            color: "#45bdfa"
                        }
                        orientation: Gradient.Horizontal
                    }
                    Image {
                        id: image39
                        x: 72
                        y: 4
                        width: 24
                        height: 26
                        source: "Assets/icons8-upload-image-96.png"
                        fillMode: Image.PreserveAspectFit
                    }
                    
                    Text {
                        id: text63
                        x: 27
                        y: 7
                        color: "#f7f7f7"
                        text: qsTr("Start")
                        font.pixelSize: 14
                        font.bold: true
                    }

                    MouseArea {
                        id: gotopreprocess
                        x: 0
                        y: 0
                        width: 105
                        height: 34
                        onClicked: {
                            controller.switchmenu("preprocess",dashboard,config,preprocess,classification,aboutdev)
                        }
                    }
                }
                AnimatedImage {
                    id: animatedImage3
                    x: 466
                    y: 34
                    width: 49
                    height: 50
                    opacity: 0
                    source: "Assets/icons8-chatbot-94.png"
                    fillMode: Image.Stretch
                }
                
                Rectangle {
                    id: rectangle58
                    x: 228
                    y: 40
                    width: 228
                    height: 42
                    opacity: 0
                    color: "#c681ec"
                    radius: 8
                    Rectangle {
                        id: rectangle59
                        x: 220
                        y: 15
                        width: 11
                        height: 11
                        color: "#c983ef"
                        radius: 3
                        rotation: 45
                    }
                    
                    Text {
                        id: text64
                        x: 5
                        y: 4
                        width: 215
                        height: 37
                        color: "#ffffff"
                        text: qsTr("Here's an update on the selected model. Click 'start' and let me handle the process")
                        font.pixelSize: 11
                        wrapMode: Text.WordWrap
                        font.bold: true
                    }
                }
                
                Text {
                    id: text65
                    x: 31
                    y: 82
                    opacity: 0.8
                    color: "#c8c8c8"
                    text: qsTr("Model accuracy :")
                    font.pixelSize: 12
                    font.bold: true
                }
                
                Text {
                    id: text66
                    x: 31
                    y: 109
                    opacity: 0.8
                    color: "#c8c8c8"
                    text: qsTr("Preprocessing time :")
                    font.pixelSize: 12
                    font.bold: true
                }
                
                Text {
                    id: text67
                    x: 31
                    y: 137
                    opacity: 0.8
                    color: "#c8c8c8"
                    text: qsTr("Prediction time :")
                    font.pixelSize: 12
                    font.bold: true
                }
                
                Text {
                    id: text68
                    x: 31
                    y: 55
                    opacity: 0.8
                    color: "#c8c8c8"
                    text: qsTr("Model :")
                    font.pixelSize: 12
                    font.bold: true
                }
                
                Text {
                    id: statemodel
                    x: 80
                    y: 55
                    width: 118
                    height: 16
                    color: "#f324c6"
                    text: modeltitle
                    font.pixelSize: 12
                    font.bold: true
                }
                
                Text {
                    id: stateaccuracy
                    x: 132
                    y: 82
                    color: "#ffffff"
                    text: accuracymodel
                    font.pixelSize: 12
                    font.bold: true
                }
                
                Text {
                    id: statepreprocessing
                    x: 151
                    y: 109
                    color: "#ffffff"
                    text: timeprocessing
                    font.pixelSize: 12
                    font.bold: true
                }
                
                Text {
                    id: stateprediction
                    x: 132
                    y: 137
                    color: "#ffffff"
                    text: timeprediction
                    font.pixelSize: 12
                    font.bold: true
                }
            }
            
            Rectangle {
                id: rectangle28
                x: 576
                y: 301
                width: 368
                height: 384
                color: "#1a2431"
                radius: 12
                
                Text {
                    id: text37
                    x: 53
                    y: 15
                    color: "#f3f3f3"
                    text: qsTr("Visualization")
                    font.pixelSize: 14
                    font.bold: true
                }
                
                Image {
                    id: image27
                    x: 8
                    y: 8
                    width: 39
                    height: 33
                    source: "Assets/image.png"
                    fillMode: Image.PreserveAspectFit
                }
                
                Rectangle {
                    id: rectangle37
                    x: 143
                    y: 24
                    width: 211
                    height: 2
                    color: "#14aad6"
                }

                Rectangle {
                    id: rectangle43
                    x: 29
                    y: 63
                    width: 311
                    height: 303
                    color: "#00ffffff"
                    border.color: "#14aad6"
                    border.width: 0
                    clip: true

                    Image {
                        id: image37
                        x: 0
                        y: 0
                        width: 311
                        height: 303
                        source: "Assets/grid.png"
                        fillMode: Image.PreserveAspectFit
                        clip: true
                        transformOrigin: Item.Center
                        smooth: true
                        property real zoomFactor: 1.0

                        function changeZoom(factor) {
                            zoomFactor *= factor;
                            // Assurez-vous que le zoom ne devient pas trop petit ou trop grand
                            zoomFactor = Math.min(5.0, Math.max(0.1, zoomFactor));
                            // Mettez à jour le facteur de zoom pour l'image
                            scale = zoomFactor;
                        }

                        MouseArea {
                            anchors.fill: parent
                            anchors.rightMargin: 15
                            clip: true
                            // Gestion du zoom/dézoom lorsque la molette de la souris est déplacée
                            onWheel: {
                                if (wheel.angleDelta.y > 0) {
                                    // Zoom in
                                    image37.changeZoom(1.1);
                                } else {
                                    // Zoom out
                                    image37.changeZoom(0.9);
                                }
                            }
                        }
                        Image {
                            id: image59
                            x: 53
                            y: 50
                            width: 205
                            height: 203
                            source: rawimage
                            fillMode: Image.PreserveAspectFit
                            clip: true
                            antialiasing: true
                            activeFocusOnTab: true
                            focus: true
                            autoTransform: true
                            scale: 1
                            MouseArea {
                                anchors.fill: parent
                                anchors.leftMargin: -5
                                anchors.bottomMargin: 26
                                drag.target: image59

                                onPressed: {
                                    drag.active = true
                                    drag.origin.x = image59.x
                                    drag.origin.y = image59.y
                                }

                                onPositionChanged: {
                                    // Déplacer l'image en fonction du mouvement de la souris
                                    if (drag.active) {
                                        image59.x = drag.origin.x + (mouseX - drag.startX)
                                        image59.y = drag.origin.y + (mouseY - drag.startY)
                                    }
                                }

                                onReleased: {
                                    drag.active = false
                                }
                            }

                        }
                    }
                }

                Rectangle {
                    id: rectangle75
                    x: 24
                    y: 56
                    width: 321
                    height: 315
                    color: "#0014aad6"
                    border.color: "#14aad6"
                    border.width: 2
                }
            }

            Rectangle {
                id: selectconfig
                x: -63
                y: 270
                width: 40
                height: 40
                opacity: 1
                color: "#c983ef"
                radius: 10
                rotation: 45
            }
            
        }
        Rectangle {
            id: dashboard
            x: 90
            y: 0
            width: 990
            height: 720
            color: "#111a25"
            radius: 25
            visible : True

            Rectangle {
                id: rectangle3
                x: 35
                y: 212
                width: 919
                height: 162
                color: "#1a2431"
                radius: 12
                
                Text {
                    id: text5
                    x: 22
                    y: 17
                    width: 175
                    height: 23
                    color: "#ffffff"
                    text: qsTr("Welcome to Vision ID !")
                    font.pixelSize: 16
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                }
                
                AnimatedImage {
                    id: animatedImage
                    x: 709
                    y: -33
                    width: 192
                    height: 206
                    source: "Assets/network-robot-assistant-working-on-laptop.gif"
                }
                
                Image {
                    id: image5
                    x: 196
                    y: 5
                    width: 43
                    height: 44
                    source: "Assets/icons8-bombe-de-table-64.png"
                    fillMode: Image.PreserveAspectFit
                }
                
                Text {
                    id: text10
                    x: 22
                    y: 55
                    width: 653
                    height: 81
                    color: "#ffffff"
                    text: "VisionID transforme votre regard en clé d'identification. Grâce au Deep Learning et à la Computer Vision, il capture les détails uniques de votre iris pour une reconnaissance ultra-précise et instantanée. Sécurisez vos espaces et vos données avec cette technologie futuriste. Vos yeux, votre monde."
                    font.pixelSize: 14
                    wrapMode: Text.WordWrap
                    font.bold: true
                }
            }
            
            Rectangle {
                id: rectangle5
                x: 35
                y: 389
                width: 919
                height: 300
                color: "#1a2431"
                radius: 12
                baselineOffset: 1
                
                Text {
                    id: text11
                    x: 23
                    y: 13
                    color: "#ffffff"
                    text: qsTr("Models")
                    font.pixelSize: 16
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                }
                
                Image {
                    id: image6
                    x: 862
                    y: 5
                    width: 52
                    height: 43
                    source: "Assets/icons8-model-64.png"
                    fillMode: Image.PreserveAspectFit
                }
                
                Rectangle {
                    id: rectangle4
                    x: 89
                    y: 25
                    width: 771
                    height: 2
                    color: "#b2b2b2"
                }
                
                Rectangle {
                    id: rectangle10
                    x: 14
                    y: 58
                    width: 889
                    height: 32
                    color: "#3e4afa"
                    radius: 6
                    
                    Text {
                        id: text12
                        x: 83
                        y: 5
                        color: "#ffffff"
                        text: qsTr("Name")
                        font.pixelSize: 14
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                    }
                    
                    Image {
                        id: image7
                        x: 64
                        y: 8
                        width: 15
                        height: 15
                        source: "Assets/icons8-chevron-bas-64.png"
                        fillMode: Image.PreserveAspectFit
                    }
                    
                    Text {
                        id: text13
                        x: 289
                        y: 5
                        color: "#ffffff"
                        text: qsTr("Type")
                        font.pixelSize: 14
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                    }
                    
                    Image {
                        id: image8
                        x: 270
                        y: 8
                        width: 15
                        height: 15
                        source: "Assets/icons8-chevron-bas-64.png"
                        fillMode: Image.PreserveAspectFit
                    }
                    
                    Text {
                        id: text14
                        x: 454
                        y: 5
                        color: "#ffffff"
                        text: qsTr("Date")
                        font.pixelSize: 14
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                    }
                    
                    Image {
                        id: image9
                        x: 435
                        y: 8
                        width: 15
                        height: 15
                        source: "Assets/icons8-chevron-bas-64.png"
                        fillMode: Image.PreserveAspectFit
                    }
                    
                    Text {
                        id: text15
                        x: 630
                        y: 5
                        color: "#ffffff"
                        text: qsTr("Status")
                        font.pixelSize: 14
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                    }
                    
                    Image {
                        id: image10
                        x: 611
                        y: 8
                        width: 15
                        height: 15
                        source: "Assets/icons8-chevron-bas-64.png"
                        fillMode: Image.PreserveAspectFit
                    }
                    
                    Text {
                        id: text17
                        x: 790
                        y: 5
                        color: "#ffffff"
                        text: qsTr("precision")
                        font.pixelSize: 14
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                    }
                    
                    Image {
                        id: image12
                        x: 771
                        y: 8
                        width: 15
                        height: 15
                        source: "Assets/icons8-chevron-bas-64.png"
                        fillMode: Image.PreserveAspectFit
                    }
                }
                
                Rectangle {
                    id: rectangle11
                    x: 14
                    y: 106
                    width: 889
                    height: 51
                    color: "#151c26"
                    radius: 9
                    
                    Text {
                        id: text16
                        x: 46
                        y: 17
                        opacity: 0.9
                        color: "#d1d1d1"
                        text: qsTr("Conv Neural Network")
                        font.pixelSize: 13
                        font.bold: true
                    }
                    
                    Text {
                        id: text20
                        x: 257
                        y: 17
                        opacity: 0.9
                        color: "#d1d1d1"
                        text: qsTr("Deeplearning")
                        font.pixelSize: 13
                        font.bold: true
                    }
                    
                    Text {
                        id: text23
                        x: 439
                        y: 17
                        opacity: 0.9
                        color: "#d1d1d1"
                        text: qsTr("12/05/2024")
                        font.pixelSize: 13
                        font.bold: true
                    }
                    
                    Text {
                        id: text26
                        x: 617
                        y: 17
                        opacity: 0.8
                        color: "#0fff00"
                        text: qsTr("Disponible")
                        font.pixelSize: 13
                        font.bold: true
                    }
                    
                    Rectangle {
                        id: rectangle14
                        x: 601
                        y: 22
                        width: 10
                        height: 10
                        color: "#0fff00"
                        radius: 6
                    }
                    
                    Rectangle {
                        id: rectangle17
                        x: 777
                        y: 25
                        width: 97
                        height: 3
                        color: "#aaacae"
                        radius: 2
                    }
                    
                    Text {
                        id: text29
                        x: 742
                        y: 17
                        opacity: 0.9
                        color: "#d1d1d1"
                        text: qsTr("97%")
                        font.pixelSize: 13
                        font.bold: true
                    }
                    
                    Rectangle {
                        id: rectangle20
                        x: 777
                        y: 25
                        width: 90
                        height: 3
                        color: "#aaacae"
                        radius: 2
                        border.color: "#ff1010"
                    }
                    
                    Image {
                        id: image11
                        x: 8
                        y: 10
                        width: 32
                        height: 31
                        source: "Assets/NEURALNETWORK.png"
                        fillMode: Image.PreserveAspectFit
                    }
                    
                    Image {
                        id: image15
                        x: 401
                        y: 9
                        width: 38
                        height: 34
                        source: "Assets/icons8-calendrier-48.png"
                        fillMode: Image.PreserveAspectFit
                    }
                }
                
                Rectangle {
                    id: rectangle12
                    x: 14
                    y: 169
                    width: 889
                    height: 51
                    color: "#151c26"
                    radius: 9
                    
                    Text {
                        id: text18
                        x: 46
                        y: 17
                        width: 152
                        height: 18
                        opacity: 0.9
                        color: "#d1d1d1"
                        text: qsTr("Gabor , Neural Network")
                        font.pixelSize: 13
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                    }
                    
                    Text {
                        id: text21
                        x: 257
                        y: 17
                        width: 88
                        height: 18
                        opacity: 0.9
                        color: "#d1d1d1"
                        text: qsTr("Deeplearning")
                        font.pixelSize: 13
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                    }
                    
                    Text {
                        id: text24
                        x: 439
                        y: 17
                        width: 88
                        height: 18
                        opacity: 0.9
                        color: "#d1d1d1"
                        text: qsTr("12/05/2024")
                        font.pixelSize: 13
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                    }
                    
                    Text {
                        id: text27
                        x: 617
                        y: 17
                        width: 72
                        height: 18
                        opacity: 0.8
                        color: "#0fff00"
                        text: qsTr("Disponible")
                        font.pixelSize: 13
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                    }
                    
                    Rectangle {
                        id: rectangle15
                        x: 601
                        y: 22
                        width: 10
                        height: 10
                        color: "#0fff00"
                        radius: 5
                    }
                    
                    Text {
                        id: text30
                        x: 742
                        y: 17
                        width: 29
                        height: 18
                        opacity: 0.9
                        color: "#6977ef"
                        text: qsTr("92%")
                        font.pixelSize: 13
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                    }
                    
                    Rectangle {
                        id: rectangle18
                        x: 777
                        y: 25
                        width: 97
                        height: 4
                        color: "#aaacae"
                        radius: 2
                    }
                    
                    Rectangle {
                        id: rectangle21
                        x: 777
                        y: 25
                        width: 88
                        height: 4
                        color: "#303cad"
                        radius: 2
                    }
                    
                    Image {
                        id: image13
                        x: 8
                        y: 10
                        width: 32
                        height: 31
                        source: "Assets/NEURALNETWORK.png"
                        fillMode: Image.PreserveAspectFit
                    }
                    
                    Image {
                        id: image16
                        x: 401
                        y: 9
                        width: 38
                        height: 34
                        source: "Assets/icons8-calendrier-48.png"
                        fillMode: Image.PreserveAspectFit
                    }
                }
                
                Rectangle {
                    id: rectangle13
                    x: 14
                    y: 233
                    width: 889
                    height: 51
                    color: "#151c26"
                    radius: 9
                    
                    Text {
                        id: text19
                        x: 46
                        y: 17
                        width: 138
                        height: 19
                        opacity: 0.9
                        color: "#d1d1d1"
                        text: qsTr("SIFT + Classification")
                        font.pixelSize: 13
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                    }
                    
                    Text {
                        id: text22
                        x: 257
                        y: 17
                        width: 119
                        height: 19
                        opacity: 0.9
                        color: "#d1d1d1"
                        text: qsTr("Computer Vision")
                        font.pixelSize: 13
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                    }
                    
                    Text {
                        id: text25
                        x: 439
                        y: 17
                        width: 79
                        height: 19
                        opacity: 0.9
                        color: "#d1d1d1"
                        text: qsTr("13/05/2024")
                        font.pixelSize: 13
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                    }
                    
                    Text {
                        id: text28
                        x: 617
                        y: 17
                        width: 73
                        height: 19
                        opacity: 0.8
                        color: "#0fff00"
                        text: qsTr("Disponible")
                        font.pixelSize: 13
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                    }
                    
                    Rectangle {
                        id: rectangle16
                        x: 601
                        y: 22
                        width: 10
                        height: 10
                        color: "#0fff00"
                        radius: 5
                    }
                    
                    Text {
                        id: text31
                        x: 740
                        y: 17
                        width: 29
                        height: 18
                        opacity: 0.9
                        color: "#fe2bf5"
                        text: qsTr("98%")
                        font.pixelSize: 13
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                    }
                    
                    Rectangle {
                        id: rectangle19
                        x: 777
                        y: 25
                        width: 97
                        height: 3
                        color: "#aaacae"
                        radius: 2
                    }
                    
                    Rectangle {
                        id: rectangle22
                        x: 777
                        y: 25
                        width: 94
                        height: 3
                        color: "#fe2bf5"
                        radius: 2
                    }
                    
                    Image {
                        id: image14
                        x: 7
                        y: 10
                        width: 32
                        height: 32
                        source: "Assets/icons8-vision-48.png"
                        fillMode: Image.PreserveAspectFit
                    }
                    
                    Image {
                        id: image17
                        x: 401
                        y: 9
                        width: 38
                        height: 34
                        source: "Assets/icons8-calendrier-48.png"
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }
            
            Rectangle {
                id: rectangle6
                x: 35
                y: 68
                width: 221
                height: 132
                color: "#1a2431"
                radius: 12
                clip: true
                focus: true
                transformOrigin: Item.Center
                
                Text {
                    id: text1
                    x: 48
                    y: 12
                    width: 140
                    height: 25
                    color: "#ffffff"
                    text: qsTr("Conv Neural Network")
                    font.pixelSize: 14
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                }
                
                Image {
                    id: image1
                    x: 7
                    y: 1
                    width: 38
                    height: 48
                    source: "Assets/icons8-algorithm-64.png"
                    fillMode: Image.PreserveAspectFit
                }
                
                Text {
                    id: text32
                    x: 171
                    y: 96
                    color: "#f51648"
                    text: qsTr("97%")
                    font.pixelSize: 21
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                }
            }
            
            Rectangle {
                id: rectangle7
                x: 268
                y: 68
                width: 221
                height: 132
                color: "#1a2431"
                radius: 12
                activeFocusOnTab: true
                focus: true
                
                
                Text {
                    id: text2
                    x: 48
                    y: 12
                    width: 156
                    height: 25
                    color: "#ffffff"
                    text: qsTr("Gabor + Neural Network")
                    font.pixelSize: 14
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                }
                Image {
                    id: image2
                    x: 5
                    y: 1
                    width: 38
                    height: 48
                    opacity: 0.9
                    source: "Assets/GABOR.png"
                    scale: 0.9
                    fillMode: Image.PreserveAspectFit
                }
                
                Image {
                    id: image19
                    x: -1
                    y: 52
                    width: 222
                    height: 66
                    source: "Assets/Capture d'écran 2024-05-15 060640.png"
                    rotation: -8
                    fillMode: Image.PreserveAspectFit
                }
                
                Text {
                    id: text33
                    x: 171
                    y: 96
                    color: "#5864c8"
                    text: qsTr("92%")
                    font.pixelSize: 21
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                }
            }
            
            Rectangle {
                id: rectangle8
                x: 501
                y: 68
                width: 221
                height: 132
                color: "#1a2431"
                radius: 12
                
                Image {
                    id: image3
                    x: 7
                    y: 1
                    width: 38
                    height: 48
                    opacity: 0.9
                    source: "Assets/icons8-filtration-48.png"
                    fillMode: Image.PreserveAspectFit
                }
                
                Text {
                    id: text3
                    x: 51
                    y: 12
                    width: 156
                    height: 25
                    color: "#ffffff"
                    text: qsTr("SIFT + Classification")
                    font.pixelSize: 14
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                }
                
                Image {
                    id: image20
                    x: 4
                    y: 47
                    width: 213
                    height: 77
                    source: "Assets/LIN.png"
                    fillMode: Image.PreserveAspectFit
                }
                
                Text {
                    id: text34
                    x: 171
                    y: 96
                    color: "#fe2bf5"
                    text: qsTr("98%")
                    font.pixelSize: 21
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                }
            }
            
            Rectangle {
                id: rectangle9
                x: 734
                y: 68
                width: 221
                height: 132
                color: "#1a2431"
                radius: 12
                gradient: Gradient {
                    GradientStop {
                        position: 1
                        color: "#37d0d6"
                    }
                    
                    GradientStop {
                        position: 0
                        color: "#d67ef2"
                    }
                    orientation: Gradient.Horizontal
                }
                
                Image {
                    id: image4
                    x: 8
                    y: 4
                    width: 38
                    height: 40
                    source: "Assets/dataset.png"
                    fillMode: Image.PreserveAspectFit
                }
                
                Text {
                    id: text4
                    x: 52
                    y: 10
                    width: 62
                    height: 25
                    color: "#ffffff"
                    text: qsTr("DataSet")
                    font.pixelSize: 14
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                }
                
                Text {
                    id: text6
                    x: 12
                    y: 58
                    color: "#ffffff"
                    text: qsTr("CASIA-Iris-Lamp V1.0")
                    font.pixelSize: 15
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                }
                
                Text {
                    id: text7
                    x: 116
                    y: 96
                    color: "#ffffff"
                    text: qsTr("650")
                    font.pixelSize: 21
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                }
                
                Text {
                    id: text8
                    x: 156
                    y: 104
                    color: "#ffffff"
                    text: qsTr("Samples")
                    font.pixelSize: 13
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                }
                
                Text {
                    id: text9
                    x: 183
                    y: 7
                    color: "#ffffff"
                    text: qsTr("65")
                    font.pixelSize: 21
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                }
            }
            
            Image {
                id: image18
                x: 35
                y: 127
                width: 221
                height: 52
                source: "Assets/Capture d'écran 2024-05-15 055622.png"
                rotation: -7
                fillMode: Image.PreserveAspectFit
            }
            
            Rectangle {
                id: rectangle23
                x: 20
                y: 102
                width: 16
                height: 104
                color: "#111a25"
            }
            
            Rectangle {
                id: rectangle24
                x: 253
                y: 61
                width: 15
                height: 145
                color: "#111a25"
            }
            
            Rectangle {
                id: rectangle25
                x: 487
                y: 61
                width: 15
                height: 145
                color: "#111a25"
            }
            
            Rectangle {
                id: rectangle31
                x: -8
                y: 207
                width: 22
                height: 22
                color: "#111a25"
                radius: 3
                border.width: 0
                rotation: 45
            }
            
            Text {
                id: text35
                x: 35
                y: 12
                color: "#e4e4e4"
                text: qsTr("Dashboard")
                font.pixelSize: 26
                verticalAlignment: Text.AlignVCenter
                font.bold: true
            }

            Rectangle {
                id: selectdashboard
                x: -63
                y: 198
                width: 40
                height: 40
                opacity: 1
                color: "#c983ef"
                radius: 10
                rotation: 45
            }
            
        }
        


        Rectangle {
            id: close
            x: 1042
            y: 14
            width: 16
            height: 16
            color: "#fc2121"
            radius: 8
            MouseArea {
                id: mouseclose
                anchors.fill: parent
                onClicked: {
                    controller.quit_application()
                }
            }
        }
        Rectangle {
            id: reduire
            x: 998
            y: 14
            width: 16
            height: 16
            color: "#0fff00"
            radius: 8
        }
        Rectangle {
            id: agrandir
            x: 1020
            y: 14
            width: 16
            height: 16
            color: "#ff8d00"
            radius: 8
        }
        Rectangle {
            id: rectangle2
            x: 450
            y: 13
            width: 270
            height: 5
            color: "#ae88f0"
            radius: 4
        }
        
        Image {
            id: image22
            x: 31
            y: 272
            width: 32
            height: 35
            source: "Assets/icons8-add-image-64.png"
            fillMode: Image.PreserveAspectFit
        }
        Image {
            id: image25
            x: 32
            y: 493
            width: 30
            height: 32
            source: "Assets/icons8-planning-a-new-software-programing-strategy-presentation-48.png"
            fillMode: Image.PreserveAspectFit
        }
        Image {
            id: image24
            x: 31
            y: 416
            width: 31
            height: 32
            source: "Assets/structure.png"
            fillMode: Image.PreserveAspectFit
        }
        Image {
            id: image23
            x: 31
            y: 344
            width: 32
            height: 35
            source: "Assets/icons8-tasks-60.png"
            sourceSize.height: 100
            sourceSize.width: 100
            fillMode: Image.PreserveAspectFit
        }
        Image {
            id: image21
            x: 31
            y: 200
            width: 32
            height: 35
            source: "Assets/icons8-dashboard-layout-96.png"
            sourceSize.height: 35
            sourceSize.width: 32
            fillMode: Image.PreserveAspectFit
        }
        Image {
            id: image
            x: 8
            y: -12
            width: 71
            height: 93
            source: "Assets/icone.png"
            fillMode: Image.PreserveAspectFit
        }

        MouseArea {
            id: mousedashboard
            x: 23
            y: 192
            width: 48
            height: 51
            onClicked: {
                controller.switchmenu("dashboard",dashboard,config,preprocess,classification,aboutdev)
            }
        }

        MouseArea {
            id: mouseconfig
            x: 23
            y: 264
            width: 48
            height: 51
            onClicked: {
                controller.switchmenu("config",dashboard,config,preprocess,classification,aboutdev)
            }
        }

        MouseArea {
            id: mousepreprocess
            x: 23
            y: 335
            width: 48
            height: 51
            onClicked: {
                controller.switchmenu("preprocess",dashboard,config,preprocess,classification,aboutdev)
            }
        }

        MouseArea {
            id: mouseclassification
            x: 23
            y: 407
            width: 48
            height: 51
            onClicked: {
                controller.switchmenu("classification",dashboard,config,preprocess,classification,aboutdev)
            }
        }

        MouseArea {
            id: mouseaboutdev
            x: 23
            y: 484
            width: 48
            height: 51
            onClicked: {
                controller.switchmenu("aboutdev",dashboard,config,preprocess,classification,aboutdev)
            }
        }


    }
    function startFadeOutAnimation() {
        var animation = Qt.createQmlObject('import QtQuick 2.15; ParallelAnimation { PropertyAnimation { target: rectangle41; property: "opacity"; to: 0; duration: 2000; easing.type: Easing.InOutQuad } PropertyAnimation { target: animatedImage1; property: "opacity"; to: 0; duration: 2000; easing.type: Easing.InOutQuad } }', parent);
        animation.start();
    }
    function startFadeInAnimation2() {
        var animation = Qt.createQmlObject('import QtQuick 2.15; ParallelAnimation { PropertyAnimation { target: rectangle44; property: "opacity"; to: 1; duration: 2000; easing.type: Easing.InOutQuad } PropertyAnimation { target: animatedImage2; property: "opacity"; to: 1; duration: 2000; easing.type: Easing.InOutQuad } }', parent);
        animation.start();
    }
    function startFadeInAnimation3() {
        var animation = Qt.createQmlObject('import QtQuick 2.15; ParallelAnimation { PropertyAnimation { target: rectangle58; property: "opacity"; to: 1; duration: 2000; easing.type: Easing.InOutQuad } PropertyAnimation { target: animatedImage3; property: "opacity"; to: 1; duration: 2000; easing.type: Easing.InOutQuad } }', parent);
        animation.start();
    }
    function startFadeOutAnimation4() {
        var animation = Qt.createQmlObject('import QtQuick 2.15; ParallelAnimation { PropertyAnimation { target: rectangle61; property: "opacity"; to: 0; duration: 2000; easing.type: Easing.InOutQuad } PropertyAnimation { target: animatedImage4; property: "opacity"; to: 0; duration: 2000; easing.type: Easing.InOutQuad } }', parent);
        animation.start();
    }
    function startFadeInAnimation4() {
        var animation = Qt.createQmlObject('import QtQuick 2.15; ParallelAnimation { PropertyAnimation { target: rectangle61; property: "opacity"; to: 1; duration: 2000; easing.type: Easing.InOutQuad } PropertyAnimation { target: animatedImage4; property: "opacity"; to: 1; duration: 2000; easing.type: Easing.InOutQuad } }', parent);
        animation.start();
    }
}

/*##^##
Designer {
    D{i:0}D{i:3;invisible:true}D{i:80;invisible:true}D{i:267;invisible:true}
}
##^##*/
