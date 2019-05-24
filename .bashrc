# NOTE: source order is important!

# figure out ROOT directory
DOTROOT=$(dirname $(realpath "$HOME/.bashrc"))

# generic setup files
source "${DOTROOT}/bashrc/.default"
source "${DOTROOT}/bashrc/.env"
source "${DOTROOT}/bashrc/.alias"
source "${DOTROOT}/bashrc/.fun"

# host-specific setup files
source "${DOTROOT}/bashrc/.host"
