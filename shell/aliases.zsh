# PRIVATE VARS
if [ -f ~/.private-local-config.zsh ]
then
    source ~/.private-local-config.zsh
fi

# PORTABLE ALIASES & FUNCTIONS
# ============================
alias notes="nvim ~/Code/personal/zettelkasten/index.md"
alias v="nvim"
alias vi=v
alias vim=vi
alias vd="nvim -d"
alias ls=eza
alias l="ls -l"
alias la="l -a"
alias acreds="v ~/.aws/credentials"
alias latest_commit_hash='git log | head -n1 | awk "{print \$2;}"'

aws-sso() {
    local profile=""

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --profile)
                profile="$2"
                shift 2
                ;;
            *)
                echo "Unknown option: $1"
                echo "Usage: aws-sso --profile PROFILE_NAME"
                return 1
                ;;
        esac
    done

    # Check if profile was provided
    if [[ -z "$profile" ]]; then
        echo "Error: --profile argument is required"
        echo "Usage: aws-sso --profile PROFILE_NAME"
        return 1
    fi

    # Clear existing AWS credentials
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
    unset AWS_SESSION_TOKEN

    # Perform SSO login
    aws sso login --profile "$profile"

    # Export credentials from the profile
    eval $(aws configure export-credentials --profile "$profile" --format env)
}

docker-rm-all() {
    docker rm $(docker ps -a -q)
    docker rmi $(docker images -q)
    docker system prune --volumes
}

docker-kill () {
    docker kill `docker ps | tail -n+2 | awk '{print $1 " " $2}' | grep $1 | awk '{print $1}'`
}

to-mp3 (){
    ffmpeg -i $1 -vn -ar 44100 -ac 2 -b:a 320k $2
}

to-mp4 (){
    ffmpeg -i $1 -vcodec h264 -acodec aac -strict -2 $2
}

to-wav (){
    ffmpeg -i $1 -acodec pcm_s16le -ac 2 -ar 16000 $2
}

clean-git-branches () {
    merged_branches=`git branch --merged | grep -v "\* main"`
    for branch in $merged_branches
    do
        git branch -d "$branch"
    done
    git remote prune origin
}





