#!/bin/bash

# options=$(ls -1 /usr/lib64/php/modules| \

#                  grep --invert-match xdebug| \

#                  # remove problematic extensions
#                  egrep --invert-match 'mysql|wddx|pgsql'| \

#                  sed --expression 's/\(.*\)/ --define extension=\1/'| \

#                  # join everything together back in one big line
#                  tr -d '\n'
#        )

# # build the final command line
# php --no-php-ini $options ./composer.phar $*

php -n -d extension=json.so ./composer.phar $*