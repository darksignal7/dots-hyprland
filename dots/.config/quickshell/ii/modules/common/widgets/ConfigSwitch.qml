import qs.modules.common.widgets
import qs.modules.common
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

RippleButton {
    id: root
    property string buttonIcon
    property alias iconSize: iconWidget.iconSize

    Layout.fillWidth: true
    implicitHeight: contentItem.implicitHeight + 8 * 2
    font.pixelSize: Appearance.font.pixelSize.small
    
    property string configKey // Config key to get and set the value

    function getConfigValue() {
        if (configKey === "")
            return undefined;

        const parts = configKey.split(".");
        let ref = Config.options;
        for (let i = 0; i < parts.length - 1; i++) {
            ref = ref[parts[i]];
        }
        return ref[parts[parts.length - 1]];
    }
    
    function setConfigValue(value) {
        if (configKey === "")
            return;

        const parts = configKey.split(".");
        let ref = Config.options;
        for (let i = 0; i < parts.length - 1; i++) {
            ref = ref[parts[i]];
        }
        ref[parts[parts.length - 1]] = value;
    }

    
    onClicked: checked = !checked
    onCheckedChanged: setConfigValue(checked)

    Component.onCompleted: {
        // initialazing value
        const value = getConfigValue();
        if (value !== undefined)
            checked = value;

        if (typeof allSettingsModel !== "undefined" && allSettingsModel !== null) {
            allSettingsModel.append({
                type: "switch",
                text: root.text,
                icon: root.buttonIcon,
                configKey: root.configKey
            })
        }
    }


    contentItem: RowLayout {
        spacing: 10
        OptionalMaterialSymbol {
            id: iconWidget
            icon: root.buttonIcon
            opacity: root.enabled ? 1 : 0.4
            iconSize: Appearance.font.pixelSize.larger
        }
        StyledText {
            id: labelWidget
            Layout.fillWidth: true
            text: root.text
            font: root.font
            color: Appearance.colors.colOnSecondaryContainer
            opacity: root.enabled ? 1 : 0.4
        }
        StyledSwitch {
            id: switchWidget
            down: root.down
            scale: 0.6
            Layout.fillWidth: false
            checked: root.checked
            onClicked: root.clicked()
        }
    }
}

