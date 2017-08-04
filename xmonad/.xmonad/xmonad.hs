import XMonad
import Data.Maybe
import System.IO

-- Utils
import XMonad.Util.Cursor
import XMonad.Util.EZConfig
import XMonad.Util.Image
import XMonad.Util.SpawnNamedPipe

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops

-- Layouts
import XMonad.Layout.Decoration
import XMonad.Layout.DecorationAddons
import XMonad.Layout.DraggingVisualizer
import XMonad.Layout.Gaps
import XMonad.Layout.Maximize
import XMonad.Layout.MouseResizableTile
import XMonad.Layout.WindowSwitcherDecoration

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal :: String
myTerminal = "termnator"

-- Whether focus follows the mouse pointer.
--
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Width of the window border in pixels.
--
myBorderWidth :: Dimension
myBorderWidth = 0

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask :: KeyMask
myModMask = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
myWorkspaces :: [String]
myWorkspaces = ["web", "dev", "other"]

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myAdditionalKeys =
  [ ((myModMask, xK_f), withFocused (sendMessage . maximizeRestore))
  ]

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings = def

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
myLayoutHook = windowSwitcherDecorationWithButtons shrinkText myTheme
  $ maximizeWithPadding 0
  $ draggingVisualizer
  $ addGaps tiled ||| addGaps tiledMirrored ||| Full
  where
    -- The number of  windows in master pane
    myNmaster :: Int
    myNmaster = 1

    -- Proportion of screen occupied by master pane
    myMasterFrac :: Rational
    myMasterFrac = 0.6

    -- The increment used whe resizing panes (via commands)
    myFracIncrement:: Rational
    myFracIncrement = 0.05

    -- Dragger type
    myDraggerType :: DraggerType
    myDraggerType = FixedDragger 20 20

    -- Default tiled layout
    tiled = mouseResizableTile
      { nmaster = myNmaster
      , masterFrac = myMasterFrac
      , fracIncrement = myFracIncrement
      , draggerType = myDraggerType
      }

    -- Mirrored tiled layout
    tiledMirrored = mouseResizableTile
      { nmaster = myNmaster
      , masterFrac = myMasterFrac
      , fracIncrement = myFracIncrement
      , draggerType = myDraggerType
      , isMirrored = True
      }

    -- Add gaps to panes
    addGaps l = gaps [(U, 20), (R, 20), (D, 20), (L, 20)] $ l

-- The images in a 0-1 scale to make
-- it easier to visualize

convertToBool' :: [Int] -> [Bool]
convertToBool' = map (\x -> x == 1)

convertToBool :: [[Int]] -> [[Bool]]
convertToBool = map convertToBool'

maxiButton' :: [[Int]]
maxiButton' = [[0,0,0,0,0,0,0,0,0,0],
               [0,1,1,1,1,1,1,1,1,0],
               [0,1,1,1,1,1,1,1,1,0],
               [0,1,1,0,0,0,0,1,1,0],
               [0,1,1,0,0,0,0,1,1,0],
               [0,1,1,0,0,0,0,1,1,0],
               [0,1,1,0,0,0,0,1,1,0],
               [0,1,1,1,1,1,1,1,1,0],
               [0,1,1,1,1,1,1,1,1,0],
               [0,0,0,0,0,0,0,0,0,0]]

maxiButton :: [[Bool]]
maxiButton = convertToBool maxiButton'

closeButton' :: [[Int]]
closeButton' = [[0,0,0,0,0,0,0,0,0,0],
                [0,1,1,0,0,0,0,1,1,0],
                [0,1,1,1,0,0,1,1,1,0],
                [0,0,1,1,1,1,1,1,0,0],
                [0,0,0,1,1,1,1,0,0,0],
                [0,0,0,1,1,1,1,0,0,0],
                [0,0,1,1,1,1,1,1,0,0],
                [0,1,1,1,0,0,1,1,1,0],
                [0,1,1,0,0,0,0,1,1,0],
                [0,0,0,0,0,0,0,0,0,0]]


closeButton :: [[Bool]]
closeButton = convertToBool closeButton'

myTheme = def
  { activeColor = "#C678DD"
  , inactiveColor = "#3E4452"
  , urgentColor = "#E06C75"
  , activeBorderColor = "#C678DD"
  , inactiveBorderColor = "#3E4452"
  , urgentBorderColor = "#E06C75"
  , activeTextColor = "#FFFFFF"
  , inactiveTextColor = "#ABB2BF"
  , urgentTextColor = "#FFFFFF"
  , fontName = "xft:DejaVu Sans Mono:pixelsize=11:antialias=true"
  , decoHeight = 30
  , windowTitleIcons =
    [ (closeButton, CenterRight 10)
    , (maxiButton, CenterRight 25)
    ]
  }

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
myManageHook = composeAll
  [ className =? "MPlayer"        --> doFloat
  , className =? "Gimp"           --> doFloat
  , resource  =? "desktop_window" --> doIgnore
  , resource  =? "kdesktop"       --> doIgnore
  ]

------------------------------------------------------------------------
-- Event handling

-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = fullscreenEventHook

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

-- |
-- Customize the formatting of status information.
--
myPP = def
  { ppCurrent = xmobarColor "#ffffff" "" . pad
  , ppVisible = xmobarColor "#666666" "" . pad
  , ppHidden  = xmobarColor "#666666" "" . pad
  , ppUrgent  = xmobarColor "#ff0000" "" . pad
  , ppSep     = ""
  , ppWsSep   = ""
  , ppTitle   = pad . shorten 50
  {-, ppLayout  = -}
  }

-- |
-- Status bar configuration
--
myStatusBar =
  statusBar "xmobar ~/.xmonad/panels/.xmobarrc" myPP toggleStrutsKey

-- |
-- Helper function which provides ToggleStruts keybinding
--
toggleStrutsKey :: XConfig t -> (KeyMask, KeySym)
toggleStrutsKey XConfig{modMask = modm} = (modm, xK_b )

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
--
myStartupHook = setDefaultCursor xC_left_ptr

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.
--
main :: IO ()
main = xmonad =<< myStatusBar myConfig

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
myConfig = def
  { terminal = myTerminal
  , focusFollowsMouse = myFocusFollowsMouse
  , borderWidth = myBorderWidth
  , modMask = myModMask
  , workspaces = myWorkspaces
  , mouseBindings = myMouseBindings
  , layoutHook = myLayoutHook
  , manageHook = myManageHook
  , handleEventHook = myEventHook
  , logHook = myLogHook
  , startupHook = myStartupHook
  }
  `additionalKeys` myAdditionalKeys
