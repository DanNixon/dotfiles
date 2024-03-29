{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    neomutt
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
    set folder = ~/.mail/

    # Account: fastmail
    mailboxes \
      +fastmail \
      +fastmail/Inbox \
      +fastmail/Archive \
      +fastmail/Drafts \
      +fastmail/Sent \
      +fastmail/Spam \
      +fastmail/Trash
  '';
}
