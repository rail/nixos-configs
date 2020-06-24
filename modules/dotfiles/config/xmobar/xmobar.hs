Config { font = "xft:Fira Code:pixelsize=22:antialias=true:hinting=true"
       , additionalFonts = [ "xft:MaterialIcons:pixelsize=22:antialias=true:hinting=true"
                           , "xft:Weather Icons:style=Regular:pixelsize=22:antialias=true:hinting=true"
                           ]
       , borderColor = "black"
       , border = TopB
       , bgColor = "#343d46"
       , fgColor = "#d8dee9"
       -- , position = Bottom
       , position = BottomSize C 85 48
       , lowerOnStart = False
       , pickBroadest = False
       , persistent = True
       , iconRoot = "."
       , allDesktops = True
       , overrideRedirect = False
       , commands = [ Run Kbd []
                    , Run UnsafeStdinReader
                    , Run Date "<fn=1>\xe24f</fn> %a %d, %H:%M" "date" 10
                    , Run ComX
                        "/home/rail/bin/openweathermap" [] "Err..." "weather" 300
                    , Run Wireless "wlp4s0"
                        [ "-t", "<fc=#d8dee9><fn=1>\xe63e</fn> <essid> <quality>%</fc>"
                        , "-a", "l"
                        , "-x", "-"
                        , "-l", "#d8dee9"
                        , "-n", "#d8dee9"
                        , "-h", "#d8dee9"
                        ] 30
                    , Run Battery
                        [ "-t" , "<leftipat><left>%"
                        , "--"
                        , "--on-icon-pattern", "<fn=1>\xe1a3</fn>"
                        , "--off-icon-pattern", "<fn=1>\xe1a4</fn>"
                        , "--idle-icon-pattern", "<fn=1>\xe1a3</fn>"
                        ] 60
                    , Run Brightness
                        [ "-t"
                        , "<fn=1>\xe3ab</fn> <percent>%"
                        , "--"
                        , "-D", "intel_backlight"
                        ] 60
                    , Run Volume "default" "Master"
                        [ "-t", "<status>"
                        , "--"
                        , "--on", "<fn=1>\xe050</fn> <volume>%"
                        , "--onc", "#d8dee9"
                        , "--off", "<fn=1>\xe04f</fn>"
                        , "--offc", "#dc322f"
                        ] 10
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " %UnsafeStdinReader% \
                    \}{ \
                    \<action=`firefox https://darksky.net/forecast/43.26,-79.961/ca12/en`>%weather%</action> | \
                    \<action=`pavucontrol`>%default:Master%</action> | \
                    \%bright% | %wlp4s0wi% | %battery% | %date% | \
                    \<action=`xkb-switch -n`><fn=1></fn> %kbd%</action> "
       }
