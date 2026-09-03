# idle-metadata-remover

Removes various metadata from files when idle for X minutes.

By default, the script scans subdirectories of `$HOME/Nextcloud` and uses
`$HOME/Downloads` as an additional work directory. Set `SYNC_ROOT` and
`DOWNLOADS_DIR` to override those locations without editing the script.

Needs xprintidle and mat2 :
`sudo apt install xprintidle mat2`

Also check if you have all mat2 dependencies (check `mat2 --help` for instructions on how to do this)

And check if `cat /sys/class/power_supply/BAT1/status` works for you, else maybe change it to BAT0
