#!/bin/sh -e
#

# Always run in virtual environment. Create it if needed
if [ -z "$VIRTUAL_ENV" ]; then
    [ -d "$(dirname "$0")/venv" ] || (cd "$(dirname "$0")" && virtualenv -p python3 venv) 
    # shellcheck disable=SC1091
    cd "$(dirname "$0")" && . venv/bin/activate && cd - > /dev/null
fi

# Shellcheck over scripts into 'scripts' subfolder
find scripts -type f \( -name "*.sh" -o -name "*.bash" -o -name "*.ksh" -o -name "*.bashrc" -o -name "*.bash_profile" -o -name "*.bash_login" -o -name "*.bash_logout" \) -print |
while IFS="" read -r file; do
    shellcheck -x -- "$file"
done

# Ignore E501 line too long and skip tests and 
# virtual environment folders
(cd "$(dirname "$0")" && flake8 . --exclude=venv,tests --ignore E501)
