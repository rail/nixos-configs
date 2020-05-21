Config { font = "xft:Fira Code:pixelsize=22:antialias=true:hinting=true"
       , additionalFonts = [ "xft:FontAwesome:pixelsize=22:antialias=true:hinting=true"
                           , "xft:MaterialIcons:pixelsize=22:antialias=true:hinting=true"
                           ]
       , borderColor = "black"
       , border = TopB
       , bgColor = "#343d46"
       , fgColor = "#8fa1b3"
       -- , position = Bottom
       , position = BottomSize C 85 48
       , lowerOnStart = False
       , pickBroadest = False
       , persistent = True
       , iconRoot = "."
       , allDesktops = True
       , overrideRedirect = False
       , commands = [ Run Wireless "wlp4s0"
                        [ "-a", "l"
                        , "-x", "-"
                        , "-t", "<fc=#6c71c4><fn=1>\xf1eb</fn> <essid> <quality>%</fc>"
                        , "-L", "50"
                        , "-H", "75"
                        -- , "-l", "#dc322f" -- red
                        , "-l", "#6c71c4" -- violet
                        , "-n", "#6c71c4" -- violet
                        , "-h", "#6c71c4" -- violet
                        ] 10
                    , Run Battery [ "-t", "<fn=1></fn> <left>% / <timeleft>" ] 60
                    , Run Date "%a %d, %H:%M" "date" 10
                    , Run UnsafeStdinReader
                    , Run Brightness [ "-t", "Br: <percent>%", "--", "-D", "intel_backlight" ] 60
                    , Run Kbd []
                    , Run Volume "default" "Master"
                        [ "-t", "<status>", "--"
                        , "--on", "<fc=#859900><fn=1>\xf028</fn> <volume>%</fc>"
                        , "--onc", "#859900"
                        , "--off", "<fc=#dc322f><fn=1>\xf026</fn> MUTE</fc>"
                        , "--offc", "#dc322f"
                        ] 10
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " %UnsafeStdinReader% \
                    \}{ \
                    \<action=pavucontrol>%default:Master%</action> | \
                    \%bright% | %wlp4s0wi% | %battery% | <fc=#ee9a00>%date%</fc> | %kbd% "
       }
