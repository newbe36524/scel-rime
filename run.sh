#!/bin/bash

# Check if yq is installed
if ! command -v yq &> /dev/null
then
    echo "yq could not be found, please install it first"
    exit 1
fi

# Extract dictionary IDs from URLs
DICT_IDS=($(yq e '.rime.urls | to_entries | .[].value | split("/") | .[-1]' config.yml))

# Get dictionary names
DICT_NAMES=($(yq e '.rime.urls | to_entries | .[].key' config.yml))

DICT_SHORTS=()
for name in "${DICT_NAMES[@]}"; do
    short_name=""
    # create hash for url as short name, in 6 characters
    short_name=$(echo -n "$name" | md5sum | cut -c1-6)
    DICT_SHORTS+=("${short_name%_}")
done

# Get other configuration values
DICT_PREFIX=$(yq e '.rime.dict.prefix' config.yml)
DICT_MASTER_NAME=$(yq e '.rime.dict.master_name' config.yml)

# Iterate over each out entry
yq e '.rime.out | to_entries | .[].value' config.yml | while read -r COPY; do
    # Generate the config file
    config_file="config"
    cat > "$config_file" <<EOF
#!/bin/bash
DICT_IDS=(
$(printf "  \"%s\"\n" "${DICT_IDS[@]}")
)

DICT_NAMES=(
$(printf "  \"%s\"\n" "${DICT_NAMES[@]}")
)

DICT_SHORTS=(
$(printf "  \"%s\"\n" "${DICT_SHORTS[@]}")
)

DICT_PREFIX="$DICT_PREFIX"
DICT_MASTER_NAME="$DICT_MASTER_NAME"
COPY="$COPY"
#HOOK_AFTER="rime_deployer --build \$COPY /usr/share/rime-data"
EOF

    # Check if file was created successfully
    if [ -f "$config_file" ]; then
        echo "Config file $config_file generated successfully"
        ./fetch.sh
    else
        echo "Failed to generate config file $config_file"
        exit 1
    fi
done