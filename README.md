# README

- Lapras is a Spotify client.
- It loves crossing the sea with people and Pokémon on its back. It understands human speech, and also sings (or screams) to communicate with others of its species.

![lapras](https://i.pinimg.com/originals/5b/43/7e/5b437e8d0da29c97f1d0187cbee03836.gif)


## Development

### Running the code

### Starting the container
```
docker compose up -d
docker exec -ti lapras /bin/bash
rails server -p 3000 -b '0.0.0.0'
```