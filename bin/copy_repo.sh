#Create the repository ( lambda-backfiller in this example)

#@TODO parameterize
#@TODO script initial repo creation

$REPONAME="lambda-backfiller"

cd src
git clone git@github.com:digital-assets-data/$REPO_NAME.git
cd $REPO_NAME

# Add an existing repository as a source
git remote add source git@github.com:digital-assets-data/lambda-market-fixer.git

git remote update

git pull source refs/heads/master
# From github.com:digital-assets-data/lambda-market-fixer
# * branch            master     -> FETCH_HEAD
git remote -v
# ahonnecke@antonym:~/src/lambda-backfiller$ git remote -v
# origin        git@github.com:digital-assets-data/lambda-backfiller.git (fetch)
# origin        git@github.com:digital-assets-data/lambda-backfiller.git (push)
# source        git@github.com:digital-assets-data/lambda-market-fixer.git (fetch)
# source        git@github.com:digital-assets-data/lambda-market-fixer.git (push)

git remote rm source
# ahonnecke@antonym:~/src/lambda-backfiller$ git remote rm source

git remote -v
# ahonnecke@antonym:~/src/lambda-backfiller$ git remote -v
# origin        git@github.com:digital-assets-data/lambda-backfiller.git (fetch)
# origin        git@github.com:digital-assets-data/lambda-backfiller.git (push)
