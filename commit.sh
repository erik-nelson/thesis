# Clean up latex output, add all changes, and commit to repository

# Make sure we have a commit message
if [ "$#" -ne 1 ]; then
  echo "Need commit message"
  exit
fi

./clean.sh

git add -A
git commit -m "$1"
git push -u origin master
