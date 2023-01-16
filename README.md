# moodle

```bash
docker compose down && sudo rm -rf volumes && ./release.sh build 401 009 && git checkout volumes/ava/moodledata/filedir/.empty && sudo chown -R www-data:www-data volumes/ava/moodledata/filedir && docker compose up
```