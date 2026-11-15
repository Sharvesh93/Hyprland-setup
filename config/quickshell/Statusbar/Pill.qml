import QtQuick
import QtQuick.Layouts


Rectangle {
    id : root 

    
    property string icon: ""
    property string label: ""
    property color iconColor: "#3dd1b0"
    property int maxLabelWidth : 400 

    implicitWidth : row.implicitWidth + 22
    implicitHeight : 23
    radius: height /2 
    color:"#040e0d"

    RowLayout{
      id : row
      anchors.cneterIn:parent
      spacing: 7

      Text {
        text:root.icon  
        color: root.iconColor
        font.family : "Iosevka Nerd Font"
        font.pixelSize : 16
      }
      Text {
        text: root.label
        color:"#f5e2c5"
        font.family : "Iosevka Nerd Font"
        font.pixelSize:16
        elide: Text.ElideRight 
        Layout.maximumWidth : root.maxLabelWidth 
        viisible : root.label!==""
            
      }
    }
}
