{config, ...}: {
  home.shellAliases = {
    zj = "zellij";
  };

  programs.zellij.enable = true;

  xdg.configFile."zellij/config.kdl".text = let
    colours = config.scheme.withHashtag;
  in ''
    default_mode "locked"

    keybinds clear-defaults=true {
        normal {
            bind "q" { Quit; }
            bind "d" { Detach; }

            bind "p" { SwitchToMode "Pane"; }
            bind "t" { SwitchToMode "Tab"; }
            bind "s" { SwitchToMode "Scroll"; }

            bind "r" { SwitchToMode "Resize"; }

            bind "w" {
                LaunchOrFocusPlugin "zellij:session-manager" {
                    floating true
                    move_to_focused_tab true
                };
                SwitchToMode "Locked"
            }

            bind "n" { NewPane; SwitchToMode "Locked"; }

            bind "h" { MoveFocusOrTab "Left"; }
            bind "j" { MoveFocus "Down"; }
            bind "k" { MoveFocus "Up"; }
            bind "l" { MoveFocusOrTab "Right"; }

            bind "H" { MovePane "Left"; }
            bind "J" { MovePane "Down"; }
            bind "K" { MovePane "Up"; }
            bind "L" { MovePane "Right"; }
        }

        locked {
            bind "Alt ;" { SwitchToMode "Normal"; }

            bind "Alt n" { NewPane; SwitchToMode "Locked"; }

            bind "Alt h" { MoveFocusOrTab "Left"; }
            bind "Alt l" { MoveFocusOrTab "Right"; }
            bind "Alt j" { MoveFocus "Down"; }
            bind "Alt k" { MoveFocus "Up"; }
        }

        shared_except "locked" {
            bind "Esc" { SwitchToMode "Locked"; }
        }

        resize {
            bind "h" { Resize "Increase Left"; }
            bind "j" { Resize "Increase Down"; }
            bind "k" { Resize "Increase Up"; }
            bind "l" { Resize "Increase Right"; }

            bind "H" { Resize "Decrease Left"; }
            bind "J" { Resize "Decrease Down"; }
            bind "K" { Resize "Decrease Up"; }
            bind "L" { Resize "Decrease Right"; }

            bind "i" { Resize "Increase"; }
            bind "d" { Resize "Decrease"; }
        }

        pane {
            bind "n" { NewPane; SwitchToMode "Locked"; }
            bind "j" { NewPane "Down"; SwitchToMode "Locked"; }
            bind "l" { NewPane "Right"; SwitchToMode "Locked"; }

            bind "q" { CloseFocus; SwitchToMode "Locked"; }

            bind "r" { SwitchToMode "RenamePane"; PaneNameInput 0; }

            bind "f" { ToggleFocusFullscreen; SwitchToMode "Locked"; }

            bind "z" { TogglePaneFrames; SwitchToMode "Locked"; }
        }

        renamepane {
            bind "Esc"   { UndoRenamePane; SwitchToMode "Pane"; }
            bind "Enter" { SwitchToMode "Pane"; }
        }

        tab {
            bind "n" { NewTab; SwitchToMode "Locked"; }
            bind "q" { CloseTab; SwitchToMode "Locked"; }

            bind "h" { GoToPreviousTab; }
            bind "l" { GoToNextTab; }

            bind "r" { SwitchToMode "RenameTab"; TabNameInput 0; }

            bind "b" { BreakPane; SwitchToMode "Locked"; }
            bind "]" { BreakPaneRight; SwitchToMode "Locked"; }
            bind "[" { BreakPaneLeft; SwitchToMode "Locked"; }
        }

        renametab {
            bind "Esc"   { UndoRenameTab; SwitchToMode "Tab"; }
            bind "Enter" { SwitchToMode "Tab"; }
        }

        scroll {
            bind "e"            { EditScrollback; SwitchToMode "Locked"; }
            bind "s"            { SwitchToMode "EnterSearch"; SearchInput 0; }
            bind "Ctrl c"       { ScrollToBottom; SwitchToMode "Locked"; }
            bind "j"            { ScrollDown; }
            bind "k"            { ScrollUp; }
            bind "PageDown" "l" { PageScrollDown; }
            bind "PageUp"   "h" { PageScrollUp; }
            bind "d"            { HalfPageScrollDown; }
            bind "u"            { HalfPageScrollUp; }
        }

        search {
            bind "Ctrl c"       { ScrollToBottom; SwitchToMode "Locked"; }
            bind "j"            { ScrollDown; }
            bind "k"            { ScrollUp; }
            bind "PageDown" "l" { PageScrollDown; }
            bind "PageUp"   "h" { PageScrollUp; }
            bind "d"            { HalfPageScrollDown; }
            bind "u"            { HalfPageScrollUp; }
            bind "n"            { Search "down"; }
            bind "p"            { Search "up"; }
            bind "c"            { SearchToggleOption "CaseSensitivity"; }
            bind "w"            { SearchToggleOption "Wrap"; }
            bind "o"            { SearchToggleOption "WholeWord"; }
        }

        entersearch {
            bind "Esc"   { SwitchToMode "Scroll"; }
            bind "Enter" { SwitchToMode "Search"; }
        }
    }

    plugins {
        compact-bar     { path "compact-bar"; }
        session-manager { path "session-manager"; }
    }

    themes {
        default {
            fg      "${colours.base07}"
            bg      "${colours.base00}"
            black   "${colours.base00}"
            red     "${colours.red}"
            green   "${colours.green}"
            yellow  "${colours.yellow}"
            blue    "${colours.blue}"
            magenta "${colours.magenta}"
            cyan    "${colours.cyan}"
            white   "${colours.base07}"
            orange  "${colours.orange}"
        }
    }
  '';

  xdg.configFile."zellij/layouts/default.kdl".text = ''
    layout {
        pane
        pane size=1 borderless=true {
            plugin location="zellij:compact-bar"
        }
    }
  '';

  xdg.configFile."zellij/layouts/sysmon.kdl".text = ''
    layout {
        pane split_direction="vertical" {
            pane command="btm"
            pane command="bmon"
        }
        pane size=1 borderless=true {
            plugin location="zellij:compact-bar"
        }
    }
  '';
}
