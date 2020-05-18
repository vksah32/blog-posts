#!/bin/bash
fswatch -e ".*" -i "\\.md$" -0 ./ | while read -d "" event 
do 
    # check any untracked files
    for f in `git ls-files --others --exclude-standard`; do
		git add "$f"
		git commit -m "Added $f"
    done

    #check any modified files
    for f in `git ls-files --modified`; do
    	git add "$f"
    	git commit -m "Modified $f"
    done
    git push origin master
done
