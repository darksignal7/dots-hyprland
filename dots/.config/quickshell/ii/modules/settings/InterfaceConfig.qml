import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.common.widgets

ContentPage {
    forceWidth: true

    ContentSection {
        icon: "wallpaper"
        title: Translation.tr("Background")

        ConfigSwitch {
            buttonIcon: "nest_clock_farsight_analog"
            text: Translation.tr("Show clock")
            checked: Config.options.background.clock.show
            onCheckedChanged: {
                Config.options.background.clock.show = checked;
            }
        }
            

        ConfigSpinBox {
            icon: "loupe"
            text: Translation.tr("Scale (%)") 
            configKey: "background.clock.scale" // * 100
            from: 1
            to: 200
            stepSize: 2

        }

        ContentSubsection {
            title: Translation.tr("Clock style")
            ConfigSelectionArray {
                currentValue: Config.options.background.clock.style
                onSelected: newValue => {
                    Config.options.background.clock.style = newValue;
                }
                options: [
                    {
                        displayName: Translation.tr("Simple digital"),
                        icon: "timer_10",
                        value: "digital"
                    },
                    {
                        displayName: Translation.tr("Material cookie"),
                        icon: "cookie",
                        value: "cookie"
                    }
                ]
            }
        }

        ContentSubsection {
            visible: Config.options.background.clock.style === "cookie"
            title: Translation.tr("Cookie clock settings")

            ConfigSwitch {
                buttonIcon: "wand_stars"
                text: Translation.tr("Auto styling with Gemini")
                configKey: "background.clock.cookie.aiStyling"
                StyledToolTip {
                    text: Translation.tr("Uses Gemini to categorize the wallpaper then picks a preset based on it.\nYou'll need to set Gemini API key on the left sidebar first.\nImages are downscaled for performance, but just to be safe,\ndo not select wallpapers with sensitive information.")
                }
            }

            ConfigSpinBox {
                icon: "add_triangle"
                text: Translation.tr("Sides")
                configKey: "background.clock.cookie.sides"
                from: 0
                to: 40
                stepSize: 1
            }

            ConfigSwitch {
                buttonIcon: "autoplay"
                text: Translation.tr("Constantly rotate")
                configKey: "background.clock.cookie.constantlyRotate"
                StyledToolTip {
                    text: "Makes the clock always rotate. This is extremely expensive\n(expect 50% usage on Intel UHD Graphics) and thus impractical."
                }
            }

            ConfigRow {

                ConfigSwitch {
                    enabled: Config.options.background.clock.style === "cookie" && Config.options.background.clock.cookie.dialNumberStyle === "dots" || Config.options.background.clock.cookie.dialNumberStyle === "full"
                    buttonIcon: "brightness_7"
                    text: Translation.tr("Hour marks")
                    configKey: "background.clock.cookie.hourMarks"
                    onEnabledChanged: {
                        checked = Config.options.background.clock.cookie.hourMarks;
                    }
                    StyledToolTip {
                        text: "Can only be turned on using the 'Dots' or 'Full' dial style for aesthetic reasons"
                    }
                }

                ConfigSwitch {
                    enabled: Config.options.background.clock.style === "cookie" && Config.options.background.clock.cookie.dialNumberStyle !== "numbers"
                    buttonIcon: "timer_10"
                    text: Translation.tr("Digits in the middle")
                    configKey: "background.clock.cookie.timeIndicators"
                    onEnabledChanged: {
                        checked = Config.options.background.clock.cookie.timeIndicators;
                    }
                    StyledToolTip {
                        text: "Can't be turned on when using 'Numbers' dial style for aesthetic reasons"
                    }
                }
            }
        }
        
        ContentSubsection {
            visible: Config.options.background.clock.style === "cookie"
            title: Translation.tr("Dial style")
            ConfigSelectionArray {
                currentValue: Config.options.background.clock.cookie.dialNumberStyle
                onSelected: newValue => {
                    Config.options.background.clock.cookie.dialNumberStyle = newValue;
                    if (newValue !== "dots" && newValue !== "full") {
                        Config.options.background.clock.cookie.hourMarks = false;
                    }
                    if (newValue === "numbers") {
                        Config.options.background.clock.cookie.timeIndicators = false;
                    }
                }
                options: [
                    {
                        displayName: "",
                        icon: "block",
                        value: "none"
                    },
                    {
                        displayName: Translation.tr("Dots"),
                        icon: "graph_6",
                        value: "dots"
                    },
                    {
                        displayName: Translation.tr("Full"),
                        icon: "history_toggle_off",
                        value: "full"
                    },
                    {
                        displayName: Translation.tr("Numbers"),
                        icon: "counter_1",
                        value: "numbers"
                    }
                ]
            }
        }

        ContentSubsection {
            visible: Config.options.background.clock.style === "cookie"
            title: Translation.tr("Hour hand")
            ConfigSelectionArray {
                currentValue: Config.options.background.clock.cookie.hourHandStyle
                onSelected: newValue => {
                    Config.options.background.clock.cookie.hourHandStyle = newValue;
                }
                options: [
                    {
                        displayName: "",
                        icon: "block",
                        value: "hide"
                    },
                    {
                        displayName: Translation.tr("Classic"),
                        icon: "radio",
                        value: "classic"
                    },
                    {
                        displayName: Translation.tr("Hollow"),
                        icon: "circle",
                        value: "hollow"
                    },
                    {
                        displayName: Translation.tr("Fill"),
                        icon: "eraser_size_5",
                        value: "fill"
                    },
                ]
            }
        }

        ContentSubsection {
            visible: Config.options.background.clock.style === "cookie"
            title: Translation.tr("Minute hand")

            ConfigSelectionArray {
                currentValue: Config.options.background.clock.cookie.minuteHandStyle
                onSelected: newValue => {
                    Config.options.background.clock.cookie.minuteHandStyle = newValue;
                }
                options: [
                    {
                        displayName: "",
                        icon: "block",
                        value: "hide"
                    },
                    {
                        displayName: Translation.tr("Classic"),
                        icon: "radio",
                        value: "classic"
                    },
                    {
                        displayName: Translation.tr("Thin"),
                        icon: "line_end",
                        value: "thin"
                    },
                    {
                        displayName: Translation.tr("Medium"),
                        icon: "eraser_size_2",
                        value: "medium"
                    },
                    {
                        displayName: Translation.tr("Bold"),
                        icon: "eraser_size_4",
                        value: "bold"
                    },
                ]
            }
        }

        ContentSubsection {
            visible: Config.options.background.clock.style === "cookie"
            title: Translation.tr("Second hand")

            ConfigSelectionArray {
                currentValue: Config.options.background.clock.cookie.secondHandStyle
                onSelected: newValue => {
                    Config.options.background.clock.cookie.secondHandStyle = newValue;
                }
                options: [
                    {
                        displayName: "",
                        icon: "block",
                        value: "hide"
                    },
                    {
                        displayName: Translation.tr("Classic"),
                        icon: "radio",
                        value: "classic"
                    },
                    {
                        displayName: Translation.tr("Line"),
                        icon: "line_end",
                        value: "line"
                    },
                    {
                        displayName: Translation.tr("Dot"),
                        icon: "adjust",
                        value: "dot"
                    },
                ]
            }
        }

        ContentSubsection {
            visible: Config.options.background.clock.style === "cookie"
            title: Translation.tr("Date style")

            ConfigSelectionArray {
                currentValue: Config.options.background.clock.cookie.dateStyle
                onSelected: newValue => {
                    Config.options.background.clock.cookie.dateStyle = newValue;
                }
                options: [
                    {
                        displayName: "",
                        icon: "block",
                        value: "hide"
                    },
                    {
                        displayName: Translation.tr("Bubble"),
                        icon: "bubble_chart",
                        value: "bubble"
                    },
                    {
                        displayName: Translation.tr("Border"),
                        icon: "rotate_right",
                        value: "border"
                    },
                    {
                        displayName: Translation.tr("Rect"),
                        icon: "rectangle",
                        value: "rect"
                    }
                ]
            }
        }

        ContentSubsection {
            title: Translation.tr("Quote settings")
            ConfigSwitch {
                buttonIcon: "format_quote"
                text: Translation.tr("Show quote")
                configKey: "background.showQuote"
            }
            MaterialTextArea {
                Layout.fillWidth: true
                placeholderText: Translation.tr("Quote")
                text: Config.options.background.quote
                wrapMode: TextEdit.Wrap
                onTextChanged: {
                    Config.options.background.quote = text;
                }
            }
        }

        ContentSubsection {
            title: Translation.tr("Wallpaper parallax")

            ConfigSwitch {
                buttonIcon: "unfold_more_double"
                text: Translation.tr("Vertical")
                configKey: "background.parallax.vertical"
            }

            ConfigRow {
                uniform: true
                ConfigSwitch {
                    buttonIcon: "counter_1"
                    text: Translation.tr("Depends on workspace")
                    configKey: "background.parallax.enableWorkspace"
                }
                ConfigSwitch {
                    buttonIcon: "side_navigation"
                    text: Translation.tr("Depends on sidebars")
                    configKey: "background.parallax.enableSidebar"
                }
            }
            ConfigSpinBox {
                icon: "loupe"
                text: Translation.tr("Preferred wallpaper zoom (%)")
                configKey: "background.parallax.workspaceZoom"
                from: 100
                to: 150
                stepSize: 1
            }
        }
    }

    ContentSection {
        icon: "point_scan"
        title: Translation.tr("Crosshair overlay")

        MaterialTextArea {
            Layout.fillWidth: true
            placeholderText: Translation.tr("Crosshair code (in Valorant's format)")
            text: Config.options.crosshair.code
            wrapMode: TextEdit.Wrap
            onTextChanged: {
                Config.options.crosshair.code = text;
            }
        }

        RowLayout {
            StyledText {
                Layout.leftMargin: 10
                color: Appearance.colors.colSubtext
                font.pixelSize: Appearance.font.pixelSize.smallie
                text: Translation.tr("Press Super+G to toggle appearance")
            }
            Item {
                Layout.fillWidth: true
            }
            RippleButtonWithIcon {
                id: editorButton
                buttonRadius: Appearance.rounding.full
                materialIcon: "open_in_new"
                mainText: Translation.tr("Open editor")
                onClicked: {
                    Qt.openUrlExternally(`https://www.vcrdb.net/builder?c=${Config.options.crosshair.code}`);
                }
                StyledToolTip {
                    text: "www.vcrdb.net"
                }
            }
        }
    }

    ContentSection {
        icon: "call_to_action"
        title: Translation.tr("Dock")

        ConfigSwitch {
            buttonIcon: "check"
            text: Translation.tr("Enable")
            configKey: "dock.enable"
        }

        ConfigRow {
            uniform: true
            ConfigSwitch {
                buttonIcon: "highlight_mouse_cursor"
                text: Translation.tr("Hover to reveal")
                configKey: "dock.hoverToReveal"
            }
            ConfigSwitch {
                buttonIcon: "keep"
                text: Translation.tr("Pinned on startup")
                configKey: "dock.pinnedOnStartup"
            }
        }
        ConfigSwitch {
            buttonIcon: "colors"
            text: Translation.tr("Tint app icons")
            configKey: "dock.monochromeIcons"
        }
    }

    ContentSection {
        icon: "lock"
        title: Translation.tr("Lock screen")

        ConfigSwitch {
            buttonIcon: "water_drop"
            text: Translation.tr('Use Hyprlock (instead of Quickshell)')
            configKey: "lock.useHyprlock"
            StyledToolTip {
                text: Translation.tr("If you want to somehow use fingerprint unlock...")
            }
        }

        ConfigSwitch {
            buttonIcon: "account_circle"
            text: Translation.tr('Launch on startup')
            configKey: "lock.launchOnStartup"
        }

        ContentSubsection {
            title: Translation.tr("Security")

            ConfigSwitch {
                buttonIcon: "settings_power"
                text: Translation.tr('Require password to power off/restart')
                configKey: "lock.security.requirePasswordToPower"
                StyledToolTip {
                    text: Translation.tr("Remember that on most devices one can always hold the power button to force shutdown\nThis only makes it a tiny bit harder for accidents to happen")
                }
            }

            ConfigSwitch {
                buttonIcon: "key_vertical"
                text: Translation.tr('Also unlock keyring')
                configKey: "lock.security.unlockKeyring"
                StyledToolTip {
                    text: Translation.tr("This is usually safe and needed for your browser and AI sidebar anyway\nMostly useful for those who use lock on startup instead of a display manager that does it (GDM, SDDM, etc.)")
                }
            }
        }

        ContentSubsection {
            title: Translation.tr("Style: general")

            ConfigSwitch {
                buttonIcon: "center_focus_weak"
                text: Translation.tr('Center clock')
                configKey: "lock.centerClock"
            }

            ConfigSwitch {
                buttonIcon: "info"
                text: Translation.tr('Show "Locked" text')
                configKey: "lock.showLockedText"
            }
        }
        ContentSubsection {
            title: Translation.tr("Style: Blurred")

            ConfigSwitch {
                buttonIcon: "blur_on"
                text: Translation.tr('Enable blur')
                configKey: "lock.blur.enable"
            }

            ConfigSpinBox {
                icon: "loupe"
                text: Translation.tr("Extra wallpaper zoom (%)")
                configKey: "lock.blur.extraZoom" // * 100
                from: 1
                to: 150
                stepSize: 2
            }
        }
    }

    ContentSection {
        icon: "notifications"
        title: Translation.tr("Notifications")

        ConfigSpinBox {
            icon: "av_timer"
            text: Translation.tr("Timeout duration (if not defined by notification) (ms)")
            configKey: "notifications.timeout"
            from: 1000
            to: 60000
            stepSize: 1000
        }
    }

    ContentSection {
        icon: "screenshot_frame_2"
        title: Translation.tr("Region selector (screen snipping/Google Lens)")

        ContentSubsection {
            title: Translation.tr("Hint target regions")
            ConfigRow {
                ConfigSwitch {
                    buttonIcon: "select_window"
                    text: Translation.tr('Windows')
                    configKey: "regionSelector.targetRegions.windows"
                }
                ConfigSwitch {
                    buttonIcon: "right_panel_open"
                    text: Translation.tr('Layers')
                    configKey: "regionSelector.targetRegions.layers"
                }
                ConfigSwitch {
                    buttonIcon: "nearby"
                    text: Translation.tr('Content')
                    configKey: "regionSelector.targetRegions.content"
                    StyledToolTip {
                        text: Translation.tr("Could be images or parts of the screen that have some containment.\nMight not always be accurate.\nThis is done with an image processing algorithm run locally and no AI is used.")
                    }
                }
            }
        }
        
        ContentSubsection {
            title: Translation.tr("Google Lens")
            
            ConfigSelectionArray {
                currentValue: Config.options.search.imageSearch.useCircleSelection ? "circle" : "rectangles"
                onSelected: newValue => {
                    Config.options.search.imageSearch.useCircleSelection = (newValue === "circle");
                }
                options: [
                    { icon: "activity_zone", value: "rectangles", displayName: Translation.tr("Rectangular selection") },
                    { icon: "gesture", value: "circle", displayName: Translation.tr("Circle to Search") }
                ]
            }
        }

        ContentSubsection {
            title: Translation.tr("Rectangular selection")

            ConfigSwitch {
                buttonIcon: "point_scan"
                text: Translation.tr("Show aim lines")
                configKey: "regionSelector.rect.showAimLines"
            }
        }

        ContentSubsection {
            title: Translation.tr("Circle selection")
            
            ConfigSpinBox {
                icon: "eraser_size_3"
                text: Translation.tr("Stroke width")
                configKey: "regionSelector.circle.strokeWidth"
                from: 1
                to: 20
                stepSize: 1
            }

            ConfigSpinBox {
                icon: "screenshot_frame_2"
                text: Translation.tr("Padding")
                configKey: "regionSelector.circle.padding"
                from: 0
                to: 100
                stepSize: 5
            }
        }
    }

    ContentSection {
        icon: "side_navigation"
        title: Translation.tr("Sidebars")

        ConfigSwitch {
            buttonIcon: "memory"
            text: Translation.tr('Keep right sidebar loaded')
            configKey: "sidebar.keepRightSidebarLoaded"
            StyledToolTip {
                text: Translation.tr("When enabled keeps the content of the right sidebar loaded to reduce the delay when opening,\nat the cost of around 15MB of consistent RAM usage. Delay significance depends on your system's performance.\nUsing a custom kernel like linux-cachyos might help")
            }
        }

        ConfigSwitch {
            buttonIcon: "translate"
            text: Translation.tr('Enable translator')
            configKey: "sidebar.translator.enable"
        }

        ContentSubsection {
            title: Translation.tr("Quick toggles")
            
            ConfigSelectionArray {
                Layout.fillWidth: false
                currentValue: Config.options.sidebar.quickToggles.style
                onSelected: newValue => {
                    Config.options.sidebar.quickToggles.style = newValue;
                }
                options: [
                    {
                        displayName: Translation.tr("Classic"),
                        icon: "password_2",
                        value: "classic"
                    },
                    {
                        displayName: Translation.tr("Android"),
                        icon: "action_key",
                        value: "android"
                    }
                ]
            }

            ConfigSpinBox {
                enabled: Config.options.sidebar.quickToggles.style === "android"
                icon: "splitscreen_left"
                text: Translation.tr("Columns")
                configKey: "sidebar.quickToggles.android.columns"
                from: 1
                to: 8
                stepSize: 1
            }
        }

        ContentSubsection {
            title: Translation.tr("Sliders")

            ConfigSwitch {
                buttonIcon: "check"
                text: Translation.tr("Enable")
                configKey: "sidebar.quickSliders.enable"
            }
            
            ConfigSwitch {
                buttonIcon: "brightness_6"
                text: Translation.tr("Brightness")
                configKey: "sidebar.quickSliders.showBrightness"
                enabled: Config.options.sidebar.quickSliders.enable
            }

            ConfigSwitch {
                buttonIcon: "volume_up"
                text: Translation.tr("Volume")
                configKey: "sidebar.quickSliders.showVolume"
                enabled: Config.options.sidebar.quickSliders.enable
            }

            ConfigSwitch {
                buttonIcon: "mic"
                text: Translation.tr("Microphone")
                configKey: "sidebar.quickSliders.showMic"
                enabled: Config.options.sidebar.quickSliders.enable
            }
        }

        ContentSubsection {
            title: Translation.tr("Corner open")
            tooltip: Translation.tr("Allows you to open sidebars by clicking or hovering screen corners regardless of bar position")
            ConfigRow {
                uniform: true
                ConfigSwitch {
                    buttonIcon: "check"
                    text: Translation.tr("Enable")
                    configKey: "sidebar.cornerOpen.enable"
                }
            }
            ConfigSwitch {
                buttonIcon: "highlight_mouse_cursor"
                text: Translation.tr("Hover to trigger")
                configKey: "sidebar.cornerOpen.clickless"

                StyledToolTip {
                    text: Translation.tr("When this is off you'll have to click")
                }
            }
            Row {
                ConfigSwitch {
                    enabled: !Config.options.sidebar.cornerOpen.clickless
                    buttonIcon: "highlight_mouse_cursor"
                    text: Translation.tr("Force hover open at absolute corner")
                    configKey: "sidebar.cornerOpen.clicklessCornerEnd"

                    StyledToolTip {
                        text: Translation.tr("When the previous option is off and this is on,\nyou can still hover the corner's end to open sidebar,\nand the remaining area can be used for volume/brightness scroll")
                    }
                }
                ConfigSpinBox {
                    icon: "arrow_cool_down"
                    text: Translation.tr("with vertical offset")
                    configKey: "sidebar.cornerOpen.clicklessCornerVerticalOffset"
                    from: 0
                    to: 20
                    stepSize: 1
                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        acceptedButtons: Qt.NoButton
                        StyledToolTip {
                            extraVisibleCondition: mouseArea.containsMouse
                            text: Translation.tr("Why this is cool:\nFor non-0 values, it won't trigger when you reach the\nscreen corner along the horizontal edge, but it will when\nyou do along the vertical edge")
                        }
                    }
                }
            }
            
            ConfigRow {
                uniform: true
                ConfigSwitch {
                    buttonIcon: "vertical_align_bottom"
                    text: Translation.tr("Place at bottom")
                    configKey: "sidebar.cornerOpen.bottom"

                    StyledToolTip {
                        text: Translation.tr("Place the corners to trigger at the bottom")
                    }
                }
                ConfigSwitch {
                    buttonIcon: "unfold_more_double"
                    text: Translation.tr("Value scroll")
                    configKey: "sidebar.cornerOpen.valueScroll"

                    StyledToolTip {
                        text: Translation.tr("Brightness and volume")
                    }
                }
            }
            ConfigSwitch {
                buttonIcon: "visibility"
                text: Translation.tr("Visualize region")
                configKey: "sidebar.cornerOpen.visualize"
            }
            ConfigRow {
                ConfigSpinBox {
                    icon: "arrow_range"
                    text: Translation.tr("Region width")
                    configKey: "sidebar.cornerOpen.cornerRegionWidth"
                    from: 1
                    to: 300
                    stepSize: 1
                }
                ConfigSpinBox {
                    icon: "height"
                    text: Translation.tr("Region height")
                    configKey: "sidebar.cornerOpen.cornerRegionHeight"
                    from: 1
                    to: 300
                    stepSize: 1
                }
            }
        }
    }

    ContentSection {
        icon: "voting_chip"
        title: Translation.tr("On-screen display")

        ConfigSpinBox {
            icon: "av_timer"
            text: Translation.tr("Timeout (ms)")
            configKey: "osd.timeout"
            from: 100
            to: 3000
            stepSize: 100
        }
    }

    ContentSection {
        icon: "overview_key"
        title: Translation.tr("Overview")

        ConfigSwitch {
            buttonIcon: "check"
            text: Translation.tr("Enable")
            configKey: "overview.enable"
        }
        ConfigSpinBox {
            icon: "loupe"
            text: Translation.tr("Scale (%)")
            configKey: "overview.scale"
            from: 1
            to: 100
            stepSize: 1
        }
        ConfigRow {
            uniform: true
            ConfigSpinBox {
                icon: "splitscreen_bottom"
                text: Translation.tr("Rows")
                configKey: "overview.rows"
                from: 1
                to: 20
                stepSize: 1
            }
            ConfigSpinBox {
                icon: "splitscreen_right"
                text: Translation.tr("Columns")
                configKey: "overview.columns"
                from: 1
                to: 20
                stepSize: 1
            }
        }
    }

    ContentSection {
        icon: "wallpaper_slideshow"
        title: Translation.tr("Wallpaper selector")

        ConfigSwitch {
            buttonIcon: "ad"
            text: Translation.tr('Use system file picker')
            configKey: "wallpaperSelector.useSystemFileDialog"
        }
    }
}
