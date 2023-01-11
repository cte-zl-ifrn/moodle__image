# moodle

```bash
docker compose down && ./release.sh build 002 401 && rm -rf volumes && git checkout volumes/ava/moodledata/filedir/.empty && chown -R www-data:www-data volumes/ava/moodledata/filedir && docker compose up
```