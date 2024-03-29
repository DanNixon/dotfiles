case "$2" in
  "set")
    new="$3"
    ;;
  "adjust")
    current="$(ddcutil getvcp --terse "$1" | cut -d' ' -f 4)"
    new="$(echo "$current $3" | bc)"
    ;;
  *)
    exit 1
    ;;
esac

ddcutil setvcp "$1" "$new"
