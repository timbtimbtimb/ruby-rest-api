# ruby-rest-api
💎 Learning Ruby! 💎

# `[GET]` /mountains

```bash
curl -X GET "http://localhost:4567/mountains?name=mont-blanc"
```

# `[POST]` /mountains
```bash
curl -X POST "http://localhost:4567/mountains" -H "Content-Type: application/json" -d '{"name": "la-meije", "title": "La Meije", "altitude": 3984}'
```