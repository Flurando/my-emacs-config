# Disable access control for the current user.
xhost +SI:localuser:$USER

# Set themes, etc.
gnome-settings-daemon &

# Make Java applications aware this is a non-reparenting window manager.
export _JAVA_AWT_WM_NONREPARENTING=1

# Set default cursor.
xsetroot -cursor_name left_ptr

# Set keyboard repeat rate.
xset r rate 200 60

# Uncomment the following block to use the exwm-xim module
#export XMODIFIERS=@im=exwm-wim
#export GTK_IM_MODULE=xim
#export QT_IM_MODULE=xim
#export CLUTTER_IM_MODULE=xim

export VISUAL=emacsclient
export EDITOR="$VISUAL"

# Finally start emacs
#exec dbus-launch --exit-with-session emacs -mm --debug-init
