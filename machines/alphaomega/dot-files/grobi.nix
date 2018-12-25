{}:''
# These are the rules grobi tries to match to the current output configuration.
# The rules are evaluated top to bottom, the first matching rule is applied and
# processing stops.
#
# The rules belowe are written for a typical Laptop in mind, which hase several
# external connectors (DP2, HDMI) in addition to the internal display
# (eDP1). It may even be placed in a Docking Station, which adds more outputs
# that aren't present outside it.
rules:

  # This is a rule for a homeoffice's docking station.
  - name: HomeOffice
    outputs_connected: [eDP1, DP2]
    outputs_present: [DP2]
    configure_single: DP2
    atomic: true
    primary: DP2
    # execute_after:
    #   - xrandr --dpi 96
    #   - "echo Xft.dpi: 96 | xrdb -merge"
    #   - i3-msg restart

  # This is a rule for mobile computing, i.e. outside of the docking station defined above.
  - name: Mobile
    outputs_connected: [eDP1, DP2]
    outputs_present: [eDP1]
    outputs_disconnected: [DP2]
    configure_single: eDP1
    primary: eDP1
    # execute_after:
    #   - xrandr --dpi 144
    #   - "echo Xft.dpi: 144 | xrdb -merge"
    #   - i3-msg restart

  - name: Fallback
    configure_single: eDP1
''
