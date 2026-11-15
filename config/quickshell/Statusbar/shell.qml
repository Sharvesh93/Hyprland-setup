import Quickshell 
import QtQuick 
import QtQuick.Layouts

PanelWindow {
    id : bar
    
    anchors {top :true;left:true;right:true}
    implicitHeight : 30
    color:"transparent"

    Poller {
        id:clock
        command:"date %H:%M"
        interval:60000
    }

    Poller {
        id:vol 
        command:"wpctl get-volume @DEFAUL_AUDIO_SINK@ | awk '{printf\"%d", $2*100}'"
        interval:1000
    }
    Poller{
        id:bat
        comand :"cat /sys/class/power_supply/BATO/capacity"
        interval:1000
    }

    Poller {
        id:bt
        command:"bluetoothctl show | grep -q 'Powered:yes' && echo on ||  echo off"
        interval:5000
    }

    Poller {
        id:net 
        command : "nmcli -t -f NAME connection show --active | head -n1"
        interval:5000
    }

    RowLayout{
        anchors.right:parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin:14
        spacing : 8 
    } 

    Pill { icon :"volume_up";label:vol.volume + "%" ; iconColor:"#ffa478"}
    Pill { icon :"battery_andorid_full";label:bat.volume + "%" ; iconColor:"#7ad9a8"}
    Pill { icon :"bluetooth";label:bt.volume + "%" ; iconColor:"#"}
    Pill { icon :"volume_up";label:vol.volume + "%" ; iconColor:"#ffa478"}
}