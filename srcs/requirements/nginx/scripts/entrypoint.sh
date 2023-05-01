#!/bin/sh

replace_env_var() {
  local file_path="$1"   # file path as first parameter
  local var_name="$2"    # name of the environment variable as second parameter

  # Check if file exists
  if [[ ! -f "$file_path" ]]; then
    echo "File '$file_path' not found."
    return 1
  fi

  # Get the value of the environment variable using printenv
  local var_value=$(printenv "$var_name")

  # Check if environment variable exists
  # -z: true if the length of string is zero
  if [[ -z "$var_value" ]]; then
    echo "Environment variable '$var_name' not set."
    return 1
  fi

  # Replace occurrences of "${VARIABLE_NAME}" with the value of the environment variable
  sed -i "s|\${$var_name}|$var_value|g" "$file_path"
}

# Replace env variables in the config file of NGINX
replace_env_var /etc/nginx/http.d/nginx.conf "DOMAIN_NAME"

# Run nginx in foreground
nginx -g "daemon off;"
