#!/usr/bin/env bash
niri msg --json event-stream | while IFS= read -r line; do
    case "$line" in
        *'"WindowClosed":'*)
            niri msg action focus-column-left
            niri msg action focus-column-right
            ;;
    esac
done
