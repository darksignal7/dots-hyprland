import qs.modules.common.widgets
import qs.modules.common
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root
    property string text: ""
    property string icon
    property alias value: spinBoxWidget.value
    property alias stepSize: spinBoxWidget.stepSize
    property alias from: spinBoxWidget.from
    property alias to: spinBoxWidget.to
    spacing: 10
    Layout.leftMargin: 8
    Layout.rightMargin: 8

    property string configKey // Config key to get and set the value

    function getConfigValue() {
        if (configKey === "")
            return undefined;

        const parts = configKey.split(".");
        let ref = Config.options;
        for (let i = 0; i < parts.length - 1; i++) {
            ref = ref[parts[i]];
        }
        const value = ref[parts[parts.length - 1]];
    // Eğer değer number değilse undefined dönebilir veya parse edebiliriz
        return typeof value === "number" ? value : parseInt(value) || 0;
    }

    
    function setConfigValue(value) {
        if (configKey === "")
            return;

        const intValue = parseInt(value) || 0;

        const parts = configKey.split(".");
        let ref = Config.options;
        for (let i = 0; i < parts.length - 1; i++) {
            ref = ref[parts[i]];
        }
        ref[parts[parts.length - 1]] = intValue;
    }

    value: getConfigValue()
    onValueChanged: setConfigValue(value)
    Component.onCompleted: {
        if (typeof allSettingsModel !== "undefined" && allSettingsModel !== null) {
            allSettingsModel.append({
                type: "spinbox",
                text: root.text,
                icon: root.icon,
                configKey: root.configKey
            })
        }
    }

    RowLayout {
        spacing: 10
        OptionalMaterialSymbol {
            icon: root.icon
            opacity: root.enabled ? 1 : 0.4
        }
        StyledText {
            id: labelWidget
            Layout.fillWidth: true
            text: root.text
            color: Appearance.colors.colOnSecondaryContainer
            opacity: root.enabled ? 1 : 0.4
        }
    }

    StyledSpinBox {
        id: spinBoxWidget
        Layout.fillWidth: false
        value: root.value
    }
}
