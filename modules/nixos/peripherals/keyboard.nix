{...}: {
  services.kanata = {
    enable = true;

    keyboards.default = {
      extraDefCfg = ''
        block-unmapped-keys yes
        process-unmapped-keys yes

        linux-dev-names-include (
          "AT Translated Set 2 keyboard"
        )
      '';

      config = ''
        (defsrc
          q     w     e     r     t       y     u     i     o     p
          a     s     d     f     g       h     j     k     l     ;
          z     x     c     v     b       n     m     ,     .     /
                            lalt  tab     ret   spc

          volu voldwn mute
        )

        (deflocalkeys-linux
          # 43
          \ 86
        )

        (defalias
          !   S-1
          £   S-3
          $   S-4
          %   S-5
          ^   S-6
          &   S-7
          *   S-8
          _   S--
          :   S-;
          <   S-,
          >   S-.
          ?   S-/
          |   S-\
          ~   S-#

          a   (tap-hold 200 200 a lsft)
          ;   (tap-hold 200 200 ; rsft)

          x   (tap-hold 200 200 x lalt)
          c   (tap-hold 200 200 c lctl)

          ,   (tap-hold 200 200 , rctl)
          .   (tap-hold 200 200 . ralt)

          f   (tap-hold 200 200 f (layer-while-held symbols_right))
          d   (tap-hold 200 200 d (layer-while-held navigation))
          j   (tap-hold 200 200 j (layer-while-held symbols_left))
          k   (tap-hold 200 200 k (layer-while-held number))

          lt1 (tap-hold 200 200 esc lmet)
          lt2 tab
          rt1 ret
          rt2 spc
        )

        (deflayer normal
          q     w     e     r     t       y     u     i     o     p
          @a    s     @d    @f    g       h     @j    @k    l     @;
          z     @x    @c    v     b       n     m     @,    @.    XX
                            @lt1  @lt2    @rt1  @rt2

          volu voldwn mute
        )

        (deflayer number
          /     7     8     9     +       XX    XX    XX    XX    XX
          0     1     2     3     -       XX    .     XX    @£    @:
          @*    4     5     6     =       XX    XX    XX    XX    XX
                            XX    XX      del   bspc

          volu voldwn mute
        )

        (deflayer symbols_left
          XX    @!    @<    @>    XX      XX    XX    XX    XX    XX
          {     }     S-9   S-0   S-'     XX    XX    =     +     @%
          XX    @?    [     ]     XX      XX    XX    XX    XX    XX
                            XX    XX      del   bspc

          volu voldwn mute
        )

        (deflayer symbols_right
          XX    XX    XX    XX    XX      XX    @_    @|    '     XX
          @^    @*    @&    XX    XX      #     -     /     S-2   @$
          XX    XX    XX    XX    XX      XX    @~    \     `     XX
                            XX    XX      del   bspc

          volu voldwn mute
        )

        (deflayer navigation
          XX    XX    XX    XX    XX      home  pgdn  pgup  end   XX
          XX    XX    XX    XX    XX      left  down  up    right XX
          XX    XX    XX    XX    XX      XX    XX    XX    XX    XX
                            XX    XX      del   bspc

          volu voldwn mute
        )
      '';
    };
  };
}
