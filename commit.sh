# Clean up latex output, add all changes, and commit to repository

# Make sure we have a commit message
if [ "$#" -ne 1 ]; then
  echo "Need commit message"
  exit
fi

# Clean up latex output
./clean.sh

# Add all changes and commit with the input message
git add -A
git commit -m "$1"

git push -u origin
#if [ "$#" -ne 2 ]; then
#  git push -u origin master
#else
#  git push -u origin $2
#fi
