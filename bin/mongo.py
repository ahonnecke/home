from os import environ

import pymongo

mongo_arguments = {
    'host': environ.get('DDB_HOST'),
    'port': int(environ.get('DDB_PORT')),
    'username': environ.get('DDB_USER'),
    'password': environ.get('DDB_PW'),
    'ssl': True,
    'ssl_ca_certs': environ.get('RDS_PEM_PATH', '/root/rds-combined-ca-bundle.pem'),
    'serverSelectionTimeoutMS': 5000,
}

client = pymongo.MongoClient(**mongo_arguments)

client.database_names()

pymongo db names
