#!/bin/bash

GH_USERNAME='ahonnecke'

cd ~/repos/all
git clone git@github.com:$GH_USERNAME/HypeScript.git
cd HypeScript

cd ~/repos/all
git clone git@github.com:$GH_USERNAME/bulk-hogan.git
cd bulk-hogan
git remote add upstream git@github.com:digital-assets-data/bulk-hogan.git

cd ~/repos/all
git clone git@github.com:$GH_USERNAME/ccxtwo.git
cd ccxtwo
git remote add upstream git@github.com:digital-assets-data/ccxtwo.git

cd ~/repos/all
git clone git@github.com:$GH_USERNAME/doppler.git
cd doppler
git remote add upstream git@github.com:digital-assets-data/doppler.git

cd ~/repos/all
git clone git@github.com:$GH_USERNAME/dsl-demo.git
cd dsl-demo
git remote add upstream git@github.com:digital-assets-data/dsl-demo.git

cd ~/repos/all
git clone git@github.com:$GH_USERNAME/forex-rate-ingestion.git
cd forex-rate-ingestion
git remote add upstream git@github.com:digital-assets-data/forex-rate-ingestion.git

cd ~/repos/all
git clone git@github.com:$GH_USERNAME/infra.git
cd infra
git remote add upstream git@github.com:digital-assets-data/infra.git

cd ~/repos/all
git clone git@github.com:$GH_USERNAME/infra-deploy.git
cd infra-deploy
git remote add upstream git@github.com:digital-assets-data/infra-deploy.git

cd ~/repos/all
git clone git@github.com:$GH_USERNAME/lambda-bulk-hogan.git
cd lambda-bulk-hogan
git remote add upstream git@github.com:digital-assets-data/lambda-bulk-hogan.git

cd ~/repos/all
git clone git@github.com:$GH_USERNAME/lambda-market-fixer.git
cd lambda-market-fixer
git remote add upstream git@github.com:digital-assets-data/lambda-market-fixer.git

cd ~/repos/all
git clone git@github.com:$GH_USERNAME/market-fixer.git
cd market-fixer
git remote add upstream git@github.com:digital-assets-data/market-fixer.git

cd ~/repos/all
git clone git@github.com:$GH_USERNAME/dad.panic.git
cd panic
git remote add upstream git@github.com:digital-assets-data/dad-alert.git

cd ~/repos/all
git clone git@github.com:$GH_USERNAME/postgres-serverless.git
cd postgres-serverless
git remote add upstream git@github.com:digital-assets-data/postgres-serverless.git

cd ~/repos/all
git clone git@github.com:$GH_USERNAME/terraform-modules.git
cd terraform-modules
git remote add upstream git@github.com:digital-assets-data/terraform-modules.git

cd ~/repos/all
git clone git@github.com:digital-assets-data/timescale-monitor-lambda.git
cd timescale-monitor-lambda
git remote add

cd ~/repos/all
git clone git@github.com:$GH_USERNAME/timescale-schema-migrations.git
cd timescale-schema-migrations
git remote add upstream git@github.com:digital-assets-data/timescale-schema-migrations.git

cd ~/repos/all
git clone git@github.com:$GH_USERNAME/timescale-stored-procedures.git
cd timescale-stored-procedures
git remote add upstream git@github.com:digital-assets-data/timescale-stored-procedures.git

cd ~/repos/all
git clone git@github.com:$GH_USERNAME/web.git
cd web
git remote add upstream git@github.com:digital-assets-data/web.git
