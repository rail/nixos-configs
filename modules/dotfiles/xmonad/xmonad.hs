import           Data.Monoid
import           System.Exit
import           XMonad

-- actions
import           XMonad.Actions.CopyWindow
import           XMonad.Actions.CopyWindow
import           XMonad.Actions.CycleWS              (toggleWS)
import           XMonad.Actions.DynamicProjects
import           XMonad.Actions.FloatKeys
import           XMonad.Actions.NoBorders            (toggleBorder)
import           XMonad.Actions.SpawnOn

-- layouts
import           XMonad.Layout.Named
import           XMonad.Layout.NoBorders             (noBorders, smartBorders)
import           XMonad.Layout.Spacing               (smartSpacing)

import           XMonad.Layout.GridVariants          (Grid (Grid))
import           XMonad.Layout.MultiToggle
import           XMonad.Layout.MultiToggle.Instances (StdTransformers (NBFULL, NOBORDERS))
import           XMonad.Layout.NoFrillsDecoration
import           XMonad.Layout.ResizableTile

-- hooks
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers

-- prompt
import           XMonad.Prompt                       (XPPosition (CenteredAt, Top),
                                                      amberXPConfig, font,
                                                      height, position)
import           XMonad.Prompt.ConfirmPrompt

-- util
import           XMonad.Util.Cursor                  (setDefaultCursor)
import           XMonad.Util.EZConfig                (additionalKeysP)
import           XMonad.Util.Run
import           XMonad.Util.SpawnNamedPipe
import           XMonad.Util.SpawnOnce


import qualified Data.Map                            as M
import           Data.Maybe
import qualified XMonad.StackSet                     as W

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "kitty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask


-- My theme, based on oceanic next, https://github.com/voronianski/oceanic-next-color-scheme
base00 = "#1B2B34"
base01 = "#343D46"
base02 = "#4F5B66"
base03 = "#65737E"
base04 = "#A7ADBA"
base05 = "#C0C5CE"
base06 = "#CDD3DE"
base07 = "#D8DEE9"
base08 = "#EC5f67"
base09 = "#F99157"
base0A = "#FAC863"
base0B = "#99C794"
base0C = "#5FB3B3"
base0D = "#6699CC"
base0E = "#C594C5"
base0F = "#AB7967"

active = base08
red = base08
yellow = base0A

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
-- myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

wsNames = map show [1..9]

myWorkspaces = [ xmobarAction ("xdotool key super+" ++ show(n)) "1" ws |
               (i,ws) <- zip [1..9] wsNames,
               let n = i ]


-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = base04
myFocusedBorderColor = base09
myFont = "xft:Fira Code:pixelsize=32:hinting=true:antialias=true"

promptTheme = amberXPConfig { font = myFont
                            , position = CenteredAt (1/3) (1/2)
                            , height = 42}

mySimpleKeys =
    [ ("<XF86AudioRaiseVolume>", spawn "pamixer -i 5")
    , ("<XF86AudioLowerVolume>", spawn "pamixer -d 5")
    , ("<XF86AudioMute>", spawn "pamixer -t")
    , ("<XF86AudioMicMute>", spawn "pamixer -t --source 1")
    , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 5")
    , ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 10")
    , ("M-C-l", spawn "light-locker-command -l")
    , ("M-S-m", spawn "autorandr --change && feh --no-fehbg --bg-fill ~/Pictures/wallpapers/current")
    , ("M-s", toggleCopyToAll)   -- Toggle sticky window state
    -- resize windows next to master
    , ("M-a", sendMessage MirrorExpand)
    , ("M-z", sendMessage MirrorShrink)
    -- switch to previous workspace, similar to i3's workspace_auto_back_and_forth
    , ("M-`", toggleWS)
    -- Toggle floating
    , ("M-t", withFocused toggleFloat)
    -- Toggle borders of the focused window
    , ("M-g", withFocused toggleBorder)
    , ("M-f", sendMessage (Toggle NBFULL) >> sendMessage ToggleStruts) -- Toggles noborder/full
    , ("M-<Right>", withFocused (keysMoveWindow (200,0)))
    , ("M-<Left>", withFocused (keysMoveWindow (-200,0)))
    , ("M-<Up>", withFocused (keysMoveWindow (0,-200)))
    , ("M-<Down>", withFocused (keysMoveWindow (0,200)))
    , ("M-S-<Right>", withFocused (keysMoveWindow (50,0)))
    , ("M-S-<Left>", withFocused (keysMoveWindow (-50,0)))
    , ("M-S-<Up>", withFocused (keysMoveWindow (0,-50)))
    , ("M-S-<Down>", withFocused (keysMoveWindow (0,50)))
    ]

    ++
    -- M-c 1..9 - Copy window to a particular workspace
    [("M-c " ++ (show i), windows $ copy ws) | (i,ws) <- zip [1..9] myWorkspaces]

        where
            toggleCopyToAll = wsContainingCopies >>= \ws -> case ws of
                                                              [] -> windows copyToAll
                                                              _ -> killAllOtherCopies

            toggleFloat w = windows (\s -> if M.member w (W.floating s)
                            then W.sink w s
                            else (W.float w (W.RationalRect (1/4) (1/4) (1/2) (1/2)) s))
------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch rofi
    , ((modm,               xK_p     ), spawn "rofi -show run")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), confirmPrompt promptTheme "Quit XMonad?" $ io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
--
-- avoidStruts to avoid window overlapping of xmobar
myLayout = avoidStruts $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) $ tiled ||| grid ||| Mirror tiled ||| noBorders Full
  where
     -- default tiling algorithm partitions the screen into two panes
     grid    = named "Grid"
               $ smartBorders $ addTopBar $ smartSpacing 10
               $ Grid (16/10)

     tiled   = named "Tall"
               $ smartBorders $ addTopBar $ smartSpacing 10
               $ ResizableTall nmaster delta ratio []

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = manageDocks <+> composeOne
    [ className =? "Transmission-gtk" -?> doFloat
    , className =? "pinentry"         -?> doFloat
    , className =? "Pavucontrol"      -?> doShift (myWorkspaces!!6)
    , className =? "mpv"              -?> doFloat
    , className =? "zoom"             -?> doFloat
    , resource  =? "desktop_window"   -?> doIgnore
    , stringProperty "WM_NAME" =? "Bluetooth Devices" -?> doShift (myWorkspaces!!6)
    , className =? "Xmessage"         -?> doCenterFloat
    , stringProperty "WM_WINDOW_ROLE" =? "PictureInPicture" -?> doSideFloat SE
    , stringProperty "WM_WINDOW_ROLE" =? "pop-up"               -?> doCenterFloat
    , stringProperty "WM_WINDOW_ROLE" =? "GtkFileChooserDialog" -?> doCenterFloat
    , isFullscreen -?> doFullFloat
    , isDialog -?> doCenterFloat
    ]

-- doRectFloat (W.RationalRect (1/6) (1/6) (2/3) (2/3))
-- for_window [class="Firefox" window_role="About"] floating enable
-- for_window [class="mpv"] floating enable, sticky enable, resize set 640 480, move position center
--for_window [title="^Picture-in-Picture$"] floating enable, sticky enable
--
------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = ewmhDesktopsEventHook

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = do
    -- Mark workspaces with copied windows
    copies <- wsContainingCopies
    let hiliteCopies ws | ws `elem` copies =
                          xmobarColor base08 "" $ ws
                        | otherwise = ws
    xmproc0 <- getNamedPipe "xmproc0"
    xmproc1 <- getNamedPipe "xmproc1"
    dynamicLogWithPP xmobarPP
        { ppOutput =
            maybe (\s -> return ()) hPutStrLn xmproc0 <+>
            maybe (\s -> return ()) hPutStrLn xmproc1
        , ppSep = " :: "
        , ppHidden = hiliteCopies -- highlight the workspaces with copies of focused window
        , ppVisible = xmobarColor base0D "" . wrap "(" ")"
        , ppCurrent = xmobarColor base0A ""
        , ppTitle = xmobarColor base0B "" . shorten 60 }
--
------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
myStartupHook = do
    spawnNamedPipe "xmobar -x 0 ~/.config/xmobar/xmobar.hs" "xmproc0"
    spawnNamedPipe "xmobar -x 1 ~/.config/xmobar/xmobar.hs" "xmproc1"
    spawnOnce "autorandr --change"
    spawnOnce "light-locker --lock-after-screensaver=10 --late-locking --idle-hint --lock-on-suspend --lock-on-lid"
    spawnOnce "feh --no-fehbg --bg-fill ~/Pictures/wallpapers/current"
    spawnOnce "xinput --disable \"Synaptics TM3289-002\""
    setDefaultCursor xC_left_ptr

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
    xmonad
       $ ewmh -- TODO: need xmonad-contrib 0.16 ewmhFullscreen $
       $ docks
       $ dynamicProjects projects
       $ defaults `additionalKeysP` mySimpleKeys

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }

topBarTheme = def
    { fontName            = myFont
    , inactiveBorderColor = base03
    , inactiveColor       = base03
    , inactiveTextColor   = base03
    , activeBorderColor   = active
    , activeColor         = active
    , activeTextColor     = active
    , urgentBorderColor   = red
    , urgentTextColor     = yellow
    , decoHeight          = 10
    }

addTopBar = noFrillsDeco shrinkText topBarTheme

projects :: [Project]
projects =
  [ Project { projectName      = myWorkspaces!!3
            , projectDirectory = "~/"
            , projectStartHook = Just $ spawnOn (myWorkspaces!!3) "firefox"
            }

  , Project { projectName      = myWorkspaces!!0
            , projectDirectory = "~/"
            , projectStartHook = Just $ spawnOn (myWorkspaces!!0) (myTerminal ++ " tmux")
            }
  , Project { projectName      = myWorkspaces!!6
            , projectDirectory = "~/"
            , projectStartHook = Just $ spawnOn (myWorkspaces!!6) "nautilus"
            }
  ]
