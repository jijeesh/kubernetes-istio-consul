function get_download_url {
	# wget -q -nv -O- https://api.github.com/repos/$1/$2/releases/latest 2>/dev/null |  jq -r '.assets[] | select(.browser_download_url |  .browser_download_url'
  wget -q -nv -O- https://api.github.com/repos/$1/$2/releases/latest 2>/dev/null |  jq -r '.assets[] | select(.browser_download_url) | .browser_download_url'
}

function update_repository {
	URL=$(get_download_url $1 $2)

	BASE=$(basename $URL)
	# wget -q -nv -O $BASE $URL
	if [ ! -f $BASE ]; then
		echo "Didn't download $URL properly.  Where is $BASE?"
		exit 1
	fi

}

update_repository hashicorp consul-helm
