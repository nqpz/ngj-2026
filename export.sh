#!/bin/sh
#
# Export for web.

cd "$(dirname "$0")"
godot --export-release Web
cd export
./zip.sh
