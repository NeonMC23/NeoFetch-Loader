#!/bin/bash

FASTFETCH_DIR="$HOME/.config/fastfetch"
LIST="$FASTFETCH_DIR/logos/list.json"


# Choisir un logo aléatoire
COUNT=$(jq '.logos | length' "$LIST")
INDEX=$((RANDOM % COUNT))


# Récupérer le logo
LOGO=$(jq -r ".logos[$INDEX].path" "$LIST")


# Récupérer les couleurs
COLOR1=$(jq -r ".logos[$INDEX].colors[\"1\"]" "$LIST")


COLOR2=$(jq -r ".logos[$INDEX].colors[\"2\"] // empty" "$LIST")


# Lancer fastfetch
fastfetch \
--logo-type file \
--logo "$LOGO" \
--logo-color-1 "$COLOR1" \
${COLOR2:+--logo-color-2 "$COLOR2"}