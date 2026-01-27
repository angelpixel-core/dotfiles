login_git() {
  eval "$(ssh-agent -s)"

  echo "📣 you must provide ssh auth ID Key Directory ‼️"
  ID_KEY_DIR="company/repos/github/local/orion"
  echo "🟠 ID_KEY_DIR: ${ID_KEY_DIR}"
  ssh-add ~/.ssh/${ID_KEY_DIR}/key
}

login_1p() {
  op signin
}
