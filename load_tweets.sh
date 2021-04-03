files='
test-data.zip
'

for file in $files; do
    # call the load_tweets.py file to load data into pg_normalized
    ./load_tweets.py --db=postgresql://postgres:pass@localhost:23088/postgres --inputs=$file 
done

for file in $files; do
    unzip -p $file | sed 's/\\u0000//g' | psql postgres://postgres:pass@localhost:13088/ -c "COPY tweets_jsonb (data) FROM STDIN csv quote e'\x01' delimiter e'\x02';" 
   # psql postgres://postgres:pass@localhost:13088/postgres
    # use SQL's COPY command to load data into pg_denormalized
    # postgresql://password:username@host:port/database
done
