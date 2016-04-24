#!/bin/bash

sed -e's/app.havenly.com/rewrite.havenly.local/g' ~/www/havenly/production.sql |
    sed -e's/havenly.com/cms.havenly.local/g' |
    sed -e's/havenly_app/CMS/g' > ~/www/havenly/local-production.sql
