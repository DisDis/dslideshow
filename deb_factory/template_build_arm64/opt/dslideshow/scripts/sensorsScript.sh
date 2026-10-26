#!/bin/sh
#format:
#<sensor name>=<value>
#example:
#temp=61.3'C
#sensors | grep "Package id 0"
#Test sensors:
# echo "temp=61.3'C"
# echo "fan1=2000rpm"
# echo "fan2=0rpm"
# echo "button0=false"
# echo "button1=true"
# echo "human1=detected"

# Optional sysfs root for an offline fixture or a mounted target filesystem.
sysfs_root=${DSLIDESHOW_SYSFS_ROOT:-/sys}
collection_status=1

# Read exactly one sysfs value, including a final line without a newline.
# Redirection/read errors keep their diagnostics on stderr.
read_attribute() {
    attribute=
    remainder=
    {
        if ! IFS= read -r attribute && [ -z "$attribute" ]; then
            return 1
        fi
        if IFS= read -r remainder || [ -n "$remainder" ]; then
            return 1
        fi
    } < "$1"
}

# Buffer the output so a failed command cannot publish a partial measurement.
if temperature=$(vcgencmd measure_temp); then
    if [ -n "$temperature" ]; then
        printf '%s\n' "$temperature"
        collection_status=0
    else
        printf '%s\n' 'sensorsScript: vcgencmd returned no temperature data' >&2
    fi
else
    temperature_status=$?
    printf 'sensorsScript: vcgencmd measure_temp failed (exit %s)\n' "$temperature_status" >&2
fi

# The Raspberry Pi 5 board fan belongs to cooling_fan. Other hwmon devices,
# including fans on other hardware, must not be mistaken for this sensor.
fan_device=
fan_count=0
for hwmon in "$sysfs_root"/devices/platform/cooling_fan/hwmon/hwmon*; do
    [ -d "$hwmon" ] || continue
    if ! read_attribute "$hwmon/name"; then
        printf 'sensorsScript: cannot read hwmon name: %s\n' "$hwmon/name" >&2
        continue
    fi
    [ "$attribute" = pwmfan ] || continue
    fan_device=$hwmon
    fan_count=$((fan_count + 1))
done

if [ "$fan_count" -gt 1 ]; then
    printf '%s\n' 'sensorsScript: ambiguous cooling_fan hwmon devices' >&2
elif [ "$fan_count" -eq 1 ] && [ -e "$fan_device/fan1_input" ]; then
    if read_attribute "$fan_device/fan1_input"; then
        case $attribute in
            ''|*[!0-9]*)
                printf 'sensorsScript: invalid RPM in %s\n' "$fan_device/fan1_input" >&2
                ;;
            *)
                printf 'fan1=%srpm\n' "$attribute"
                collection_status=0
                ;;
        esac
    else
        printf 'sensorsScript: cannot read one RPM value: %s\n' "$fan_device/fan1_input" >&2
    fi
fi

# An absent optional fan is normal (e.g. on Pi 4). Partial success must not
# discard the other sensors; the backend logs stderr even on exit 0.
exit "$collection_status"
