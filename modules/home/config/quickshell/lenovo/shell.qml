import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

ShellRoot {
    id: root

    // Kanagawa Theme colors
    property color colBg: "#171717"       // base
    property color colFg: "#DCD7BA"       // text
    property color colMuted: "#54546d"    // overlay0
    property color colPurple: "#9c86bf"   // lavender
    property color colBlue: "#7e9cd8"      // blue

    // Waybar specific Kanagawa colors
    property color wbRed: "#d8616b"       // red
    property color wbPeach: "#ffa066"     // test
    property color wbPurple: "#9c86bf"    // mauve
    property color wbGreen: "#98bb6c"     // green
    property color wbBlue: "#7e9cd8"      // blue
    property color wbCrit: "#d27e99"      // flamingo (for critical states)
    property color wbYellow: "#dca561"    // yellow

    // Font
    property string fontFamily: "MesloLGS Nerd Font Mono Bold"
    property int fontSize: 13

    // System info properties
    property int cpuUsage: 0
    property string gpuUsage: "0"
    property int volumeLevel: 0
    property bool isMuted: false
    property int batteryCapacity: 100
    property string batteryStatus: "Discharging"
    property string networkEssid: "Disconnected"
    property string networkType: "none"

    // CPU tracking state
    property var lastCpuIdle: 0
    property var lastCpuTotal: 0

    // --- Processes ---

    // CPU usage
    Process {
        id: cpuProc
        command: ["sh", "-c", "head -1 /proc/stat"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var parts = data.trim().split(/\s+/)
                var user = parseInt(parts[1]) || 0
                var nice = parseInt(parts[2]) || 0
                var system = parseInt(parts[3]) || 0
                var idle = parseInt(parts[4]) || 0
                var iowait = parseInt(parts[5]) || 0
                var irq = parseInt(parts[6]) || 0
                var softirq = parseInt(parts[7]) || 0

                var total = user + nice + system + idle + iowait + irq + softirq
                var idleTime = idle + iowait

                if (lastCpuTotal > 0) {
                    var totalDiff = total - lastCpuTotal
                    var idleDiff = idleTime - lastCpuIdle
                    if (totalDiff > 0) {
                        cpuUsage = Math.round(100 * (totalDiff - idleDiff) / totalDiff)
                    }
                }
                lastCpuTotal = total
                lastCpuIdle = idleTime
            }
        }
        Component.onCompleted: running = true
    }

    // GPU utilization (nvidia-smi)
    Process {
        id: gpuProc
        command: ["sh", "-c", "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits || echo 0"]
        stdout: SplitParser {
            onRead: data => {
                if (data) gpuUsage = data.trim()
            }
        }
        Component.onCompleted: running = true
    }

    // Battery capacity & status
    Process {
        id: batProc
        command: ["sh", "-c", "echo $(cat /sys/class/power_supply/BAT*/capacity | head -1) $(cat /sys/class/power_supply/BAT*/status | head -1)"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var parts = data.trim().split(/\s+/)
                if (parts.length >= 2) {
                    batteryCapacity = parseInt(parts[0]) || 0
                    batteryStatus = parts[1]
                }
            }
        }
        Component.onCompleted: running = true
    }

    // Network connection (SSID or Ethernet state)
    Process {
        id: netProc
        command: ["sh", "-c", "nmcli -t -f TYPE,STATE,CONNECTION dev | grep 'connected' | head -n 1"]
        stdout: SplitParser {
            onRead: data => {
                if (data) {
                    var parts = data.trim().split(':')
                    if (parts.length >= 3) {
                        networkType = parts[0]
                        // slice and join fixes issues if your SSID happens to contain a colon
                        networkEssid = parts.slice(2).join(':') 
                    }
                } else {
                    networkType = "none"
                    networkEssid = "Disconnected"
                }
            }
        }
        Component.onCompleted: running = true
    }

    // Volume level (wpctl for PipeWire)
    Process {
        id: volProc
        command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                isMuted = data.indexOf("[MUTED]") !== -1
                var match = data.match(/Volume:\s*([\d.]+)/)
                if (match) {
                    volumeLevel = Math.round(parseFloat(match[1]) * 100)
                }
            }
        }
        Component.onCompleted: running = true
    }

    // Global poll timer
    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            cpuProc.running = true
            gpuProc.running = true
            batProc.running = true
            netProc.running = true
        }
    }

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            volProc.running = true
        }
    }

    // Helper Functions for Icons
    function getAudioIcon() {
        if (isMuted || volumeLevel === 0) return "  "
        if (volumeLevel < 33) return " "
        if (volumeLevel < 66) return " "
        return "  "
    }

    function getBatteryIcon() {
        if (batteryStatus === "Charging" || batteryStatus === "Full") return " "
        if (batteryCapacity > 80) return " "
        if (batteryCapacity > 60) return " "
        if (batteryCapacity > 40) return " "
        if (batteryCapacity > 20) return " "
        return " "
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 30
            color: root.colBg

            Rectangle {
                anchors.fill: parent
                color: root.colBg

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 0
                    spacing: 0

                    // ==========================================
                    // MODULES LEFT
                    // ==========================================
                    RowLayout {
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                        Layout.leftMargin: 8
                        spacing: 8

                        Repeater {
                            model: 10

                            Rectangle {
                                Layout.preferredWidth: 20
                                Layout.preferredHeight: 30 // match bar height
                                color: "transparent"

                                property var workspace: Hyprland.workspaces.values.find(ws => ws.id === index + 1) ?? null
                                property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                                property bool hasWindows: workspace !== null

                                Text {
                                    text: index + 1
                                    color: parent.isActive ? root.colPurple : (parent.hasWindows ? root.colBlue : root.colMuted)
                                    font.pixelSize: root.fontSize
                                    font.family: root.fontFamily
                                    font.bold: true
                                    anchors.centerIn: parent
                                }

                                Rectangle {
                                    width: 20
                                    height: 3
                                    color: parent.isActive ? root.colPurple : "transparent"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.bottom: parent.bottom
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: Hyprland.dispatch("workspace " + (index + 1))
                                }
                            }
                        }
                    }

                    // ==========================================
                    // CENTER EXPANDING SPACER
                    // ==========================================
                    Item {
                        Layout.fillWidth: true
                    }

                    // ==========================================
                    // MODULES RIGHT
                    // ==========================================
                    RowLayout {
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        Layout.rightMargin: 12
                        spacing: 16 // Gap between different modules

                        // Network
                        RowLayout {
                            spacing: 6
                            Text {
                                text: (root.networkType === "wifi" || root.networkType === "802-11-wireless") ? "  " : ((root.networkType === "ethernet" || root.networkType === "802-3-ethernet") ? "󰈀 " : " ")
                                color: root.wbYellow
                                font.pixelSize: root.fontSize
                                font.family: root.fontFamily
                            }
                            Text {
                                text: root.networkEssid
                                color: root.wbYellow
                                font.pixelSize: root.fontSize
                                font.family: root.fontFamily
                                font.bold: true
                            }
                        }

                        // PulseAudio
                        RowLayout {
                            spacing: 6
                            Text {
                                text: getAudioIcon()
                                color: root.wbGreen
                                font.pixelSize: root.fontSize
                                font.family: root.fontFamily
                            }
                            Text {
                                text: (root.isMuted ? "0" : root.volumeLevel) + "%"
                                color: root.wbGreen
                                font.pixelSize: root.fontSize
                                font.family: root.fontFamily
                                font.bold: true
                            }
                        }

                        // Battery
                        RowLayout {
                            spacing: 6
                            Text {
                                text: getBatteryIcon()
                                color: root.batteryCapacity <= 15 && root.batteryStatus !== "Charging" ? root.wbCrit : root.wbBlue
                                font.pixelSize: root.fontSize
                                font.family: root.fontFamily
                            }
                            Text {
                                text: root.batteryCapacity + "%"
                                color: root.batteryCapacity <= 15 && root.batteryStatus !== "Charging" ? root.wbCrit : root.wbBlue
                                font.pixelSize: root.fontSize
                                font.family: root.fontFamily
                                font.bold: true
                            }
                        }

                        // CPU
                        RowLayout {
                            spacing: 8
                            Text {
                                text: " "
                                color: root.wbPurple
                                font.pixelSize: root.fontSize
                                font.family: root.fontFamily
                            }
                            Text {
                                text: root.cpuUsage + "%"
                                color: root.wbPurple
                                font.pixelSize: root.fontSize
                                font.family: root.fontFamily
                                font.bold: true
                            }
                        }

                        // GPU
                        RowLayout {
                            spacing: 8
                            Text {
                                text: "󰢮 "
                                color: root.wbPurple
                                font.pixelSize: root.fontSize
                                font.family: root.fontFamily
                            }
                            Text {
                                text: root.gpuUsage + "%"
                                color: root.wbPurple
                                font.pixelSize: root.fontSize
                                font.family: root.fontFamily
                                font.bold: true
                            }
                        }

                        // Clock
                        RowLayout {
                            spacing: 6
                            Text {
                                text: " "
                                color: root.wbRed
                                font.pixelSize: root.fontSize
                                font.family: root.fontFamily
                            }
                            Text {
                                id: clockText
                                text: Qt.formatDateTime(new Date(), "ddd dd HH:mm")
                                color: root.wbRed
                                font.pixelSize: root.fontSize
                                font.family: root.fontFamily
                                font.bold: true

                                Timer {
                                    interval: 1000
                                    running: true
                                    repeat: true
                                    onTriggered: clockText.text = Qt.formatDateTime(new Date(), "ddd dd HH:mm")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
