{
  config,
  pkgs,
  lib,
  ...
}: let
  secrets = import ./secrets.nix;
in {
  home.packages = with pkgs; [
    neomutt
    w3m
  ];

  xdg.configFile."neomutt/neomuttrc".text = ''
    set editor                  = "$EDITOR"
    set mbox_type               = Maildir
    set edit_headers
    set mime_type_query_command = 'xdg-mime query filetype'
    set sort                    = 'reverse-date'
    set fast_reply                                            # skip to compose when replying
    set fcc_attach                                            # save attachments with the body
    set forward_format          = 'Fwd: %s'                   # format of subject when forwarding
    set forward_quote                                         # include message in forwards
    set reverse_name                                          # reply as whomever it was to
    set include                                               # include message in replies
    set mark_old                = no                          # Unread mail stay unread until read
    set mime_forward            = yes                         # attachments are forwarded with mail
    set rfc2047_parameters      = yes
    set date_format             = "%Y-%m-%d"
    set index_format            = "%4C %Z %d %-25.25L %s"
    auto_view text/html
    alternative_order text/plain text/enriched text/html

    # Sidebar
    set sidebar_visible         = yes
    set sidebar_next_new_wrap   = yes
    set sidebar_short_path      = yes
    set sidebar_delim_chars     = '/'
    set sidebar_folder_indent   = yes
    set sidebar_indent_string   = '  '
    set mail_check_stats
    set sidebar_format          = '%B%?F? [%F]?%* %?N?%N/? %?S?%S?'
    bind index,pager K sidebar-prev
    bind index,pager J sidebar-next
    bind index,pager o sidebar-open

    # Default index colors
    color index         yellow  default '.*'
    color index_author  red     default '.*'
    color index_number  blue    default
    color index_subject cyan    default '.*'

    # New mail is boldened
    color index         brightyellow  default "~N"
    color index_author  brightred     default "~N"
    color index_subject brightcyan    default "~N"

    # Tagged mail is highlighted
    color index         brightyellow  blue  "~T"
    color index_author  brightred     blue  "~T"
    color index_subject brightcyan    blue  "~T"

    # Other colors and aesthetic settings
    mono bold               bold
    mono underline          underline
    mono indicator          reverse
    mono error              bold
    color normal            default       default
    color indicator         brightblack   white
    color sidebar_highlight red           default
    color sidebar_divider   brightblack   default
    color sidebar_flagged   red           default
    color sidebar_new       green         default
    color normal            brightyellow  default
    color error             red           default
    color tilde             black         default
    color message           cyan          default
    color markers           red           white
    color attachment        white         default
    color search            brightmagenta default
    color status            brightyellow  default
    color hdrdefault        brightgreen   default
    color quoted            green         default
    color quoted1           blue          default
    color quoted2           cyan          default
    color quoted3           yellow        default
    color quoted4           red           default
    color quoted5           brightred     default
    color signature         brightgreen   default
    color bold              black         default
    color underline         black         default
    color normal            default       default

    # Mailboxes
    set folder    = ~/.mail/

    set spoolfile = "+local/Inbox"
    set record    = "+local/Sent"
    set trash     = "+local/Trash"
    set postponed = "+local/Drafts"

    mailboxes \
      +local \
      +local/Inbox \
      +local/Sent \
      +local/Archive \
      +local/Drafts \
      +local/Trash

    mailboxes ${lib.strings.concatMapStringsSep " " (x: "+local/" + x) secrets.extra-local-mailboxes}

    # Account: fastmail
    mailboxes \
      +fastmail \
      +fastmail/Inbox \
      +fastmail/Spam

    folder-hook \
      "+fastmail.*" \
      'source ~/${config.xdg.configFile."neomutt/accounts/fastmail".target}'

    # Account: gmail
    mailboxes \
      +gmail \
      +gmail/Inbox \
      "+gmail/[Google Mail]" \
      "+gmail/[Google Mail]/Spam"

    folder-hook \
      "+gmail.*" \
      'source ~/${config.xdg.configFile."neomutt/accounts/gmail".target}'

    # Account: outlook-1
    mailboxes \
      +outlook-1 \
      +outlook-1/Inbox \
      +outlook-1/Junk

    folder-hook \
      "+outlook-1.*" \
      'source ~/${config.xdg.configFile."neomutt/accounts/outlook-1".target}'

    # Account: outlook-2
    mailboxes \
      +outlook-2 \
      +outlook-2/Inbox \
      +outlook-2/Junk

    folder-hook \
      "+outlook-2.*" \
      'source ~/${config.xdg.configFile."neomutt/accounts/outlook-2".target}'
  '';

  xdg.configFile."neomutt/accounts/fastmail".text = let
    a = secrets.accounts.fastmail;
  in ''
    set from = "${a.address}"
    set realname  = "${a.realName}"
    set sendmail = "msmtp -a fastmail"
  '';

  xdg.configFile."neomutt/accounts/gmail".text = let
    a = secrets.accounts.gmail;
  in ''
    set from = "${a.address}"
    set realname  = "${a.realName}"
    set sendmail = "msmtp -a gmail"
  '';

  xdg.configFile."neomutt/accounts/outlook-1".text = let
    a = secrets.accounts.outlook-1;
  in ''
    set from = "${a.address}"
    set realname  = "${a.realName}"
    set sendmail = "msmtp -a outlook-1"
  '';

  xdg.configFile."neomutt/accounts/outlook-2".text = let
    a = secrets.accounts.outlook-2;
  in ''
    set from = "${a.address}"
    set realname  = "${a.realName}"
    set sendmail = "msmtp -a outlook-2"
  '';
}
