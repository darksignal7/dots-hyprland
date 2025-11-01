import QtQuick
import qs.services
import qs.modules.common
import qs.modules.common.widgets

ContentPage {
    forceWidth: true

    ContentSection {
        icon: "colors"
        title: Translation.tr("Color generation")

        ConfigSwitch {
            buttonIcon: "hardware"
            text: Translation.tr("Shell & utilities")
            configKey: "appearance.wallpaperTheming.enableAppsAndShell"
        }
        ConfigSwitch {
            buttonIcon: "tv_options_input_settings"
            text: Translation.tr("Qt apps")
            configKey: "appearance.wallpaperTheming.enableQtApps"
            StyledToolTip {
                text: Translation.tr("Shell & utilities theming must also be enabled")
            }
        }
        ConfigSwitch {
            buttonIcon: "terminal"
            text: Translation.tr("Terminal")
            configKey: "appearance.wallpaperTheming.enableTerminal"
            StyledToolTip {
                text: Translation.tr("Shell & utilities theming must also be enabled")
            }
        }
        ConfigRow {
            uniform: true
            ConfigSwitch {
                buttonIcon: "dark_mode"
                text: Translation.tr("Force dark mode in terminal")
                configKey: "appearance.wallpaperTheming.terminalGenerationProps.forceDarkMode"
                StyledToolTip {
                    text: Translation.tr("Ignored if terminal theming is not enabled")
                }
            }
        }

        ConfigSpinBox {
            icon: "invert_colors"
            text: Translation.tr("Terminal: Harmony (%)")
            configKey: "appearance.wallpaperTheming.terminalGenerationProps.harmony" // *100
            from: 0
            to: 100
            stepSize: 10
        }
        ConfigSpinBox {
            icon: "gradient"
            text: Translation.tr("Terminal: Harmonize threshold")
            configKey: "appearance.wallpaperTheming.terminalGenerationProps.harmonizeThreshold"
            from: 0
            to: 100
            stepSize: 10
        }
        ConfigSpinBox {
            icon: "format_color_text"
            text: Translation.tr("Terminal: Foreground boost (%)")
            configKey: "appearance.wallpaperTheming.terminalGenerationProps.termFgBoost" // * 100 
            from: 0
            to: 100
            stepSize: 10
        }
    }

}
