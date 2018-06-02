{ skhd }:
{
  enable     = true;
  package    = skhd;
  skhdConfig = ''
    # open terminal, blazingly fast compared to iTerm/Hyper
    # cmd - return : open -na /Applications/Utilities/Terminal.app

    # close focused window
    # alt - w : chunkc tiling::window --close

    # focus window
    alt - h : chunkc tiling::window --focus west
    alt - j : chunkc tiling::window --focus south
    alt - k : chunkc tiling::window --focus north
    alt - l : chunkc tiling::window --focus east
    alt - n : chunkc tiling::window --focus prev
    alt - p : chunkc tiling::window --focus next

    # rotate tree
    alt - r : chunkc tiling::desktop --rotate 90

    # mirror tree y-axis
    alt - y : chunkc tiling::desktop --mirror vertical

    # mirror tree x-axis
    alt - x : chunkc tiling::desktop --mirror horizontal

    # toggle desktop offset
    alt - a : chunkc tiling::desktop --toggle offset

    # toggle window fullscreen
    alt - f : chunkc tiling::window --toggle fullscreen

    # toggle window native fullscreen
    shift + alt - f : chunkc tiling::window --toggle native-fullscreen

    # equalize size of windows
    shift + alt - 0 : chunkc tiling::desktop --equalize

    # swap window
    shift + alt - h : chunkc tiling::window --swap west
    shift + alt - j : chunkc tiling::window --swap south
    shift + alt - k : chunkc tiling::window --swap north
    shift + alt - l : chunkc tiling::window --swap east

    # move window
    shift + cmd - h : chunkc tiling::window --warp west
    shift + cmd - j : chunkc tiling::window --warp south
    shift + cmd - k : chunkc tiling::window --warp north
    shift + cmd - l : chunkc tiling::window --warp east

    # make floating window fill screen
    # shift + alt - up     : chunkc tiling::window --grid-layout 1:1:0:0:1:1

    # make floating window fill left-half of screen
    # shift + alt - left   : chunkc tiling::window --grid-layout 1:2:0:0:1:1

    # make floating window fill right-half of screen
    # shift + alt - right  : chunkc tiling::window --grid-layout 1:2:1:0:1:1

    # send window to desktop
    shift + alt - x : chunkc tiling::window --send-to-desktop $(chunkc get _last_active_desktop)
    shift + alt - z : chunkc tiling::window --send-to-desktop prev
    shift + alt - c : chunkc tiling::window --send-to-desktop next
    shift + alt - 1 : chunkc tiling::window --send-to-desktop 1
    shift + alt - 2 : chunkc tiling::window --send-to-desktop 2
    shift + alt - 3 : chunkc tiling::window --send-to-desktop 3
    shift + alt - 4 : chunkc tiling::window --send-to-desktop 4
    shift + alt - 5 : chunkc tiling::window --send-to-desktop 5
    shift + alt - 6 : chunkc tiling::window --send-to-desktop 6

    # send window to desktop and follow focus
    shift + cmd - x : chunkc tiling::window --send-to-desktop $(chunkc get _last_active_desktop); qes -k "cmd + alt - $(chunkc get _last_active_desktop)"
    shift + cmd - z : chunkc tiling::window --send-to-desktop prev; qes -k "cmd + alt - z"
    shift + cmd - c : chunkc tiling::window --send-to-desktop next; qes -k "cmd + alt - c"
    shift + cmd - 1 : chunkc tiling::window --send-to-desktop 1; qes -k "cmd + alt - 1"
    shift + cmd - 2 : chunkc tiling::window --send-to-desktop 2; qes -k "cmd + alt - 2"
    shift + cmd - 3 : chunkc tiling::window --send-to-desktop 3; qes -k "cmd + alt - 3"

    # focus monitor
    ctrl + alt - z  : chunkc tiling::monitor -f prev
    ctrl + alt - c  : chunkc tiling::monitor -f next
    ctrl + alt - 1  : chunkc tiling::monitor -f 1
    ctrl + alt - 2  : chunkc tiling::monitor -f 2
    ctrl + alt - 3  : chunkc tiling::monitor -f 3

    # send window to monitor and follow focus
    ctrl + cmd - z  : chunkc tiling::window --send-to-monitor prev; chunkc tiling::monitor -f prev
    ctrl + cmd - c  : chunkc tiling::window --send-to-monitor next; chunkc tiling::monitor -f next
    ctrl + cmd - 1  : chunkc tiling::window --send-to-monitor 1; chunkc tiling::monitor -f 1
    ctrl + cmd - 2  : chunkc tiling::window --send-to-monitor 2; chunkc tiling::monitor -f 2
    ctrl + cmd - 3  : chunkc tiling::window --send-to-monitor 3; chunkc tiling::monitor -f 3

    # increase region size
    cmd + alt - a : chunkc tiling::window --use-temporary-ratio 0.1 --adjust-window-edge west
    cmd + alt - s : chunkc tiling::window --use-temporary-ratio 0.1 --adjust-window-edge south
    cmd + alt - w : chunkc tiling::window --use-temporary-ratio 0.1 --adjust-window-edge north
    cmd + alt - d : chunkc tiling::window --use-temporary-ratio 0.1 --adjust-window-edge east

    # decrease region size
    shift + cmd - a : chunkc tiling::window --use-temporary-ratio -0.1 --adjust-window-edge west
    shift + cmd - s : chunkc tiling::window --use-temporary-ratio -0.1 --adjust-window-edge south
    shift + cmd - w : chunkc tiling::window --use-temporary-ratio -0.1 --adjust-window-edge north
    shift + cmd - d : chunkc tiling::window --use-temporary-ratio -0.1 --adjust-window-edge east

    # set insertion point for focused container
    # ctrl + alt - f : chunkc tiling::window --use-insertion-point cancel
    # ctrl + alt - h : chunkc tiling::window --use-insertion-point west
    # ctrl + alt - j : chunkc tiling::window --use-insertion-point south
    # ctrl + alt - k : chunkc tiling::window --use-insertion-point north
    # ctrl + alt - l : chunkc tiling::window --use-insertion-point east

    # toggle window parent zoom
    # alt - d : chunkc tiling::window --toggle parent

    # toggle window split type
    # alt - e : chunkc tiling::window --toggle split

    # toggle window fade
    # alt - q : chunkc tiling::window --toggle fade

    # float / unfloat window and center on screen
    # alt - t : chunkc tiling::window --toggle float;\
    #          chunkc tiling::window --grid-layout 4:4:1:1:2:2

    # toggle sticky, float and resize to picture-in-picture size
    # alt - s : chunkc tiling::window --toggle sticky;\
    #          chunkc tiling::window --grid-layout 5:5:4:0:1:1

    # float next window to be tiled
    # shift + alt - t : chunkc set window_float_next 1

    # change layout of desktop
    # ctrl + alt - a : chunkc tiling::desktop --layout bsp
    # ctrl + alt - s : chunkc tiling::desktop --layout monocle
    # ctrl + alt - d : chunkc tiling::desktop --layout float

    ctrl + alt - w : chunkc tiling::desktop --deserialize ~/.chunkwm_layouts/dev_1
  '';
}
