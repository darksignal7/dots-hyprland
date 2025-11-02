import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Io
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.common.functions

import "./"

ContentPage {
    id: searchConfigPage
    forceWidth: true
    bottomContentPadding: 0

    property list<string> sectionSourceList: [
        "./GeneralConfig.qml",
        "./BarConfig.qml",
        "./InterfaceConfig.qml",
        "./ServicesConfig.qml",
        "./AdvancedConfig.qml"
    ]

    property string searchString: ""
    onSearchStringChanged: {
        updateCurrentSettings()
    }

    ListModel {
        id: allSettingsModel
    }
    property var allSettingsArray: []
    property var currentFilteredSettings: []

    function modelToArray(model) {
        let arr = []
        for (let i = 0; i < model.count; i++) {
        // ListModel'daki her öğeyi (row) alıp diziye ekliyoruz
            arr.push(model.get(i))
        }
        return arr
    }


    function updateCurrentSettings() {
        currentFilteredSettings = allSettingsArray.filter(
            function(item) {
                return item.text && item.text.toLowerCase().includes(searchString.toLowerCase())
            }
        )
    }
    
    function getConfigValue(key) {
        if (key === "")
            return undefined;

        const parts = key.split(".");
        let ref = Config.options;
        for (let i = 0; i < parts.length - 1; i++) {
            ref = ref[parts[i]];
        }
        return ref[parts[parts.length - 1]];
    }

    Repeater {
        model: sectionSourceList
        Loader {
            Layout.fillWidth: true
            active: true
            source: sectionSourceList[index]
            onLoaded: {
                active = false
            }
        }
    }
    
        
    MaterialTextArea {
        Layout.fillWidth: true
        Layout.fillHeight: true
        placeholderText: "Search"
        text: searchString
        wrapMode: TextEdit.Wrap
        onTextChanged: {
            searchString = text;
        }
    }

    ContentSection {
        title: "Results"
        icon: "search"

        Component.onCompleted: {
            allSettingsArray = modelToArray(allSettingsModel)
            searchConfigPage.updateCurrentSettings()
        }

        Repeater {
            //model: searchString.length > 1 ? currentFilteredSettings : undefined
            model: currentFilteredSettings

            delegate: ContentSubsection {
                title: modelData.configKey
                Loader {
                    width: parent.width
                    sourceComponent: (modelData.type === "switch") ? switchComponent
                                    : (modelData.type === "spinbox") ? spinComponent
                                    : null
                    onLoaded: {
                        item.text = modelData.text
                        item.configKey = modelData.configKey
                        if (modelData.type === "switch") 
                            item.buttonIcon = modelData.icon
                            item.checked = getConfigValue(modelData.configKey)

                        if (modelData.type === "spinbox") 
                            item.value = getConfigValue(modelData.configKey)
                            item.icon = modelData.icon
                    }
                }
            }

        }
    }
    
    Component { id: switchComponent
        ConfigSwitch {
            Layout.fillWidth: true
        }
    }

    Component { id: spinComponent
        ConfigSpinBox {
            Layout.fillWidth: true
        }
    }
}